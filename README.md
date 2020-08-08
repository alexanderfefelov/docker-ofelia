# docker-ofelia

Supercharged [Ofelia](https://github.com/mcuadros/ofelia) job scheduler in a Docker container.

## What's inside

### Common tools

- CIFS utils
- Expect
- HTTPie
- jq
- MySQL client
- netcat
- OpenSSH client
- PostgreSQL client
- sshpass
- Telnet client

### Database tools

- [mydumper](https://github.com/maxbube/mydumper)
- [Percona XtraBackup](https://www.percona.com/software/mysql-database/percona-xtrabackup)

### JVM

- [GraalVM](https://www.graalvm.org)
- [sbt](https://www.scala-sbt.org)

### Scripting engines

- JavaScript (provided by GraalVM)
- Lua
- Node.js (provided by GraalVM)
- Python
- Python (provided by GraalVM)
- R (provided by GraalVM)
- Ruby (provided by GraalVM)
- Tcl

### Python

- atomicwrites - atomic file writes
- elasticsearch - Elasticsearch client
- fabric - execute shell commands remotely over SSH
- graphite2 - Graphite client
- influxdb - InfluxDB client
- jinja2 - template engine
- librouteros - RouterOS client
- netmiko - SSH connections to network devices
- paramiko - SSH connections
- pluginbase - support for building plugins systems
- prometheus-client - Prometheus client
- psycopg2 - PostgreSQL driver
- pymssql - Microsoft SQL server driver
- pymysql - MySQL driver
- pysnmp4 - SNMP library
- redis - Redis client
- requests - HTTP library
- rotate-backups - backup rotation
- sqlalchemy - SQL toolkit and ORM 
- stevedore - support for dynamic plugins
- stomp - STOMP client
- twisted - event-based framework for internet applications

### Tcl

- tdbc
- tdbc-mysql
- tdbc-postgres
- tdbc-sqlite3

## Usage

```
docker run \
  --name ofelia \
  --detach \
  --volume /etc/localtime:/etc/localtime:ro --volume /etc/timezone:/etc/timezone:ro \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume ofelia:/ofelia \
  --volume ofelia-ivy:/root/.ivy2 \
  --health-cmd /healthcheck.sh --health-start-period 30s --health-interval 1m --health-timeout 2s --health-retries 3 \
  alexanderfefelov/ofelia
```

Try also

```
docker run --rm --tty alexanderfefelov/ofelia bash -c :
```

## Where is my data?

```
docker volume inspect --format '{{ .Mountpoint }}' ofelia
```

### Uninstall

```
docker rm --force ofelia
docker image rm alexanderfefelov/ofelia
docker volume rm ofelia
docker volume rm ofelia-ivy
```
