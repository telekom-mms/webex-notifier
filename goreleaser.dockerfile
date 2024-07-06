ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:1aae189e3baecbb4044c648d356ddb75025b2ba8d14cdc9c2a19ba784c90bfb9

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY webex-notifier /webex-notifier

# Run the hello binary.
ENTRYPOINT ["/webex-notifier"]
