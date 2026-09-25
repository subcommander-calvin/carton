NETWORK = carton-bridge
PROFILE ?= calvin

build:
	@if [ ! -f "users/$(PROFILE)/Dockerfile" ]; then \
		echo "Error: No Dockerfile found for profile $(PROFILE) at users/$(PROFILE)/Dockerfile"; \
		exit 1; \
	fi
	docker build \
		--build-arg USER_UID=$(shell id -u) \
		--build-arg USER_GID=$(shell id -g) \
		-t lifepod-$(PROFILE) users/$(PROFILE)

up: build
	mkdir -p $(CURDIR)/users/$(PROFILE)
	docker run -d --name $(PROFILE) --network $(NETWORK) \
		-v $(CURDIR)/users/$(PROFILE):/home/$(PROFILE) \
		-v $(CURDIR)/..:/workspace \
		lifepod-$(PROFILE)
	@echo "🚀 Lifepod profile '$(PROFILE)' is up on $(NETWORK)."

down:
	docker stop $(PROFILE) || true
	docker rm $(PROFILE) || true
