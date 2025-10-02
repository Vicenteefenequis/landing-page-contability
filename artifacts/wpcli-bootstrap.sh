#!/usr/bin/env bash
# Script para automatizar instalação e configuração básica da landing page via WP-CLI.
# Uso: ./wpcli-bootstrap.sh dominio.com admin senha forte email

set -euo pipefail

SITE_URL=${1:-"https://dominio-teste.com"}
ADMIN_USER=${2:-admin}
ADMIN_PASS=${3:-"SenhaMuitoForte!"}
ADMIN_EMAIL=${4:-"contato@dominio.com"}
SITE_TITLE=${5:-"Contabilidade para Condomínios"}

wp core download --skip-content

wp config create \
  --dbname=wordpress \
  --dbuser=wordpress \
  --dbpass=wordpress \
  --dbhost=localhost \
  --skip-check

wp core install \
  --url="$SITE_URL" \
  --title="$SITE_TITLE" \
  --admin_user="$ADMIN_USER" \
  --admin_password="$ADMIN_PASS" \
  --admin_email="$ADMIN_EMAIL"

wp option update blogdescription "Soluções contábeis completas para síndicos e administradoras"
wp rewrite structure '/%postname%/'

wp theme install twentytwentyfour --activate
wp plugin install contact-form-7 wp-mail-smtp updraftplus --activate

# Criar página de landing page a partir do template HTML.
if [ -f "artifacts/landing-pattern.html" ]; then
  PAGE_ID=$(wp post create artifacts/landing-pattern.html \
    --post_type=page \
    --post_status=publish \
    --post_title="$SITE_TITLE" \
    --porcelain)
  wp option update show_on_front page
  wp option update page_on_front "$PAGE_ID"
fi

echo "Instalação concluída. Acesse $SITE_URL/wp-admin com usuário $ADMIN_USER"
