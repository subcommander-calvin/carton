NETWORK = carton-bridge
PROFILE ?= calvin

build:
	@if [ ! -f "users/$(PROFILE)/Dockerfile" ]; then \
		echo "Error: No Dockerfile found for profile $(PROFILE) at users/$(PROFILE)/Dockerfile"; \
		exit 1; \
	fi
	$(eval MANIFEST_UID := $(shell jq -r '.crew["$(PROFILE)"].uid // "host"' ../users.json))
	$(eval HOST_UID := $(shell id -u))
	$(eval HOST_GID := $(shell id -g))
	$(eval USER_UID := $(if $(filter host,$(MANIFEST_UID)),$(HOST_UID),$(MANIFEST_UID)))
	$(eval USER_GID := $(if $(filter host,$(MANIFEST_UID)),$(HOST_GID),$(MANIFEST_UID)))
	docker build \
		--build-arg USER_UID=$(USER_UID) \
		--build-arg USER_GID=$(USER_GID) \
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
