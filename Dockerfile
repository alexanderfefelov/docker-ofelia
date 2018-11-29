FROM mcuadros/ofelia as ofelia

FROM alexanderfefelov/mydumper

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

ADD container/ /

CMD ["/usr/bin/ofelia", "daemon", "--config", "/ofelia/cfg/config.ini"]
