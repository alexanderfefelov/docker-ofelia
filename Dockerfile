FROM mcuadros/ofelia as ofelia

FROM alexanderfefelov/mydumper

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends \
       curl expect netcat sshpass \
       python python-pip \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GRAALVM_VERSION=1.0.0-rc9
ENV GRAALVM_HOME=/graalvm-ce-$GRAALVM_VERSION
ENV JAVA_HOME=$GRAALVM_HOME
ENV PATH=$GRAALVM_HOME/bin:$PATH
ADD https://github.com/oracle/graal/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-$GRAALVM_VERSION-linux-amd64.tar.gz /
RUN tar xfz /graalvm-ce-$GRAALVM_VERSION-linux-amd64.tar.gz \
  && rm --force /graalvm-ce-$GRAALVM_VERSION-linux-amd64.tar.gz

ADD container/ /

CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
