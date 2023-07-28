ARG  DISTROLESS_IMAGE=gcr.io/distroless/base

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY webex-notifier /webex-notifier

# Run the hello binary.
ENTRYPOINT ["/webex-notifier"]
