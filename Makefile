.DEFAULT_GOAL := help
DOCKER_COMPOSE := $(shell which docker-compose)
MKDIR := $(shell which mkdir)

glpi:
	$(MKDIR) glpi

.PHONY: start
start: glpi ## Start project
	$(DOCKER_COMPOSE) up --build -d
	chmod +X ./setup.sh && ./setup.sh

.PHONY: stop
stop: ## Stop project
	$(DOCKER_COMPOSE) down --remove-orphans

.PHONY: restart
restart: stop start ## Restart project

.PHONY: hard-restart
hard-restart: hard-stop start ## Restart project AND REMOVE ALL VOLUME (except glpi app installation)

.PHONY: hard-stop
hard-stop: ## Stop project AND REMOVE ALL VOLUME (except glpi app installation)
	$(DOCKER_COMPOSE) down --remove-orphans -v


.PHONY: help
help:
	@echo ""
	@echo "$$(cat $(MAKEFILE_LIST) | egrep -h '^[^:]+:[^#]+## .+$$' | sed -e 's/:[^#]*##/:/' -e 's/\(.*\):/\\033[92m\1\\033[0m:/' | sort -d | column -c2 -t -s :)"
	@echo ""
