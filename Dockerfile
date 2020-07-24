FROM mcuadros/ofelia:v0.3.0 as ofelia

FROM alexanderfefelov/mydumper

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

ENV GRAALVM_VERSION=20.1.0
ENV GRAALVM_TGZ=graalvm-ce-java8-linux-amd64-$GRAALVM_VERSION.tar.gz
ENV GRAALVM_HOME=/graalvm-ce-java8-$GRAALVM_VERSION
ENV JAVA_HOME=$GRAALVM_HOME
ENV PATH=$GRAALVM_HOME/bin:$PATH
ADD https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/$GRAALVM_TGZ /
RUN tar --extract --gzip --file /$GRAALVM_TGZ \
  && rm --force /$GRAALVM_TGZ

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       apt-transport-https \
       ca-certificates \
       dirmngr \
       gpg

RUN echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

ENV PERCONA_DEB=percona-release_0.1-6.stretch_all.deb
ADD https://repo.percona.com/apt/$PERCONA_DEB /
RUN dpkg --install /$PERCONA_DEB \
  && rm --force /$PERCONA_DEB

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       cifs-utils \
       curl \
       default-libmysqlclient-dev \
       expect \
       gcc \
       jq \
       musl \
       mysql-client \
       netcat \
       openssh-client \
       percona-xtrabackup-24 \
       python \
       python-dev \
       python-pip \
       python-setuptools \
       sbt \
       smbclient \
       sshpass \
       telnet

RUN apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --quiet \
      wheel \
  && pip install --quiet \
       atomicwrites \
       ecks \
       fabric \
       graphitesend \
       jinja2 \
       librouteros \
       paramiko \
       pexpect \
       pluginbase \
       pymysql \
       pyyaml \
       requests \
       rotate-backups \
       sqlalchemy \
       sql-to-graphite \
       stevedore \
       stomp.py \
       twisted

RUN curl --silent https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh \
  && chmod +x /usr/local/bin/wait-for-it.sh

ADD container/ /

CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
