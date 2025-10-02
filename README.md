# Landing page WordPress — Contabilidade para Condomínios

Este repositório reúne instruções operacionais, comandos, checklists e artefatos prontos para lançar uma landing page profissional em WordPress no nicho de contabilidade para condomínios usando apenas soluções gratuitas.

## Conteúdo
- `docs/rotas-wordpress-contabilidade.md`: três rotas completas (WordPress.com, hospedagem compartilhada gratuita e VPS gratuita com Docker) com passo a passo de DevOps, DNS e publicação.
- `artifacts/landing-pattern.html`: layout em blocos Gutenberg pronto para importar.
- `artifacts/copywriting-landing.md`: textos finalizados para todas as seções da landing page.
- `artifacts/customizer.css`: estilo adicional para aplicar a identidade visual.
- `artifacts/wpcli-bootstrap.sh`: script para automatizar instalação e configuração via WP-CLI.
- `docker-compose.yml` e `.env.example`: infraestrutura Docker pronta para subir WordPress localmente.
- `bin/bootstrap.sh`: orquestração da instalação automática dentro dos containers.

## Como usar
1. Escolha a rota que melhor atende ao seu cenário (tempo, necessidade de domínio, controle de infraestrutura).
2. Siga o passo a passo correspondente em `docs/rotas-wordpress-contabilidade.md`.
3. Utilize os artefatos fornecidos para acelerar a personalização e publicação da página.

Todos os recursos indicados são gratuitos no momento da elaboração deste guia. Revise termos de uso e limites dos provedores antes de publicar em produção.

## Ambiente local com Docker Compose

1. Instale Docker e Docker Compose (ou Docker Desktop) na sua máquina.
2. Copie o arquivo de variáveis: `cp .env.example .env` e ajuste senhas, porta e domínio desejado (`WORDPRESS_URL`).
3. Adicione o domínio configurado ao arquivo `hosts` do seu sistema, por exemplo: `127.0.0.1 landing.localhost`.
4. Suba os containers e execute o bootstrap automático:

   ```bash
   ./bin/bootstrap.sh
   ```

5. Aguarde a finalização do script. Acesse `http://landing.localhost/wp-admin` (ou o domínio definido) com as credenciais do `.env` para revisar o site.
6. Para encerrar o ambiente, execute `docker compose down`. Para limpar volumes, use `docker compose down -v`.

O script instala WordPress, ativa o tema Twenty Twenty-Four, configura os plugins necessários, importa o layout Gutenberg e define a landing page como página inicial utilizando o WP-CLI dentro do container.
