.PHONY: help docker/*
CONTAINER:=node.local

help:
	@grep -E '^[a-zA-Z\/_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

docker/init: ## initial create react app
	docker-compose run --rm node sh -c "npm install -g create-react-app && create-react-app sample"
docker/up: ## containers up
	docker-compose up -d
docker/logs: ## display containers log
	docker-compose logs -f
docker/stop: ## stop containers
	docker-compose stop
docker/ssh: ## connect in container
	docker exec -it -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(CONTAINER) ash
docker/run/sample: ## run sample application
	docker exec -it $(CONTAINER) ash -c "cd sample && yarn start" 
docker/run/sample/install: ## install sample application
	docker exec -it $(CONTAINER) ash -c "cd sample && yarn install" 
docker/run/react-tutorial: ## run react-tutorial application
	docker exec -it $(CONTAINER) ash -c "cd react-tutorial && yarn start" 
