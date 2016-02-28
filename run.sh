#!/bin/sh

if [ $# != 1 ]
then
  echo "Domain name is required"
  exit 1
fi

export CLASSPATH=/usr/share/dcache/classes/*
h=`hostname`

LOG=/var/log/dcache/$1-${h}.log

dhome=/usr/share/dcache

/usr/bin/java -server \
	-Xmx512m -XX:MaxDirectMemorySize=512m \
	-Dsun.net.inetaddr.ttl=1800 \
	-Dorg.globus.tcp.port.range=20000,25000 \
	-Dorg.dcache.dcap.port=0 \
	-Dorg.dcache.net.tcp.portrange=33115:33145 \
	-Dorg.globus.jglobus.delegation.cache.lifetime=30000 \
	-Dorg.globus.jglobus.crl.cache.lifetime=60000 \
	-Djava.security.krb5.realm= \
	-Djava.security.krb5.kdc= \
	-Djavax.security.auth.useSubjectCredsOnly=false \
	-Djava.security.auth.login.config=/etc/dcache/gss.conf \
	-XX:+HeapDumpOnOutOfMemoryError \
	-XX:HeapDumpPath=/var/log/dcache/$1-${h}-oom.hprof \
	-XX:+UseCompressedOops \
	-javaagent:/usr/share/dcache/classes/aspectjweaver-1.8.8.jar \
	-Djava.awt.headless=true -DwantLog4jSetup=n \
	-Ddcache.home=${dhome} \
	-Ddcache.paths.defaults=${dhome}/defaults \
	org.dcache.boot.BootLoader start ${1}-${h} > ${LOG} 2>&1
