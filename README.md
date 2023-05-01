[Git](https://code.nephatrine.net/NephNET/docker-drone-run/src/branch/master) |
[Docker](https://hub.docker.com/r/nephatrine/drone-runner/) |
[unRAID](https://code.nephatrine.net/NephNET/unraid-containers)

# Drone CI/CD Runner

This docker image contains a Drone server to self-host your own continuous
delivery platform.

**Please note that the runner itself runs as the root user inside the container.**

- [Alpine Linux](https://alpinelinux.org/) w/ [S6 Overlay](https://github.com/just-containers/s6-overlay)
- [Drone-Runner-Docker](https://docs.drone.io/runner/docker/overview/)

You can spin up a quick temporary test container like this:

~~~
docker run --rm -v /var/run/docker.sock:/run/docker.sock -it nephatrine/drone-runner:latest /bin/bash
~~~

## Docker Tags

- **nephatrine/drone-server:latest**: Drone Docker Runner v1.8.3 / Alpine Latest

## Configuration Variables

You can set these parameters using the syntax ``-e "VARNAME=VALUE"`` on your
``docker run`` command. Some of these may only be used during initial
configuration and further changes may need to be made in the generated
configuration files.

- ``DRONE_RPC_SECRET``: Drone CI Secret (**generated**)
- ``DRONE_RPC_HOST``: Drone CI Hostname (*""*)
- ``DRONE_RPC_PROTO``: Drone CI Protocol (*"http"*)
- ``DRONE_RUNNER_NAME``: Runner Name (**generated**)
- ``DRONE_RUNNER_CAPACITY``: Runner Capacity (**1**)
- ``PUID``: Mount Owner UID (*1000*)
- ``PGID``: Mount Owner GID (*100*)
- ``TZ``: System Timezone (*America/New_York*)

## Persistent Mounts

You can provide a persistent mountpoint using the ``-v /host/path:/container/path``
syntax. These mountpoints are intended to house important configuration files,
logs, and application state (e.g. databases) so they are not lost on image
update.

- ``/mnt/config``: Persistent Data.
- ``/run/docker.sock``: Docker Daemon Socket.

Do not share ``/mnt/config`` volumes between multiple containers as they may
interfere with the operation of one another.

You can perform some basic configuration of the container using the files and
directories listed below.

- ``/mnt/config/etc/crontabs/<user>``: User Crontabs. [*]
- ``/mnt/config/etc/drone-runner-config``: Set Drone Envars. [*]
- ``/mnt/config/etc/logrotate.conf``: Logrotate Global Configuration.
- ``/mnt/config/etc/logrotate.d/``: Logrotate Additional Configuration.

**[*] Changes to some configuration files may require service restart to take
immediate effect.**
