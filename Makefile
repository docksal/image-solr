-include env_make

VERSION ?= 8.1
FROM ?= solr:8.1.1-slim
BUILD_TAG ?= $(VERSION)
SOFTWARE_VERSION ?= $(VERSION)

REPO ?= docksal/solr
NAME = docksal-solr-$(VERSION)
SOLR_DEFAULT_CONFIG_SET ?= search_api_solr_8.x-3.0

.EXPORT_ALL_VARIABLES:

.PHONY: build test push shell run start stop logs clean release

build:
	git checkout -- configsets
	VERSION=$(VERSION) scripts/prepare_configsets.sh
	docker build -t $(REPO):$(BUILD_TAG) --build-arg FROM=$(FROM) --build-arg VERSION=$(VERSION) --build-arg SOLR_DEFAULT_CONFIG_SET=$(SOLR_DEFAULT_CONFIG_SET) .

test:
	IMAGE=$(REPO):$(BUILD_TAG) NAME=$(NAME) VERSION=$(VERSION) ./tests/test.bats

push:
	docker push $(REPO):$(BUILD_TAG)

shell: clean
	docker run --rm --name $(NAME) -it $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(BUILD_TAG) /bin/bash

run: clean
	docker run --rm --name $(NAME) -it $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(BUILD_TAG)

start: clean
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(BUILD_TAG)

exec:
	docker exec $(NAME) /bin/bash -c "$(CMD)"

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	docker rm -f $(NAME) >/dev/null 2>&1 || true

release:
	@scripts/docker-push.sh

default: build
