IMAGE := carton-spaceship
CONTAINER := spaceship
NETWORK ?= carton-bridge
HOST_UID := $(shell id -u)
HOST_USER := $(shell whoami)
USERS_DIR := $(abspath ../lifepod/users)

# We resolve the symlinks to mount the actual drives
STARDRIVE_PATH := $(shell readlink -f ../rocket)
SAUCER_PATH := $(shell readlink -f ../saucer)

.PHONY: build up down shell logs

build:
	docker build --build-arg HOST_UID=$(HOST_UID) --build-arg HOST_USER=$(HOST_USER) -t $(IMAGE) .

up: build
	@mkdir -p $(USERS_DIR)
	docker run -d --name $(CONTAINER) --network $(NETWORK) \
		-v $(STARDRIVE_PATH):/stardrive \
		-v $(SAUCER_PATH):/saucer \
		-v $(USERS_DIR):/home \
		$(IMAGE)
	@echo "🌌 $(CONTAINER) is up on $(NETWORK)."

down:
	docker stop $(CONTAINER) 2>/dev/null && docker rm $(CONTAINER) 2>/dev/null || true

shell:
	docker exec -it $(CONTAINER) su - $(HOST_USER)
