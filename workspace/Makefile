IMAGE := bytemark/webdav
CONTAINER := workspace
NETWORK ?= carton-bridge

.PHONY: up down shell logs status

up:
	@mkdir -p $(CURDIR)/srv/data
	docker run -d --name $(CONTAINER) --network $(NETWORK) \
		-e AUTH_TYPE=Basic \
		-e USERNAME=carton \
		-e PASSWORD=carton \
		-v $(CURDIR)/srv/data:/var/lib/dav/data \
		$(IMAGE)
	@echo "🏗️ $(CONTAINER) is up on $(NETWORK)."

down:
	docker stop $(CONTAINER) 2>/dev/null && docker rm $(CONTAINER) 2>/dev/null || true
	@echo "🛑 $(CONTAINER) has been removed."

shell:
	docker exec -it $(CONTAINER) /bin/sh

logs:
	docker logs -f $(CONTAINER)

status:
	@echo "Container IP on $(NETWORK):"
	@docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(CONTAINER) 2>/dev/null || echo "Not running"
