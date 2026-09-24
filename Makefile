# DEV NETWORK
NETWORK ?= carton-bridge
MODE ?= rocket

.PHONY: build up down shell teardown logs status network bootstrap

network:
	@docker network create $(NETWORK) 2>/dev/null || true

bootstrap: network
	@echo "🚀 Bootstrapping Cartoniuum..."
	@NETWORK=$(NETWORK) $(MAKE) -C yard up
	@NETWORK=$(NETWORK) $(MAKE) -C litterbox up
	@NETWORK=$(NETWORK) $(MAKE) -C carton up
	@echo "✨ Bootstrap complete! The fleet is online."
	@echo "   Dashboard: https://carton/"

build up down shell teardown logs status: network
	@if [ -d "$(MODE)" ]; then \
		NETWORK=$(NETWORK) $(MAKE) -C $(MODE) $@; \
	else \
		echo "Error: Mode directory '$(MODE)' does not exist."; \
		exit 1; \
	fi

root-teardown:
	@docker network rm $(NETWORK) 2>/dev/null || true
	@echo "💥 Dev Cartoniuum bridge destroyed."
