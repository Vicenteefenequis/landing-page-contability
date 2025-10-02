#!/usr/bin/env bash
# Script para automatizar instalação e configuração básica da landing page via WP-CLI.
# Uso: ./wpcli-bootstrap.sh dominio.com admin senha forte email

set -euo pipefail

SITE_URL=${1:-"https://dominio-teste.com"}
ADMIN_USER=${2:-admin}
ADMIN_PASS=${3:-"SenhaMuitoForte!"}
ADMIN_EMAIL=${4:-"contato@dominio.com"}
SITE_TITLE=${5:-"Contabilidade para Condomínios"}

DB_NAME=${DB_NAME:-${WORDPRESS_DB_NAME:-wordpress}}
DB_USER=${DB_USER:-${WORDPRESS_DB_USER:-wordpress}}
DB_PASS=${DB_PASS:-${WORDPRESS_DB_PASSWORD:-wordpress}}
DB_HOST=${DB_HOST:-${WORDPRESS_DB_HOST:-localhost}}

if [ ! -f wp-load.php ]; then
  wp core download --skip-content --force
fi

if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASS" \
    --dbhost="$DB_HOST" \
    --skip-check \
    --force
fi

if ! wp core is-installed >/dev/null 2>&1; then
  wp core install \
    --url="$SITE_URL" \
    --title="$SITE_TITLE" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASS" \
    --admin_email="$ADMIN_EMAIL"
else
  echo "WordPress já instalado, pulando 'wp core install'"
fi

wp option update blogname "$SITE_TITLE"
wp option update blogdescription "Soluções contábeis completas para síndicos e administradoras"
wp rewrite structure '/%postname%/'

wp theme install twentytwentyfour --activate
wp plugin install contact-form-7 wp-mail-smtp updraftplus --activate

# Criar ou atualizar página de landing page a partir do template HTML.
if [ -f "artifacts/landing-pattern.html" ]; then
  SLUG="contabilidade-para-condominios"
  EXISTING_ID=$(wp post list \
    --post_type=page \
    --name="$SLUG" \
    --field=ID \
    --format=ids)

  if [ -n "$EXISTING_ID" ]; then
    PAGE_ID="$EXISTING_ID"
    wp post update "$PAGE_ID" artifacts/landing-pattern.html \
      --post_title="$SITE_TITLE" \
      --post_status=publish
  else
    PAGE_ID=$(wp post create artifacts/landing-pattern.html \
      --post_type=page \
      --post_status=publish \
      --post_title="$SITE_TITLE" \
      --post_name="$SLUG" \
      --porcelain)
  fi

  wp option update show_on_front page
  wp option update page_on_front "$PAGE_ID"
fi

echo "Instalação concluída. Acesse $SITE_URL/wp-admin com usuário $ADMIN_USER"
