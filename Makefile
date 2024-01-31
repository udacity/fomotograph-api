BERLIOZ_GROUP     := udacity
BERLIOZ_NAME      := fomotograph-api
DOCKER_REPO       := docker.udacity.com/$(BERLIOZ_GROUP)/$(BERLIOZ_NAME)
SERVICE_NAME      := $(BERLIOZ_NAME)
VERSION           ?= $(shell git rev-parse --short HEAD)
CONDUCTOR_APP_ID  := 37eb0c76-d759-11e6-bc82-dbb131c6e091
export

.PHONY: all build push test deploy

all: build

test:
	docker-compose up -d --build && sleep 10
	# docker-compose exec test curl http://app:4567/healthcheck
	docker-compose exec test curl http://app:4567/products.json -o /tmp/test1
	docker-compose exec test jq '.' /tmp/test1
	docker-compose exec test curl http://app:4567/erasurez -o /tmp/test2
	docker-compose exec test jq '.' /tmp/test2
	docker-compose down

build:
	docker build -t $(SERVICE_NAME) .
	docker tag $(SERVICE_NAME) $(DOCKER_REPO):$(VERSION)

push:
	docker push $(DOCKER_REPO):$(VERSION)


deploy: ENVIRONMENT=production
deploy: build push
	# Deploy to Conductor
	@curl --fail -X PUT "https://conductor-beta.udacity.com/api/v1/apps/$(CONDUCTOR_APP_ID)/deploy" \
		-H 'X-GitHub-Access-Token: $(CI_GITHUB_ACCESS_TOKEN)' \
		-d '{"environment": "$(ENVIRONMENT)", "image": "$(DOCKER_REPO):$(VERSION)"}'
