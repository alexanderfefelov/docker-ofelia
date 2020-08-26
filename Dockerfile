FROM mcuadros/ofelia:v0.3.0 as ofelia

FROM ubuntu:20.04

#
# Ofelia
#
COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

#
# Prerequisites
#
RUN apt-get -qq update \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install --no-install-recommends \
       ca-certificates \
       curl \
       gnupg2 \
       lsb-release \
       musl \
       tzdata

#
# GraalVM
#
ENV GRAALVM_VERSION=20.2.0
ENV GRAALVM_JAVA_VERSION=11
ENV GRAALVM_HOME=/graalvm-ce-java$GRAALVM_JAVA_VERSION-$GRAALVM_VERSION
ENV GRAALVM_STUFF=graalvm-ce-java$GRAALVM_JAVA_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz
ENV JAVA_HOME=$GRAALVM_HOME
ENV PATH=$JAVA_HOME/bin:$PATH
ADD https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/$GRAALVM_STUFF /
RUN tar --extract --gzip --file /$GRAALVM_STUFF \
  && rm --force /$GRAALVM_STUFF \
  && gu install --catalog org.graalvm.python \
  && gu install --catalog org.graalvm.R \
  && gu install --catalog org.graalvm.ruby

#
# sbt
#
RUN echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list \
  && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       sbt

#
# mydumper
#
ENV MYDUMPER_VERSION=0.9.5
ENV MYDUMPER_REVISION=2
ENV MYDUMPER_STUFF=mydumper_$MYDUMPER_VERSION-$MYDUMPER_REVISION.stretch_amd64.deb
ADD https://github.com/maxbube/mydumper/releases/download/v$MYDUMPER_VERSION/$MYDUMPER_STUFF /
RUN apt-get -qq install --no-install-recommends \
      libatomic1 \
      libglib2.0-0 \
      libssl1.1 \
  && dpkg --install /$MYDUMPER_STUFF \
  && rm --force /$MYDUMPER_STUFF

#
# XtraBackup
#
ENV PERCONA_STUFF=percona-release_latest.focal_all.deb
ADD https://repo.percona.com/apt/$PERCONA_STUFF /
RUN dpkg --install /$PERCONA_STUFF \
  && rm --force /$PERCONA_STUFF
RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       percona-xtrabackup-24

#
# Common tools
#
RUN apt-get -qq install --no-install-recommends \
      cifs-utils \
      expect \
      httpie \
      influxdb-client \
      jq \
      mysql-client \
      netcat \
      openssh-client \
      postgresql-client \
      redis-tools \
      sshpass \
      telnet
RUN curl --silent https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh \
  && chmod +x /usr/local/bin/wait-for-it.sh

#
# Lua
#
RUN apt-get -qq install --no-install-recommends \
      lua5.3

#
# Python
#
RUN apt-get -qq install --no-install-recommends \
      python3-atomicwrites \
      python3-elasticsearch \
      python3-fabric \
      python3-graphite2 \
      python3-influxdb \
      python3-jinja2 \
      python3-librouteros \
      python3-netmiko \
      python3-paramiko \
      python3-pip \
      python3-pluginbase \
      python3-prometheus-client \
      python3-psycopg2 \
      python3-pymssql \
      python3-pymysql \
      python3-pysnmp4 \
      python3-redis \
      python3-requests \
      python3-sqlalchemy \
      python3-stevedore \
      python3-stomp \
      python3-twisted
RUN pip3 install --quiet \
      rotate-backups

#
# Tcl
#
RUN apt-get -qq install --no-install-recommends \
      tcl \
      tcl8.6-tdbc \
      tcl8.6-tdbc-mysql \
      tcl8.6-tdbc-postgres \
      tcl8.6-tdbc-sqlite3

#
# Cleanup
#
RUN apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD container/ /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
