IMAGE := gitea/gitea:latest
CONTAINER := yard
NETWORK ?= carton-bridge

.PHONY: up down shell logs status

up:
	@mkdir -p $(CURDIR)/srv/repos
	docker run -d --name $(CONTAINER) --network $(NETWORK) \
		-p 2222:22 \
		-e USER_UID=$(shell id -u) \
		-e USER_GID=$(shell id -u) \
		-e GITEA__server__DOMAIN=carton \
		-e GITEA__server__ROOT_URL=https://carton/repos/ \
		-v $(CURDIR)/srv/repos:/data \
		-v /etc/timezone:/etc/timezone:ro \
		-v /etc/localtime:/etc/localtime:ro \
		$(IMAGE)
	@echo "🏗️ $(CONTAINER) is up on $(NETWORK)."
	@cd $(CURDIR) && bash init_users.sh &

down:
	docker stop $(CONTAINER) 2>/dev/null && docker rm $(CONTAINER) 2>/dev/null || true
	@echo "🛑 $(CONTAINER) has been removed."

shell:
	docker exec -it $(CONTAINER) /bin/bash

logs:
	docker logs -f $(CONTAINER)

status:
	@echo "Container IP on $(NETWORK):"
	@docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(CONTAINER) 2>/dev/null || echo "Not running"
