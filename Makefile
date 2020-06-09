BERLIOZ_GROUP     := udacity
BERLIOZ_NAME      := fomotograph-api
DOCKER_REPO       := docker.udacity.com/$(BERLIOZ_GROUP)/$(BERLIOZ_NAME)
SERVICE_NAME      := $(BERLIOZ_NAME)
VERSION           ?= $(shell git rev-parse --short HEAD)
export

.PHONY: all build test coveralls deploy

all: build

test:


build: test


coveralls: test


docker: build
	docker build -t $(SERVICE_NAME) .
	docker tag -f $(SERVICE_NAME) $(DOCKER_REPO):$(VERSION)
	docker push $(DOCKER_REPO)

stage:  docker

	BERLIOZ_SUBGROUP=staging \
	SERVICE_NAME=$(SERVICE_NAME)-staging \
	eval echo `sed 's/"/\\\\"/g' conductor.json` | curl -i -s \
	https://conductor-api.udacity.com/v1/deployments -d @- \
	-H 'Content-Type: application/json'

deploy: docker

	BERLIOZ_SUBGROUP=production \
	eval echo `sed 's/"/\\\\"/g' conductor.json` | curl -i -s \
	https://conductor-api.udacity.com/v1/deployments -d @- \
	-H 'Content-Type: application/json'
