# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6
FROM golang:1.25-alpine@sha256:aee43c3ccbf24fdffb7295693b6e33b21e01baec1b2a55acc351fde345e9ec34 AS build-env
RUN mkdir -p /go/src/webex-notifier

# Copy the module files first and then download the dependencies. If this
# doesn't change, we won't need to do this again in future builds.
WORKDIR /go/src/webex-notifier

COPY go.* ./
RUN go mod download

WORKDIR /go/src/webex-notifier
ADD conf conf
COPY *.go ./
RUN go build -o webex-notifier

# final stage
FROM alpine:latest@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412
COPY --from=build-env /go/src/webex-notifier/webex-notifier  /usr/local/bin/webex-notifier
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["webex-notifier"]
