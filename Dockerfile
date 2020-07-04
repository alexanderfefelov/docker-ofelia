FROM mcuadros/ofelia:v0.3.0 as ofelia

FROM alexanderfefelov/mydumper

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

ENV GRAALVM_VERSION=20.1.0
ENV GRAALVM_HOME=/graalvm-ce-java8-$GRAALVM_VERSION
ENV JAVA_HOME=$GRAALVM_HOME
ENV PATH=$GRAALVM_HOME/bin:$PATH
ADD https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-java8-linux-amd64-$GRAALVM_VERSION.tar.gz /
RUN tar xfz /graalvm-ce-java8-linux-amd64-$GRAALVM_VERSION.tar.gz \
  && rm --force /graalvm-ce-java8-linux-amd64-$GRAALVM_VERSION.tar.gz

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends \
       apt-transport-https ca-certificates dirmngr gpg \
  && echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

ADD https://repo.percona.com/apt/percona-release_0.1-6.stretch_all.deb /
RUN dpkg --install /percona-release_0.1-6.stretch_all.deb \
  && rm --force /percona-release_0.1-6.stretch_all.deb

RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends \
       default-libmysqlclient-dev gcc musl python-dev \
       cifs-utils curl expect jq mysql-client netcat openssh-client smbclient sshpass telnet \
       percona-xtrabackup-24 \
       python python-pip python-setuptools \
       sbt \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && pip install wheel \
  && pip install \
       ecks fabric graphitesend Jinja2 librouteros paramiko pexpect pluginbase pymysql pyyaml requests SQLAlchemy sql-to-graphite stevedore stomp.py Twisted \
  && curl --silent https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh && chmod +x /usr/local/bin/wait-for-it.sh

ADD container/ /

CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
