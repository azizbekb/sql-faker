#!/usr/bin/env bash
# Loads the whole SQL Faker library into a database.
# Usage: scripts/init_db.sh [psql connection string]   (default: $DATABASE_URL or "faker")
set -euo pipefail
DB="${1:-${DATABASE_URL:-faker}}"
cd "$(dirname "$0")/../db"
for f in [0-9][0-9]_*.sql; do
    echo "-> $f"
    psql -q -v ON_ERROR_STOP=1 -d "$DB" -c "SET client_min_messages = warning" -f "$f"
done
