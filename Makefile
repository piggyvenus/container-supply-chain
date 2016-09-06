COREBUILD_NAME = corebuild
MW_COREBUILD_001 = httpd-php
MW_COREBUILD_002 = httpd-ruby
APPLICATION_BUILD_NAME = wordpress
USERNAME = example
VERSION = 1.0.0
REGISTRY = 10.0.1.1

all: build

build: $(COREBUILD_NAME).o $(MW_COREBUILD_001).o $(MW_COREBUILD_002).o $(APPLICATION_BUILD_NAME).o

$(COREBUILD_NAME).o: $(COREBUILD_NAME)/*
	docker build -t $(COREBUILD_NAME) $(COREBUILD_NAME)/
	@if docker images $(COREBUILD_NAME) | grep $(COREBUILD_NAME); then touch $(COREBUILD_NAME).o; fi

$(MW_COREBUILD_001).o: $(MW_COREBUILD_001)/* $(COREBUILD_NAME).o
	docker build -t $(MW_COREBUILD_001) $(MW_COREBUILD_001)/
	@if docker images $(MW_COREBUILD_001) | grep $(MW_COREBUILD_001); then touch $(MW_COREBUILD_001).o; fi

$(MW_COREBUILD_002).o: $(MW_COREBUILD_002)/* $(COREBUILD_NAME).o
	docker build -t $(MW_COREBUILD_002) $(MW_COREBUILD_002)/
	@if docker images $(MW_COREBUILD_002) | grep $(MW_COREBUILD_002); then touch $(MW_COREBUILD_002).o; fi

$(APPLICATION_BUILD_NAME).o: $(APPLICATION_BUILD_NAME)/* $(MW_COREBUILD_001).o
	docker build -t $(APPLICATION_BUILD_NAME) $(APPLICATION_BUILD_NAME)/
	@if docker images $(APPLICATION_BUILD_NAME) | grep $(APPLICATION_BUILD_NAME); then touch $(APPLICATION_BUILD_NAME).o; fi

test:
	env NAME=$(NAME) VERSION=$(VERSION) ./test.sh

clean:
	rm ./*.o

tag_production:
	docker tag -f $(COREBUILD_NAME):latest $(COREBUILD_NAME):production
	docker tag -f $(MW_COREBUILD_001):latest $(MW_COREBUILD_001):production
	docker tag -f $(MW_COREBUILD_002):latest $(MW_COREBUILD_002):production
	docker tag -f $(APPLICATION_BUILD_NAME):latest $(APPLICATION_BUILD_NAME):production

push:
	docker tag -f $(COREBUILD_NAME) $(SERVER)/$(COREBUILD_NAME)
	docker tag -f $(MW_COREBUILD_001) $(SERVER)/$(MW_COREBUILD_001)
	docker tag -f $(MW_COREBUILD_002) $(SERVER)/$(MW_COREBUILD_002)
	docker tag -f $(APPLICATION_BUILD_NAME) $(SERVER)/$(APPLICATION_BUILD_NAME)
	docker push $(SERVER)/$(COREBUILD_NAME)
	docker push $(SERVER)/$(MW_COREBUILD_001)
	docker push $(SERVER)/$(MW_COREBUILD_002)
	docker push $(SERVER)/$(APPLICATION_BUILD_NAME)
