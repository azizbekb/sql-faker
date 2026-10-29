"""Measures fake user generation speed (users / second).

Two measurements per locale:
  * in-database: SELECT fk_benchmark(locale, N)  - pure stored-procedure speed
  * end-to-end:  fetching N users through fk_users() batches from Python,
                 the same way the web application does.
Usage: python scripts/benchmark.py [N] [DATABASE_URL]
"""
import os
import sys
import time

import psycopg

N = int(sys.argv[1]) if len(sys.argv) > 1 else 100_000
DSN = sys.argv[2] if len(sys.argv) > 2 else os.environ.get("DATABASE_URL", "dbname=faker")
BATCH = 1000

with psycopg.connect(DSN, autocommit=True) as conn:
    print(conn.execute("SELECT version()").fetchone()[0])
    print(f"{'locale':8} {'mode':12} {'users':>9} {'seconds':>9} {'users/s':>9}")
    for (locale,) in conn.execute("SELECT code FROM locales ORDER BY code").fetchall():
        _, users, secs, ups = conn.execute(
            "SELECT * FROM fk_benchmark(%s, %s)", (locale, N)).fetchone()
        print(f"{locale:8} {'in-database':12} {users:>9} {secs:>9} {ups:>9}")

        t0, fetched = time.perf_counter(), 0
        for b in range(N // BATCH):
            fetched += len(conn.execute(
                "SELECT * FROM fk_users(%s, 1, %s, %s)", (locale, b, BATCH)).fetchall())
        secs = time.perf_counter() - t0
        print(f"{locale:8} {'end-to-end':12} {fetched:>9} {secs:>9.3f} {fetched / secs:>9.0f}")
