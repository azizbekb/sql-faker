FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client && rm -rf /var/lib/apt/lists/*
WORKDIR /srv
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV PORT=8000
# INIT_DB=1 loads/refreshes the SQL library on start (idempotent: schema is recreated)
CMD ["sh", "-c", "if [ \"$INIT_DB\" = 1 ]; then scripts/init_db.sh \"$DATABASE_URL\"; fi; exec gunicorn --timeout 120 -w ${WEB_CONCURRENCY:-2} -b 0.0.0.0:$PORT --chdir app app:app"]
