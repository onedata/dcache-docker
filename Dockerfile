#
# to run:
#  docker run -dt -v /tmp/log:/var/log/dcache -v `pwd`/docker-layout.conf:/etc/dcache/layouts/docker-layout.conf -p 22125:22125 local/dcache-upstream dcap
#

# Based on CentOS 7
FROM centos:7

MAINTAINER dCache "https://www.dcache.org"

# install required packages
RUN yum -y install java-1.8.0-openjdk-headless
#RUN yum -y install which
RUN yum install -y https://www.dcache.org/downloads/1.9/repo/2.15/dcache-2.15.3-1.noarch.rpm

# add external files into container at the build time
COPY dcache.conf /etc/dcache/dcache.conf
COPY run.sh /etc/dcache/run.sh

# the data log files must survive container restarts
VOLUME /var/log/dcache

# expose TCP ports for network services
EXPOSE 22125 2049

ENTRYPOINT ["/etc/dcache/run.sh"]

# default domain
CMD ["dCacheDomain"]
