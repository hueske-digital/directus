COMPOSE := docker compose --env-file .env
BASE := -f docker-compose.yml
POCKETID := -f docker-compose.pocketid.yml

.PHONY: init up up-pocketid recreate recreate-pocketid pull restart down logs ps config

init:
	@if [ -f .env ]; then \
		echo "Error: .env already exists"; \
		exit 1; \
	fi
	@echo "=== Directus Setup ==="
	@read -p "Admin E-Mail: " email; \
	read -p "Admin Passwort: " password; \
	read -p "Public URL (z.B. https://api.domain.de): " url; \
	secret=$$(openssl rand -hex 16); \
	echo "SECRET=$$secret" > .env; \
	echo "ADMIN_EMAIL=$$email" >> .env; \
	echo "ADMIN_PASSWORD=$$password" >> .env; \
	echo "PUBLIC_URL=$$url" >> .env
	@echo "=== .env created ==="
	@echo "Run 'make up' to start Directus"

up:
	$(COMPOSE) $(BASE) up -d

up-pocketid:
	$(COMPOSE) $(BASE) $(POCKETID) up -d

pull:
	$(COMPOSE) $(BASE) pull

restart:
	$(COMPOSE) $(BASE) restart

recreate:
	$(COMPOSE) $(BASE) up -d --force-recreate

recreate-pocketid:
	$(COMPOSE) $(BASE) $(POCKETID) up -d --force-recreate

down:
	$(COMPOSE) $(BASE) down

logs:
	$(COMPOSE) $(BASE) logs -f --tail=200

ps:
	$(COMPOSE) $(BASE) ps

config:
	$(COMPOSE) $(BASE) $(POCKETID) config