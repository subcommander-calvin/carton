IMAGE := caddy:latest
CONTAINER := carton
NETWORK ?= carton-bridge

.PHONY: up down shell logs status

up:
	@mkdir -p $(abspath ../yard/srv/caddy/data)
	@mkdir -p $(abspath ../yard/srv/caddy/config)
	docker run -d --name $(CONTAINER) --network $(NETWORK) \
		-p 80:80 \
		-p 443:443 \
		-v $(CURDIR)/Caddyfile:/etc/caddy/Caddyfile \
		-v $(CURDIR)/html:/var/www/html \
		-v $(abspath ../yard/srv/caddy/data):/data \
		-v $(abspath ../yard/srv/caddy/config):/config \
		$(IMAGE)
	@echo "🌐 $(CONTAINER) is up on $(NETWORK)."
	@echo "Mapped to host ports 80 and 443."

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
