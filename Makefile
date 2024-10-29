.PHONY: help docker/*
CONTAINER:=node.local

help:
	@grep -E '^[a-zA-Z\/_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

docker/init/next: ## initial create next app
	docker compose run --rm node sh -c "npx create-next-app@latest create-next-app"
docker/init/react: ## initial create react app
	docker compose run --rm node sh -c "npx create-react-app create-react-app --template typescript"
	docker compose run --rm node sh -c "cd create-react-app; npx -p @storybook/cli sb init"
	docker compose run --rm node sh -c "cd create-react-app; npm install --save react-router-dom"
docker/up: ## containers up
	docker compose up -d
docker/logs: ## display containers log
	docker compose logs -f
docker/stop: ## stop containers
	docker compose stop
docker/ssh: ## connect in container
	docker exec -it -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(CONTAINER) bash
docker/run/sample: ## run sample application
	docker compose run --rm node sh -c "cd sample; yarn start"
