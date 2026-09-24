IMAGE := carton-rocket
CONTAINER := rocket
NETWORK ?= carton-bridge
HOST_UID := $(shell id -u)
HOST_USER := $(shell whoami)

.PHONY: build up down shell logs

build:
	docker build --build-arg HOST_UID=$(HOST_UID) --build-arg HOST_USER=$(HOST_USER) -t $(IMAGE) .

up: build
	docker run -d --name $(CONTAINER) --network $(NETWORK) -v $(CURDIR):/workspace $(IMAGE)
	@echo "🚀 $(CONTAINER) is up on $(NETWORK)."

down:
	docker stop $(CONTAINER) 2>/dev/null && docker rm $(CONTAINER) 2>/dev/null || true

shell:
	docker exec -it $(CONTAINER) su - $(HOST_USER)
