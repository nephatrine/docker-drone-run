FROM nephatrine/nxbuilder:golang AS builder

ARG DRONE_DOCKER_VERSION=v1.8.3

RUN git -C /root clone -b "$DRONE_DOCKER_VERSION" --single-branch --depth=1 https://github.com/drone-runners/drone-runner-docker

RUN echo "====== COMPILE DRONE-RUNNERS ======" \
 && cd /root/drone-runner-docker && go build -o /go/bin/drone-runner-docker

FROM nephatrine/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add --no-cache docker git git-lfs

COPY --from=builder /go/bin/drone-runner-docker /usr/bin/
COPY override /
