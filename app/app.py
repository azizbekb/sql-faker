"""Fake user generator web UI.

The application only renders HTML: every fake value comes from the
SQL Faker stored procedures (see db/ and docs/README.md).
"""
import os
import random
from pathlib import Path

import markdown
from flask import Flask, abort, jsonify, render_template, request
from psycopg.rows import dict_row
from psycopg_pool import ConnectionPool

BATCH_SIZE = 10
MAX_SEED = 2**63 - 1
DOCS_PATH = Path(__file__).resolve().parent.parent / "docs" / "README.md"

app = Flask(__name__)
pool = ConnectionPool(
    os.environ.get("DATABASE_URL", "dbname=faker"),
    min_size=1,
    max_size=int(os.environ.get("DB_POOL_SIZE", "5")),
    kwargs={"row_factory": dict_row, "autocommit": True},
    open=False,
)


def query(sql, params=()):
    with pool.connection() as conn:
        return conn.execute(sql, params).fetchall()


def get_locales():
    return query("SELECT code, name FROM locales ORDER BY code")


def parse_args(locales):
    codes = [l["code"] for l in locales]
    locale = request.args.get("locale", codes[0] if codes else "")
    if locale not in codes:
        abort(400, f"Unknown locale {locale!r}")
    try:
        seed = int(request.args.get("seed", random.randint(0, 99_999_999)))
        batch = int(request.args.get("batch", 0))
    except ValueError:
        abort(400, "seed and batch must be integers")
    if not -MAX_SEED <= seed <= MAX_SEED or batch < 0:
        abort(400, "seed or batch out of range")
    return locale, seed, batch


def fetch_batch(locale, seed, batch):
    return query("SELECT * FROM fk_users(%s, %s, %s, %s)", (locale, seed, batch, BATCH_SIZE))


@app.get("/")
def index():
    locales = get_locales()
    locale, seed, batch = parse_args(locales)
    return render_template(
        "index.html",
        locales=locales,
        locale=locale,
        seed=seed,
        batch=batch,
        users=fetch_batch(locale, seed, batch),
    )


@app.get("/batch")
def batch_rows():
    """HTML rows of one batch, appended by the page on scroll / 'Next batch'."""
    locale, seed, batch = parse_args(get_locales())
    return render_template("_rows.html", users=fetch_batch(locale, seed, batch))


@app.get("/api/users")
def api_users():
    locale, seed, batch = parse_args(get_locales())
    users = fetch_batch(locale, seed, batch)
    for u in users:
        u["latitude"], u["longitude"] = float(u["latitude"]), float(u["longitude"])
        u["height_cm"], u["weight_kg"] = float(u["height_cm"]), float(u["weight_kg"])
    return jsonify(locale=locale, seed=seed, batch=batch, users=users)


@app.get("/api/benchmark")
def api_benchmark():
    locale, _, _ = parse_args(get_locales())
    count = min(max(int(request.args.get("count", 5000)), 1), 50_000)
    return jsonify(query("SELECT * FROM fk_benchmark(%s, %s)", (locale, count))[0])


@app.get("/docs")
def docs():
    html = markdown.markdown(
        DOCS_PATH.read_text(encoding="utf-8"),
        extensions=["fenced_code", "tables", "toc"],
    )
    return render_template("docs.html", content=html)


@app.get("/health")
def health():
    query("SELECT 1")
    return "ok"


pool.open()

if __name__ == "__main__":
    app.run(debug=True, port=int(os.environ.get("PORT", 5000)))
