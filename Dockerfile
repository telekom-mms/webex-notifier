# syntax=docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM golang:1.21-alpine@sha256:a6a7f1fcf12f5efa9e04b1e75020931a616cd707f14f62ab5262bfbe109aa84a AS build-env
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
FROM alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
COPY --from=build-env /go/src/webex-notifier/webex-notifier  /usr/local/bin/webex-notifier
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["webex-notifier"]
