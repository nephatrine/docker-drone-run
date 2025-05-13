# SPDX-FileCopyrightText: 2023-2025 Daniel Wolf <nephatrine@gmail.com>
# SPDX-License-Identifier: ISC

# hadolint global ignore=DL3007,DL3018

FROM code.nephatrine.net/nephnet/nxb-golang:latest AS builder

ARG DRONE_DOCKER_VERSION=v1.8.4
RUN git -C /root clone -b "$DRONE_DOCKER_VERSION" --single-branch --depth=1 https://github.com/drone-runners/drone-runner-docker
WORKDIR /root/drone-runner-docker
RUN go build -o /go/bin/drone-runner-docker

FROM code.nephatrine.net/nephnet/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN apk add --no-cache docker git git-lfs jq && rm -rf /tmp/* /var/tmp/*
COPY --from=builder /go/bin/drone-runner-docker /usr/bin/
COPY override /
