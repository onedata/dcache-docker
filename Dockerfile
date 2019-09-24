FROM ubuntu:18.04

# dCache version
ENV DCACHE_VERSION=5.0.9-1

# Add dependencies
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends openjdk-8-jre-headless ssh-client ssl-cert rsyslog; \
  rm -rf /var/lib/apt/lists/*

# Add dCache
ADD dcache_${DCACHE_VERSION}_all.deb /
RUN set -eux; \
  dpkg -i /dcache_${DCACHE_VERSION}_all.deb; \
  rm dcache_${DCACHE_VERSION}_all.deb

# Add external files into container at the build time
COPY dcache.conf /etc/dcache/dcache.conf
COPY webdav-layout.conf /etc/dcache/layouts/webdav-layout.conf
COPY run.sh /run.sh

# Configure dcache gplazma and create pool directory
RUN set -eux; \
  mv /etc/dcache/gplazma.conf /etc/dcache/gplazma.conf.back ; \
  touch /etc/dcache/gplazma.conf; \
  mkdir /pool1; \
  chown -R dcache:dcache /pool1

# The data log files must survive container restarts
VOLUME /var/log/dcache
VOLUME /pool1

# Expose TCP ports for network services
EXPOSE 2288 22125 2049 32049 22224 2181 2880

ENTRYPOINT ["/run.sh"]