Running dCache in a container
=============================

Howto build
-----------

The dockerized dCache uses tar-based distribution to build the docker image.
For example, to built cotainer to run version 3.1.2 you will need to copy
dcache-3.1.2.tar file into current directory and run __docker run__ command:

```
$ docker build -t local/dcache-3.1 --build-arg=VERSION=3.1.2 .
```


Howto run
---------

The dockerized dCache on startup will use **/etc/dcache/layouts/docker-layout.conf** file.
The argument to *'docker run'* command can the the domain name which have to be started.
By default, **core** domain is stared.


The volume **/pool** allows to percist dcache pool's data on conrainer restarts.


Running provided docker-compose
-------------------------------

The provided **docker-compose.yml** files allows to start minimal dCache with a single pool and service.
Update the config to adjust to your envirnoment, like hosts external IP which will be advertised by dCache
pool.

```
$ docker-compose up -d
```
