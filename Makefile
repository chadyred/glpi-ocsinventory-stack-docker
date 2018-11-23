.DEFAULT_GOAL := help
DOCKER_COMPOSE := $(shell which docker-compose)
MKDIR := $(shell which mkdir)
SUB_MAKE := $(shell which make)

glpi:
	$(MKDIR) glpi

reinstall: hard-stop ## Stop and remove all and reinstall all
	rm -f .install
	rm -f .install-plugins
	sudo rm -rf glpi
	$(SUB_MAKE) install

PHONY: install
install: .install ## Install project
	$(SUB_MAKE) .install-plugins

.install: glpi
	$(DOCKER_COMPOSE) up --build -d
	chmod +x ./setup.sh
	./setup.sh
	> .install

.install-plugins: .install
	chmod +x ./plugins.sh
	./plugins.sh
	> .install-plugins

.PHONY: start
start: install ## Start project
	$(DOCKER_COMPOSE) up --build -d

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
