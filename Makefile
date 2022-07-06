# usage:
#	make build - build docker images

# Default version
VERSION:=latest

# Registry
REGISTRY_PREFIX=docker.io/smoreno

# Image names
NAME_SERVER=simpleserver
IMAGE_SERVER=$(REGISTRY_PREFIX)/$(NAME_SERVER):$(VERSION)
NAME_CLIENT=simpleclient
IMAGE_CLIENT=$(REGISTRY_PREFIX)/$(NAME_CLIENT):$(VERSION)

all: clean build run

build:
	-echo "Building image $(IMAGE_SERVER)"
	docker build --pull --no-cache -t $(IMAGE_SERVER) server
	-echo "Building image $(IMAGE_CLIENT)"
	docker build --pull --no-cache -t $(IMAGE_CLIENT) client

push: build
	-echo "Pushing image $(IMAGE_SERVER)"
	docker push $(IMAGE_SERVER)
	-echo "Pushing image $(IMAGE_CLIENT)"
	docker push $(IMAGE_CLIENT)

stop:
	-docker rm -f client server

clean: stop
	-docker rmi -f $(IMAGE_CLIENT) $(IMAGE_SERVER)
	-docker network rm clientserver

run:
	-docker network create -d bridge clientserver
	docker run --network clientserver -d --name server $(IMAGE_SERVER)
	docker run --network clientserver -d --name client $(IMAGE_CLIENT)
