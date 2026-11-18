#!/usr/bin/env bash
# Production deploy on the Shaklab AI VPS (/var/www/elsalamoil, systemd unit "elsalam").
# Run by CI over SSH as root:  bash scripts/deploy.sh
set -euo pipefail

APP_DIR="/var/www/elsalamoil"
SERVICE="elsalam"
cd "$APP_DIR"

# Match origin exactly (survives force-pushes; untracked files like .env and public/uploads are kept).
git fetch --prune origin main
git reset --hard origin/main

npm ci --legacy-peer-deps
npx prisma generate
# Migrations in prisma/migrations are stale; schema is synced with db push (refuses data-loss changes).
npx prisma db push --skip-generate
npm run build

chown -R nginx:nginx "$APP_DIR"
systemctl restart "$SERVICE"

# Wait for the app to answer before reporting success.
PORT="$(systemctl show "$SERVICE" -p Environment --value | tr ' ' '\n' | sed -n 's/^PORT=//p')"
for _ in $(seq 1 30); do
  if curl -fsS -o /dev/null "http://127.0.0.1:${PORT:-3410}/"; then
    echo "Deploy OK: $(git log --oneline -1)"
    exit 0
  fi
  sleep 2
done
echo "App did not become healthy after restart" >&2
journalctl -u "$SERVICE" -n 50 --no-pager >&2
exit 1
