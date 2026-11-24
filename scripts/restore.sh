#!/usr/bin/env bash
set -euo pipefail
export MSYS_NO_PATHCONV=1
cd "$(dirname "$0")/.."

DESTINO="backups"
if [ $# -lt 1 ]; then
  echo "Uso: $0 AAAAMMDD-HHMMSS"
  echo "Copias disponibles:"
  ls -1 "$DESTINO"/db_*.sql.gz 2>/dev/null | sed 's/.*db_//;s/\.sql\.gz//' || echo "  (ninguna)"
  exit 0
fi

FECHA="$1"
F_DB="$DESTINO/db_$FECHA.sql.gz"
F_WP="$DESTINO/wp-content_$FECHA.tar.gz"

[ -f "$F_DB" ] && [ -f "$F_WP" ] || { echo "ERROR: No existen ambos ficheros para $FECHA" >&2; exit 1; }

read -r -p "ATENCIÓN: Esto sobrescribirá la BD y wp-content actuales. Escribe SI para continuar: " CONF
[ "$CONF" = "SI" ] || { echo "Cancelado."; exit 1; }

echo "-> Restaurando base de datos..."
gunzip -c "$F_DB" | docker compose exec -T db sh -c 'mariadb -u"$WP_DB_USER" -p"$WP_DB_PASSWORD" "$WP_DB_NAME"'

echo "-> Restaurando wp-content..."
docker compose exec -T wordpress sh -c 'rm -rf /var/www/html/wp-content/*'
docker compose exec -T wordpress tar -xzf - -C /var/www/html < "$F_WP"
docker compose exec -T wordpress chown -R www-data:www-data /var/www/html/wp-content

echo "OK. Restauración completada para $FECHA."