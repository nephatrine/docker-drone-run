<!--
SPDX-FileCopyrightText: 2023-2025 Daniel Wolf <nephatrine@gmail.com>
SPDX-License-Identifier: ISC
-->

# Drone Docker Runner

[![NephCode](https://img.shields.io/static/v1?label=Git&message=NephCode&color=teal)](https://code.nephatrine.net/NephNET/docker-drone-run)
[![GitHub](https://img.shields.io/static/v1?label=Git&message=GitHub&color=teal)](https://github.com/nephatrine/docker-drone-run)
[![Registry](https://img.shields.io/static/v1?label=OCI&message=NephCode&color=blue)](https://code.nephatrine.net/NephNET/-/packages/container/drone-runner/latest)
[![DockerHub](https://img.shields.io/static/v1?label=OCI&message=DockerHub&color=blue)](https://hub.docker.com/repository/docker/nephatrine/drone-runner/general)
[![unRAID](https://img.shields.io/static/v1?label=unRAID&message=template&color=orange)](https://code.nephatrine.net/NephNET/unraid-containers)

This is an Alpine-based container hosting a Drone CI runner for performing your
own CI/CD builds in Docker containers. You can have multiple such runners
connected to a Drone server.

**WARNING: Please note that the runner itself runs as the root user inside the
container. Only allow trusted users and organizations access to your runner.**

**WARNING: I have personally migrated to Gitea Actions and so this container is
not thoroughly tested anymore. I do suggest you find an alternative as I will
not maintain this indefinitely.**

## Supported Tags

- `drone-runner:1.8.4`: Drone Docker Runner 1.8.4

## Software

- [Alpine Linux](https://alpinelinux.org/)
- [Skarnet S6](https://skarnet.org/software/s6/)
- [s6-overlay](https://github.com/just-containers/s6-overlay)
- [Drone Docker Runner](https://docs.drone.io/runner/docker/overview/)

## Configuration

This is the only configuration file you will likely need to be aware of and
potentially customize.

- `/mnt/config/etc/drone-runner-config`

This is a bash script that will be sourced by the startup routine to include
additional tweaks or setup you would like to perform. Modifications to these
files will require a service restart to pull in the changes made.

### Container Variables

- `TZ`: Time Zone (i.e. `America/New_York`)
- `PUID`: Mounted File Owner User ID
- `PGID`: Mounted File Owner Group ID
- `DRONE_RPC_HOST`: Drone Domain/IP and Port
- `DRONE_RPC_PROTO`: Drone URL Protocol
- `DRONE_RPC_SECRET`: Drone Secret
- `DRONE_RUNNER_NAME`: Runner Name

## Testing

### docker-compose

```yaml
services:
  drone-runner:
    image: nephatrine/drone-runner:latest
    container_name: drone-runner
    environment:
      TZ: America/New_York
      PUID: 1000
      PGID: 1000
      DRONE_RPC_HOST: drone.example.net
      DRONE_RPC_PROTO: https
      DRONE_RPC_SECRET:
      DRONE_RUNNER_NAME: test
    volumes:
      - /mnt/containers/drone-runner:/mnt/config
      - /var/run/docker.sock:/run/docker.sock
```

### docker run

```bash
docker run --rm -ti code.nephatrine.net/nephnet/drone-runner:latest /bin/bash
```
