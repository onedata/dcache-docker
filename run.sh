#!/bin/sh

if [ $# != 1 ]
then
  echo "Domain name is required"
  exit 1
fi

ASPECT_V=1.8.8
export CLASSPATH=/usr/share/dcache/classes/*

DOMAIN=$1
if [ -t 0 ]
then
  LOG=/dev/stdout
else
  LOG=/var/log/dcache/${DOMAIN}.log
fi

DCACHE_HOME=/usr/share/dcache

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
	-XX:HeapDumpPath=/var/log/dcache/${DOMAIN}-oom.hprof \
	-XX:+UseCompressedOops \
	-javaagent:/usr/share/dcache/classes/aspectjweaver-${ASPECT_V}.jar \
	-Djava.awt.headless=true -DwantLog4jSetup=n \
	-Ddcache.home=${DCACHE_HOME} \
	-Ddcache.paths.defaults=${DCACHE_HOME}/defaults \
	org.dcache.boot.BootLoader start ${DOMAIN} > ${LOG} 2>&1
