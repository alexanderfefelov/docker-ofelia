# docker-ofelia

Supercharged [Ofelia](https://github.com/mcuadros/ofelia) job scheduler in a Docker container.

## What's inside

### Common tools
- cifs-utils
- curl
- expect
- netcat
- OpenSSH client
- Python
- smbclient
- sshpass
- telnet

### Backup tools

- [mydumper](https://github.com/maxbube/mydumper)
- [Percona XtraBackup](https://www.percona.com/software/mysql-database/percona-xtrabackup)

### Python

- [ecks](https://github.com/cread/ecks)
- [graphitesend](https://github.com/daniellawrence/graphitesend)
- [librouteros](https://github.com/luqasz/librouteros)
- [pyyaml](https://pyyaml.org/)
- [requests](https://github.com/requests/requests)
- [sql-to-graphite](https://github.com/opschops/sql-to-graphite)

### JVM

- [GraalVM](https://www.graalvm.org/)
- [sbt](https://www.scala-sbt.org)

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
