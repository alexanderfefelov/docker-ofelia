FROM mcuadros/ofelia as ofelia

FROM alexanderfefelov/mydumper

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends \
       curl expect netcat sshpass \
       python python-pip \
  && apt-get -qq clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD container/ /

CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
