# DEV NETWORK
NETWORK ?= carton-bridge
MODE ?= rocket

.PHONY: build up down shell teardown logs status network

network:
	@docker network create $(NETWORK) 2>/dev/null || true

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
