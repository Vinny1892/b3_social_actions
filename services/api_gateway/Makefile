SHELL=/bin/bash
DOCKER_NETWORK := b3-social-actions
DOCKER_NETWORK_IP := 10.0.20.0/10

.PHONY: help
help:  ## Show the help
	@echo "██████╗ ███████╗ ██████╗ ██╗   ██╗██╗     ██╗   ██╗███████╗"
	@echo "██╔══██╗██╔════╝██╔════╝ ██║   ██║██║     ██║   ██║██╔════╝"
	@echo "██████╔╝█████╗  ██║  ███╗██║   ██║██║     ██║   ██║███████╗"
	@echo "██╔══██╗██╔══╝  ██║   ██║██║   ██║██║     ██║   ██║╚════██║"
	@echo "██║  ██║███████╗╚██████╔╝╚██████╔╝███████╗╚██████╔╝███████║"
	@echo "╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.DEFAULT_GOAL := help


.PHONY: create-network
create-network:
	@docker network inspect $(DOCKER_NETWORK) >/dev/null 2>&1 || docker network create --driver bridge --subnet=$(DOCKER_NETWORK_IP) $(DOCKER_NETWORK)

.PHONY: create-common-services
create-common-services: create-network ## deploy all services necessary for using stack
	@docker-compose -f  ../../docker-compose.yml  up -d

.PHONY: init
init: create-common-services   ## deploy all services necessary for using stack and create network


.PHONY: build-no-cache
build-no-cache: ## build image with any cache
	@docker-compose build --no-cache --pull ${BUILD_ARGS}

.PHONY: up
up: ## Shell developer
	@docker-compose --verbose up

.PHONY: up-daemon
up-daemon: ## Shell developer
	@docker-compose up -d

.PHONY: restart
restart: ## restart service
	@docker-compose restart

.PHONY: stop
stop: ## stop service
	@docker-compose stop

.PHONY: down
down: ## down service
	@docker-compose down

.PHONY: shell
shell: ## Shell developer
	@docker exec -ti api-gateway bash

.PHONY: test-cov
test-cov: ## test-cov
	@docker exec -ti api-dev pytest --cov=crawler_benefit  --cov-report=html  crawler_benefit/tests

.PHONY: test
test: ## test
	@docker exec -ti api-dev pytest


.PHONY: redis-shell
redis-shell: ## enter in redis shell
	@docker-compose -f ../../docker-compose.yml exec redis redis-cli