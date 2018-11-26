-include env_make

SOLR_VER ?= 3.6.2
TAG ?= $(SOLR_VER)

REPO = docksal/solr
NAME = solr-$(SOLR_VER)

BASE_IMAGE_TAG = $(SOLR_VER)-alpine

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	scripts/get-module-versions.sh; \
	docker build -t $(REPO):$(TAG) \
		--build-arg SOLR_VER=$(SOLR_VER) \
		./; \
	rm -rf configsets

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) NAME=$(NAME) ./run.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) -e DEBUG=1 $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
