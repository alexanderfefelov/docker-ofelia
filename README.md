# docker-ofelia

Supercharged [Ofelia](https://github.com/mcuadros/ofelia) job scheduler in a Docker container.

## What's inside

### Common tools

- cifs-utils
- curl
- expect
- [jq](https://stedolan.github.io/jq/)
- MySQL client
- netcat
- OpenSSH client
- Python
- smbclient
- sshpass
- telnet
- [wait-for-it](https://github.com/vishnubob/wait-for-it)

### Backup tools

- [mydumper](https://github.com/maxbube/mydumper)
- [Percona XtraBackup](https://www.percona.com/software/mysql-database/percona-xtrabackup)

### Python

- [atomicwrites](https://github.com/untitaker/python-atomicwrites) implements atomic file writes
- [Ecks](https://github.com/cread/ecks) provides a simple way to get data out of a remote machine using SNMP without having to deal with a single MIB or OID
- [Fabric](https://github.com/fabric/fabric) is a high level Python library designed to execute shell commands remotely over SSH
- [GraphiteSend](https://github.com/daniellawrence/graphitesend) is an easy bindings to write to Carbon
- [Jinja2](http://jinja.pocoo.org/) is a modern templating language
- [librouteros](https://github.com/luqasz/librouteros) is an implementation of MikroTik RouterOS API
- [Paramiko](https://github.com/paramiko/paramiko) is an implementation of the SSHv2 protocol
- [Pexpect](https://github.com/pexpect/pexpect) is a module for controlling interactive programs in a pseudo-terminal
- [PluginBase](https://github.com/mitsuhiko/pluginbase) enables the development of flexible plugin systems
- [PyMySQL](https://github.com/PyMySQL/PyMySQL) is pure Python MySQL client
- [PyYAML](https://pyyaml.org) is a full-featured YAML framework
- [Requests](https://github.com/requests/requests): HTTP for Humans
- [SQLAlchemy](https://www.sqlalchemy.org) is a SQL toolkit and object-relational mapper
- [SQL-to-Graphite](https://github.com/opschops/sql-to-graphite) is a tool to easily send the results of SQL queries to Graphite
- [stevedore](https://github.com/openstack/stevedore) provides manager classes for implementing common patterns for using dynamically loaded extensions
- [stomp.py](https://github.com/jasonrbriggs/stomp.py) is a client library for accessing messaging servers (such as ActiveMQ, Apollo or RabbitMQ) using the STOMP protocol
- [Twisted](https://twistedmatrix.com) is an event-driven networking engine

### JVM

- [GraalVM](https://www.graalvm.org)
- [sbt](https://www.scala-sbt.org)

## Usage

    docker pull alexanderfefelov/ofelia
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
