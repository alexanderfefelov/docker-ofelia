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
- [PluginBase](https://github.com/mitsuhiko/pluginbase)
- [pyyaml](https://pyyaml.org)
- [requests](https://github.com/requests/requests)
- [stevedore](https://github.com/openstack/stevedore)
- [sql-to-graphite](https://github.com/opschops/sql-to-graphite)
- [stomp.py](https://github.com/jasonrbriggs/stomp.py)

### JVM

- [GraalVM](https://www.graalvm.org)
- [sbt](https://www.scala-sbt.org)

## Usage

    docker run \
      --name ofelia \
      --detach \
      --volume /etc/localtime:/etc/localtime:ro --volume /etc/timezone:/etc/timezone:ro \
      --volume /var/run/docker.sock:/var/run/docker.sock \
      --volume ofelia:/ofelia \
      alexanderfefelov/ofelia

## Where is my data?

    docker volume inspect --format '{{ .Mountpoint }}' ofelia

## Uninstall

    docker rm --force ofelia
    docker image rm ofelia
    docker volume rm ofelia
