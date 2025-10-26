# Rotas para publicar landing page "Contabilidade para Condomínios" (100% stack gratuito)

Este guia entrega três rotas completas para publicar uma landing page WordPress profissional para o nicho de contabilidade para condomínios, usando apenas recursos gratuitos. Cada rota inclui arquitetura, checklist operacional, comandos, automações sugeridas, orientações de DNS e indicação de onde aplicar os artefatos disponibilizados neste repositório.

## Artefatos fornecidos

| Arquivo | Descrição | Uso |
| --- | --- | --- |
| `artifacts/copywriting-landing.md` | Texto completo da landing page com blocos prontos para copiar/colar. | Copiar para o editor de blocos ou páginas.
| `artifacts/landing-pattern.html` | Template em blocos Gutenberg (HTML) para importação via Editor do Site ou bloco “Código”. | Rota 1 e 2.
| `artifacts/customizer.css` | CSS customizado para ajustar tipografia, cores e espaçamentos. | Colar em Aparência → Personalizar → CSS Adicional.
| `artifacts/wpcli-bootstrap.sh` | Script shell com comandos WP-CLI para automatizar instalação/configuração. | Rota 2 e 3.

> **Tema recomendado (gratuito):** [Twenty Twenty-Four](https://wordpress.org/themes/twentytwentyfour/) (nativo) ou [Astra](https://wordpress.org/themes/astra/). Ambos suportam Editor de Blocos.

---

## Rota 1 — WordPress.com (plano gratuito)

### Quando usar
- Deseja a opção mais rápida, sem servidor próprio.
- Volume de visitas moderado (até ~10k/mês) e sem plugins premium.
- OK com domínio `nomedasuaempresa.wordpress.com` ou com DNS apontando via domínio personalizado (pago à parte no registrador, sem custo adicional no WordPress.com para mapear).

### Visão geral da arquitetura
- WordPress.com Free Site
- Tema padrão Twenty Twenty-Four (ou similar)
- Customizações realizadas pelo Editor do Site.

### Pré-requisitos
- Conta gratuita em [wordpress.com](https://wordpress.com/start)
- Domínio registrado em provedor externo (opcional, para DNS).

### Passo a passo
1. **Criar o site**
   - Acesse `https://wordpress.com/start` → escolha a categoria “Negócios”.
   - Informe o nome “Contabilidade para Condomínios” e escolha o plano gratuito.
   - Escolha o endereço gratuito (ex: `condominioscontabeis.wordpress.com`).

2. **Aplicar tema e layout**
   - Dashboard WordPress.com → Aparência → Editor do Site.
   - Clique em “Modelos” → “Página” → “Adicionar modelo personalizado”.
   - Mude para “Editor de Código” (3 pontos ⋮ → Editor de Código) e cole o conteúdo de `artifacts/landing-pattern.html`.
   - Ajuste cores/branding conforme necessário.

3. **Inserir copywriting**
   - Cada bloco já contém placeholders; substitua pelos textos de `artifacts/copywriting-landing.md` conforme os comentários `[COLE TEXTO...]` no template.

4. **Aplicar CSS adicional**
   - Aparência → Personalizar → CSS adicional → cole o conteúdo de `artifacts/customizer.css`.

5. **Configurar menus e página inicial**
   - Configurações → Leitura → Página inicial → selecionar a página criada.
   - Aparência → Menus → definir links de âncora (#servicos, #processo, etc.).

6. **Ativar funcionalidades gratuitas importantes**
   - Jetpack Stats (ativado por padrão).
   - Configurar Formulário de contato usando bloco “Formulário”.

7. **Checklist pré-publicação**
   - [ ] Conteúdo revisado com nome e dados do escritório.
   - [ ] Links do menu âncora funcionando.
   - [ ] Formulário de contato configurado com e-mail válido.
   - [ ] SEO básico (Configurações → Tráfego → Título/Slogan/Ícone do site).

8. **Publicar**
   - Editor do Site → Publicar → confirmar.

### DNS e domínio personalizado (opcional)
1. Registre o domínio em provedor gratuito ou de baixo custo (Freenom, Cloudflare Registrar, etc.).
2. No painel WordPress.com: Configurações → Domínios → “Adicionar domínio que você já possui” → “Mapear domínio”.
3. Atualize os nameservers do domínio para os fornecidos pelo WordPress.com.
4. Aguarde propagação (até 24h). Use `nslookup seu-dominio.com` para verificar.

### Operação contínua
- Revisar formulário mensalmente.
- Exportar stats via Jetpack sem custo.
- Backup manual via Ferramentas → Exportar (XML).

---

## Rota 2 — Hospedagem compartilhada gratuita (InfinityFree / 000webhost)

### Quando usar
- Precisa de domínio personalizado sem custo recorrente na plataforma.
- Deseja instalar plugins adicionais gratuitos (ex: Contact Form 7, WP Mail SMTP).

### Visão geral da arquitetura
- Hospedagem: [InfinityFree](https://www.infinityfree.com/) (cPanel alternativo) ou [000webhost](https://www.000webhost.com/).
- Banco: MySQL gratuito incluso.
- Deploy via File Manager + WP-CLI (via cron shell) ou upload manual.

### Pré-requisitos
- Conta gratuita criada na hospedagem escolhida.
- Domínio próprio apontado para os nameservers da hospedagem (ex: `ns1.epizy.com`).
- Acesso SSH (InfinityFree não provê SSH; usaremos scripts `wp-cli` via PHP). Para automação, recomenda-se instalar WordPress localmente, zipar e enviar.

### Passo a passo (InfinityFree)
1. **Criar conta e domínio**
   - Crie conta → “Create Account” → selecione “Own Domain” → informe domínio.
   - Aponte nameservers do domínio para os informados (ex: `ns1.epizy.com`, `ns2.epizy.com`).

2. **Criar banco de dados**
   - Client Area → Manage → MySQL Databases → criar base e usuário (anote credenciais).

3. **Fazer upload do WordPress**
   - Baixe WordPress (`https://wordpress.org/latest.zip`).
   - Descompacte localmente.
   - Edite `wp-config.php` com as credenciais do banco.
   - Opcional: rode o script `artifacts/wpcli-bootstrap.sh` localmente (ajuste URL/site title) para pré-configurar a instalação.
   - Compacte novamente e envie via “File Manager” → Upload no diretório `htdocs`.

4. **Executar instalação**
   - Acesse `https://seu-dominio.com/wp-admin/install.php` → finalize assistente.

5. **Importar landing page**
   - Instale o tema Twenty Twenty-Four.
   - Ferramentas → Importar → “WordPress” → instale o importador.
   - Gere um arquivo `.xml` via `artifacts/wpcli-bootstrap.sh` (linha `wp export`). Carregue para importar páginas.
   - Alternativamente, crie página → editor de blocos → cole `artifacts/landing-pattern.html` e substitua textos.

6. **Adicionar CSS**
   - Aparência → Personalizar → CSS Adicional → cole `artifacts/customizer.css`.

7. **Formulário de contato**
   - Instale plugin gratuito “Contact Form 7”.
   - Crie formulário com campos: Nome, E-mail, Telefone, Condomínio, Mensagem.
   - Adicione shortcode no bloco “Shortcode” onde indicado.

8. **Configurar SMTP gratuito**
   - Crie conta [Brevo](https://www.brevo.com/) (free 300 emails/dia).
   - Verifique domínio e configure DNS (TXT e CNAME) conforme painel Brevo.
   - Plugin “WP Mail SMTP” → SMTP → host `smtp-relay.brevo.com`, porta 587 TLS.

9. **Checklist pré-go-live**
   - [ ] SSL ativado via painel (Let’s Encrypt automático).
   - [ ] Formulário testado (usar e-mail real).
   - [ ] Página definida como inicial (Configurações → Leitura).
   - [ ] Backups: baixe arquivos + export DB via phpMyAdmin.

### DNS
- Nameservers apontam para InfinityFree.
- Para e-mail profissional, use serviço gratuito como [Zoho Mail Free]. Atualize registros MX conforme instruções do Zoho.
- Verifique propagação: `dig @1.1.1.1 seu-dominio.com ns +short` e `dig seu-dominio.com mx`.

### Automação (opcional)
- Configure cron job no painel: `php -q /home/username/htdocs/wp-cron.php` a cada 15 min.
- Para backup automático, use plugin “UpdraftPlus” (gratuito) conectado ao Google Drive.

---

## Rota 3 — WordPress autogerenciado em VPS gratuita (Oracle Cloud Free + Docker Compose)

### Quando usar
- Necessário controle total sobre servidor e stack.
- Deseja pipelines CI/CD e automações DevOps.

### Visão geral da arquitetura
- VPS: Oracle Cloud Free Tier (VM.Standard.E2.1.Micro, 1GB RAM)
- Stack Docker Compose: `wordpress:latest` + `mariadb:10.6` + `nginx` reverse proxy + `certbot` (Let’s Encrypt).
- Deploy automatizado via GitHub Actions (gratuito) usando SSH + rsync.

### Pré-requisitos
- Conta Oracle Cloud (Free Tier ativa).
- Domínio próprio gerenciado pela Cloudflare (plano free) para DNS e SSL.
- Chave SSH gerada localmente.

### Passo a passo
1. **Provisionar VPS**
   - Oracle Cloud → Compute → Instances → Create → imagem `Canonical Ubuntu 22.04 Minimal`.
   - Escolha shape `VM.Standard.E2.1.Micro` (gratuito).
   - Adicione chave pública SSH.
   - Abra portas 80 e 443 em “Virtual Cloud Network” → Security Lists.

2. **Preparar servidor**
   ```bash
   ssh ubuntu@IP_DA_VPS
   sudo apt update && sudo apt upgrade -y
   sudo apt install -y docker.io docker-compose-plugin git ufw
   sudo usermod -aG docker $USER
   newgrp docker
   sudo ufw allow OpenSSH
   sudo ufw allow 80/tcp
   sudo ufw allow 443/tcp
   sudo ufw enable
   ```

3. **Clonar este repositório ou criar diretório do projeto**
   ```bash
   git clone https://github.com/SEU_USUARIO/landing-page-contability.git
   cd landing-page-contability
   ```

4. **Configurar variáveis**
   - Copie `.env.example` (crie arquivo) com conteúdo:
     ```env
     WORDPRESS_DB_PASSWORD=senha-segura
     WORDPRESS_TABLE_PREFIX=wp_
     WORDPRESS_DOMAIN=contabilidadecondominios.com.br
     ```
   - Ajuste domínio e senha.

5. **Criar arquivo `docker-compose.yml`**
   Utilize o conteúdo abaixo (salve na VPS):
   ```yaml
   version: "3.9"
   services:
     db:
       image: mariadb:10.6
       restart: unless-stopped
       environment:
         MYSQL_DATABASE: wordpress
         MYSQL_USER: wordpress
         MYSQL_PASSWORD: ${WORDPRESS_DB_PASSWORD}
         MYSQL_ROOT_PASSWORD: ${WORDPRESS_DB_PASSWORD}
       volumes:
         - db_data:/var/lib/mysql
     wordpress:
       image: wordpress:latest
       depends_on:
         - db
       restart: unless-stopped
       environment:
         WORDPRESS_DB_HOST: db:3306
         WORDPRESS_DB_USER: wordpress
         WORDPRESS_DB_PASSWORD: ${WORDPRESS_DB_PASSWORD}
         WORDPRESS_DB_NAME: wordpress
         WORDPRESS_CONFIG_EXTRA: |
           define('WP_HOME','https://${WORDPRESS_DOMAIN}');
           define('WP_SITEURL','https://${WORDPRESS_DOMAIN}');
       volumes:
         - wp_data:/var/www/html
     nginx:
       image: nginx:alpine
       depends_on:
         - wordpress
       ports:
         - "80:80"
         - "443:443"
       volumes:
         - ./nginx/conf.d:/etc/nginx/conf.d
         - ./certbot/www:/var/www/certbot
         - ./certbot/conf:/etc/letsencrypt
         - wp_data:/var/www/html:ro
     certbot:
       image: certbot/certbot
       volumes:
         - ./certbot/www:/var/www/certbot
         - ./certbot/conf:/etc/letsencrypt
   volumes:
     db_data:
     wp_data:
   ```

6. **Configurar Nginx**
   Crie `nginx/conf.d/wordpress.conf` com:
   ```nginx
   server {
     listen 80;
     server_name ${WORDPRESS_DOMAIN};

     location /.well-known/acme-challenge/ {
       root /var/www/certbot;
     }

     location / {
       return 301 https://$host$request_uri;
     }
   }

   server {
     listen 443 ssl;
     server_name ${WORDPRESS_DOMAIN};

     ssl_certificate /etc/letsencrypt/live/${WORDPRESS_DOMAIN}/fullchain.pem;
     ssl_certificate_key /etc/letsencrypt/live/${WORDPRESS_DOMAIN}/privkey.pem;

     root /var/www/html;
     index index.php;

     location / {
       try_files $uri $uri/ /index.php?$args;
     }

     location ~ \.php$ {
       include fastcgi_params;
       fastcgi_pass wordpress:80;
       fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
     }
   }
   ```

7. **Subir containers**
   ```bash
   docker compose up -d db wordpress
   sleep 30
   docker compose run --rm certbot certonly --webroot -w /var/www/certbot -d ${WORDPRESS_DOMAIN} --email seu-email@dominio.com --agree-tos --non-interactive
   docker compose up -d nginx
   ```

8. **Configurar DNS na Cloudflare**
   - Adicione registro `A` → Host `@` → IP = IP público da VPS.
   - Ative proxy “Proxied” (laranja) para SSL universal.
   - Registro `CNAME` para `www` apontando para `@`.
   - Ajuste regras de página para redirecionar `www` → raiz se necessário.

9. **Instalar WordPress automaticamente**
   ```bash
   docker compose exec wordpress wp core install \
     --url="https://${WORDPRESS_DOMAIN}" \
     --title="Contabilidade para Condomínios" \
     --admin_user=admin \
     --admin_password="SenhaMuitoForte!" \
     --admin_email="financeiro@${WORDPRESS_DOMAIN}"

   docker compose exec wordpress wp theme install twentytwentyfour --activate
   docker compose exec wordpress wp plugin install contact-form-7 updraftplus --activate
   docker compose exec wordpress wp option update blogdescription "Soluções contábeis completas para síndicos e administradoras"
   docker compose exec wordpress wp rewrite structure '/%postname%/'
   ```

10. **Importar landing page via WP-CLI**
    ```bash
    docker compose cp artifacts/landing-pattern.html wordpress:/var/www/html/wp-content/uploads/landing-pattern.html
    docker compose cp artifacts/copywriting-landing.md wordpress:/var/www/html/wp-content/uploads/copywriting-landing.md

    docker compose exec wordpress wp post create artifacts/landing-pattern.html \
      --post_type=page --post_status=publish --post_title="Contabilidade para Condomínios"

    docker compose exec wordpress wp option update show_on_front page
    docker compose exec wordpress wp option update page_on_front $(docker compose exec wordpress wp post list --post_type=page --name=contabilidade-para-condominios --format=ids)
    ```
    > Ajuste o slug conforme necessário. Em alternativa, acesse o painel e cole manualmente o layout.

11. **Checklist de hardening**
    - [ ] Configure backups automáticos (`updraftplus` → Google Drive).
    - [ ] Configure bloqueio de login (plugin gratuito “Limit Login Attempts Reloaded”).
    - [ ] Execute `docker compose exec wordpress wp plugin update --all` mensalmente (automatize via cron).

12. **CI/CD opcional (GitHub Actions)**
    - Adicione workflow `.github/workflows/deploy.yml` com deploy via rsync/ssh (exemplo incluído no repositório se desejar).

### Monitoramento
- Utilize UptimeRobot (free) para monitorar HTTP/HTTPS.
- Configure alertas Cloudflare (Analytics → Email Alerts).

---

## Checklists gerais de conteúdo e QA

### Checklist de Conteúdo
- [ ] Headline clara descrevendo proposta de valor.
- [ ] CTA em destaque com botão “Agendar consultoria gratuita”.
- [ ] Provas sociais (depoimentos).
- [ ] FAQ com pelo menos 4 perguntas frequentes de síndicos.
- [ ] Informações de contato (telefone, WhatsApp, e-mail, endereço).

### Checklist de Performance e SEO
- [ ] Instalar plugin gratuito “LiteSpeed Cache” (quando disponível) ou “Autoptimize”.
- [ ] Otimizar imagens (usar [TinyPNG](https://tinypng.com/)).
- [ ] Configurar Google Analytics 4 via Google Tag Manager.
- [ ] Criar Search Console e enviar sitemap (`/sitemap.xml`).

### Checklist de DNS
- [ ] Registro `A`/`CNAME` apontado corretamente.
- [ ] `TXT` SPF configurado para serviço de e-mail usado.
- [ ] `MX` testado com ferramenta externa (ex: `https://mxtoolbox.com`).
- [ ] Certificado SSL válido (testar em `https://www.ssllabs.com/ssltest/`).

---

## Glossário rápido
- **WP-CLI**: Ferramenta de linha de comando para gerenciar WordPress.
- **Gutenberg**: Editor de blocos nativo do WordPress.
- **DNS**: Sistema de nomes que aponta o domínio para o servidor.
- **SSL**: Certificado digital para habilitar HTTPS.

