FROM mcuadros/ofelia as ofelia

FROM alexanderfefelov/mydumper

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

ENV DEBIAN_FRONTEND noninteractive

ADD https://repo.percona.com/apt/percona-release_0.1-6.stretch_all.deb /
RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends \
       gpg \
  && dpkg --install /percona-release_0.1-6.stretch_all.deb \
  && rm --force /percona-release_0.1-6.stretch_all.deb

RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends \
       default-libmysqlclient-dev gcc python-dev \
       percona-xtrabackup-24 \
       curl expect netcat sshpass \
       python python-pip python-setuptools \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && pip install wheel \
  && pip install \
       ecks graphitesend librouteros pyyaml requests sql-to-graphite

ENV GRAALVM_VERSION=1.0.0-rc9
ENV GRAALVM_HOME=/graalvm-ce-$GRAALVM_VERSION
ENV JAVA_HOME=$GRAALVM_HOME
ENV PATH=$GRAALVM_HOME/bin:$PATH
ADD https://github.com/oracle/graal/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-$GRAALVM_VERSION-linux-amd64.tar.gz /
RUN tar xfz /graalvm-ce-$GRAALVM_VERSION-linux-amd64.tar.gz \
  && rm --force /graalvm-ce-$GRAALVM_VERSION-linux-amd64.tar.gz

ADD container/ /

CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
