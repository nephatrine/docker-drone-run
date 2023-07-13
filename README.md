[Git](https://code.nephatrine.net/NephNET/docker-drone-run/src/branch/master) |
[Docker](https://hub.docker.com/r/nephatrine/drone-runner/) |
[unRAID](https://code.nephatrine.net/NephNET/unraid-containers)

# Drone CI/CD Runner

This docker image contains the drone-docker-runner for hosting your own CI/CD
build environments.

The `latest` tag points to version `1.8.3` and this is the only image actively
being updated. There are tags for older versions, but these may no longer be
using the latest Alpine version and packages.

**Please note that the runner itself runs as the root user inside the container.**

## Docker-Compose

This is an example docker-compose file:

```yaml
services:
  drone_runner:
    image: nephatrine/gitea-runner:latest
    container_name: drone_runner
    environment:
      TZ: America/New_York
      PUID: 1000
      PGID: 1000
      DRONE_RPC_HOST: example.net:8080
      DRONE_RPC_PROTO: http
      DRONE_RPC_SECRET:
      DRONE_RUNNER_NAME: testrunner
    volumes:
      - /mnt/containers/drone_runner:/mnt/config
      - /var/run/docker.sock:/run/docker.sock
```

## Server Configuration

This is the only configuration file you will likely need to be aware of and
potentially customize.

- `/mnt/config/etc/drone-runner-config`

Modifications to this file will require a service restart to pull in the
changes made.
