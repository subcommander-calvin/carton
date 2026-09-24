IMAGE := carton-nanobot
CONTAINER := litterbox
NETWORK ?= carton-bridge

.PHONY: build up down shell logs status

build:
	docker build -t $(IMAGE) $(CURDIR)

up: build
	@mkdir -p $(CURDIR)/srv/cat/workspace $(CURDIR)/srv/cat/config
	docker run -d --name $(CONTAINER) --network $(NETWORK) \
		-v $(CURDIR)/srv/cat/workspace:/srv/litterbox/workspace \
		-v $(CURDIR)/srv/cat/config:/root/.nanobot \
		$(IMAGE)
	@echo "🏗️ $(CONTAINER) is up on $(NETWORK)."

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
