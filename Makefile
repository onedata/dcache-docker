TAG = $(shell git describe --tags --always)
PREFIX = $(shell git config --get remote.origin.url | sed 's/.git$$//' | tr ':.' '/'  | rev | cut -d '/' -f 2 | rev)
REPO_NAME = $(shell git config --get remote.origin.url | sed 's/.git$$//' | tr ':.' '/'  | rev | cut -d '/' -f 1 | rev)
DCACHE_VERSION = $(shell grep "ENV DCACHE_VERSION" Dockerfile | cut -d '=' -f2)

all: push

container: image

image:
ifeq (,$(wildcard ./dcache_$(DCACHE_VERSION)_all.deb))
		wget "https://www.dcache.org/downloads/1.9/repo/5.0/dcache_$(DCACHE_VERSION)_all.deb" -O dcache_$(DCACHE_VERSION)_all.deb
endif
	docker build -t $(PREFIX)/$(REPO_NAME) . # Build new image and automatically tag it as latest
	docker tag $(PREFIX)/$(REPO_NAME) $(PREFIX)/$(REPO_NAME):$(TAG)  # Add the version tag to the latest image

push: image
	docker push $(PREFIX)/$(REPO_NAME) # Push image tagged as latest to repository
	docker push $(PREFIX)/$(REPO_NAME):$(TAG) # Push version tagged image to repository (since this image is already pushed it will simply create or update version tag)

clean: