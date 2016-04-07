Running dCache in a container
=============================

The dockerized dCache on startup will use **/etc/dcache/layouts/docker-layout.conf** file.
The argument to *'docker run'* command can the the domain name which have to be started.
By default, dCacheDomain is stared.


```
$ docker run -d  \
    -v /tmp/log:/var/log/dcache \
    -v <path/to/docker-layout.conf>:/etc/dcache/layouts/docker-layout.conf \
    -v <path/to/exports>:/etc/exports  local/dcache-2.15
```
or

```
$ docker run -d  \
    -v /tmp/log:/var/log/dcache \
    -v <path/to/docker-layout.conf>:/etc/dcache/layouts/docker-layout.conf \
    -v <path/to/exports>:/etc/exports  local/dcache-2.15 pool
```

Howto build
===========

To build dCache contailer simply run
```
$ docker build  -t local/dcache-2.15 .
```

The build script takes an **rpm** as an argument. which must point to location of dcache rpm file to be installed:
```
$ docker build --build-arg rpm=https://www.dcache.org/downloads/1.9/repo/2.14/dcache-2.14.18-1.noarch.rpm \
   -t local/dcache-2.14 .
```
