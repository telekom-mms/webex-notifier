# syntax=docker/dockerfile:1@sha256:db1ff77fb637a5955317c7a3a62540196396d565f3dd5742e76dddbb6d75c4c5
FROM golang:1.23-alpine@sha256:6c5c9590f169f77c8046e45c611d3b28fe477789acd8d3762d23d4744de69812 AS build-env
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
FROM alpine:latest@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45
COPY --from=build-env /go/src/webex-notifier/webex-notifier  /usr/local/bin/webex-notifier
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["webex-notifier"]
