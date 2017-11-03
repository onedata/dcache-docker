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
To access dCache admin interface via ssh, you need to provide **/authorized_keys** as
external volume:
```
$ docker run -v ${HOME}/.ssh/authorized_keys:/authorized_keys:ro ...
```

Use **--memory** option to control JVM's heap size.

JMX
---

The JVM runnig dCache is configured for JMX monitoring on the port **7771**.

Running provided docker-compose
-------------------------------

The provided **docker-compose.yml** files allows to start minimal dCache with a single pool and service.
Update the config to adjust to your envirnoment, like hosts external IP which will be advertised by dCache
pool.

The **.env** file:
```
HUMIO_DATASPACE=humio space
HUMIO_TOKEN=humio token for the space

LOCAL_ADDRESS=1.2.3.4
AUTHORIZED_KEYS=/path/to/key/file
```

```
$ docker-compose up -d
```


