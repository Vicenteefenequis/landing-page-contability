#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  echo "Arquivo .env não encontrado. Copie .env.example para .env e ajuste as variáveis." >&2
  exit 1
fi

set -o allexport
source .env
set +o allexport

WORDPRESS_URL=${WORDPRESS_URL:-http://localhost:8080}
WORDPRESS_TITLE=${WORDPRESS_TITLE:-"Contabilidade para Condomínios"}
WORDPRESS_ADMIN_USER=${WORDPRESS_ADMIN_USER:-admin}
WORDPRESS_ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD:-admin}
WORDPRESS_ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL:-"contato@example.com"}

# Garante que os containers principais estejam rodando
docker compose up -d db wordpress

echo "Aguardando WordPress inicializar..."
docker compose run --rm wpcli bash ./artifacts/wpcli-bootstrap.sh \
  "$WORDPRESS_URL" \
  "$WORDPRESS_ADMIN_USER" \
  "$WORDPRESS_ADMIN_PASSWORD" \
  "$WORDPRESS_ADMIN_EMAIL" \
  "$WORDPRESS_TITLE"

echo "Instalação concluída. Acesse $WORDPRESS_URL/wp-admin com o usuário $WORDPRESS_ADMIN_USER"
