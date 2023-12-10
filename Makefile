.DEFAULT_GOAL := build
.PHONY = build build-docker

NAME=tiny_http_server
IMAGE_NAME ?= mukhumaev/${NAME}
IMAGE_TAG ?= "latest"
LOLAL_PORT ?= 8080
CONTAINER_PORT ?= 8080

build:
	go build .

build-docker:
	docker build . \
		-t ${IMAGE_NAME}:${IMAGE_TAG} \

build-and-push-docker:
	docker build . \
		-t ${IMAGE_NAME}:${IMAGE_TAG} \
		--push

build-and-push-docker-multiple-platform:
	docker buildx build \
		--platform linux/amd64,linux/arm64,linux/arm/v7 \
		-t ${IMAGE_NAME}:${IMAGE_TAG} \
		--push .

test-run:
	docker run -it --rm \
		--name ${NAME} \
		-v '.':/data \
		-p ${LOLAL_PORT}:${CONTAINER_PORT} \
		${IMAGE_NAME}:${IMAGE_TAG}

clean:
	rm -rf ${NAME}
	docker rmi ${IMAGE_NAME}:${IMAGE_TAG}