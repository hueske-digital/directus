COMPOSE := docker compose --env-file .env
BASE := -f docker-compose.yml
POCKETID := -f docker-compose.pocketid.yml

.PHONY: up up-pocketid recreate recreate-pocketid pull restart down logs ps config

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