# syntax=docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM golang:1.21-alpine@sha256:4db4aac30880b978cae5445dd4a706215249ad4f43d28bd7cdf7906e9be8dd6b AS build-env
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
FROM alpine:latest@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48
COPY --from=build-env /go/src/webex-notifier/webex-notifier  /usr/local/bin/webex-notifier
RUN mkdir -p /output
ENV DIRECTORY /output
ENTRYPOINT ["webex-notifier"]
