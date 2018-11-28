# docker-ofelia

[Ofelia](https://github.com/mcuadros/ofelia) job scheduler in a Docker container.

Usage:

    docker run \
      --name ofelia \
      --detach \
      --volume /etc/localtime:/etc/localtime:ro --volume /etc/timezone:/etc/timezone:ro \
      --volume ofelia:/ofelia \
      alexanderfefelov/ofelia
