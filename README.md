# dCache Docker Container

Simple containerized [dCache](https://www.dcache.org) configuration with WebDAV enabled. The installation procedure in the container follows [dCache 5.0 book](https://www.dcache.org/manuals/Book-5.0).
dCache version used is specified in the *Dockerfile*.

To build: make image

To run: docker-compose up

To publish: make push

## Word of Warning

The attached *docker-compose* is a dirty example to show that this configuration works. During startup it will produce some errors before actually correctly initializing postgres. The `network_mode: host` is used not to have to configure postgres authentication, as by default it trusts connections that come from the localhost. WebDAV also takes about 2 minutes to start after the container reports as running. Be patient. Pull requests are welcome!

## dCache on Kubernetes

This image is used in [helm chart](https://github.com/onedata/charts/stable/volume-dcache) as part of Onedata k8s deployments.