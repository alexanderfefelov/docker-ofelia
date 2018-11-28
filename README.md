# docker-ofelia

[Ofelia](https://github.com/mcuadros/ofelia) job scheduler in a Docker container.

## Usage

    docker run \
      --name ofelia \
      --detach \
      --volume /etc/localtime:/etc/localtime:ro --volume /etc/timezone:/etc/timezone:ro \
      --volume ofelia:/ofelia \
      alexanderfefelov/ofelia

## Where is my data?

    docker volume inspect --format '{{ .Mountpoint }}' ofelia

## Uninstall

    docker rm --force ofelia
    docker image rm ofelia
    docker volume rm ofelia
