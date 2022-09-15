[![tests](https://github.com/drud/ddev-varnish/actions/workflows/tests.yml/badge.svg)](https://github.com/drud/ddev-varnish/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2022.svg)

# ddev-sw6-redis

This repository allows you to quickly install redis into a [Ddev](https://ddev.readthedocs.io) project running **Shopware 6** using just `ddev get interlutions/ddev-sw6-redis`.

## Installation

1. `ddev get interlutions/ddev-sw6-redis`
2. `ddev restart`

## Explanation

This recipe adds further configurations to enable Redis in Shopware 6.4.*


The file `docker-compose.sw6-redis.yaml` exports all environment variables needed by the caching configuration `[project/]config/packages/sw6-redis.yaml`. 
This config is copied to ony of the following locations `./config/packages/`, `./project/config/packages/` or `./${DDEV_DOCROOT}/../config/packages/` whichever directory exists in your project.

Following databases are used for the different shopware caches:

| Database | Cache for                          | 
|----------|------------------------------------|
| 0        | Default Cache, Objects, Tags, etc. |
| 1        | Full Page Cache                    |
| 2        | Session Data                       |


## Interacting with Redis

* The Redis instance will listen on TCP port 6379 (the redis default).
* Configure your application to access redis on the host:port `redis:6379`.
* To reach the redis CLI interface, run `ddev redis-cli` to begin a session. You can also run Redis CLI commands directly on the command-line, e.g., `ddev redis-cli INFO`. 
* You can see all keys in database 1 by using `ddev redis-cli -n 1 KEYS`   


**Maintained by [@RobertLang](https://github.com/RobertLang) and [@Interlutions](https://github.com/Interlutions)**

**Based on the original [ddev-redis recipe](https://github.com/drud/ddev-redis) by [@hussainweb](https://github.com/hussainweb)**

