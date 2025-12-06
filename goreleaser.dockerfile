ARG  DISTROLESS_IMAGE=gcr.io/distroless/base@sha256:f5a3067027c2b322cd71b844f3d84ad3deada45ceb8a30f301260a602455070e

# using base nonroot image
# user:group is nobody:nobody, uid:gid = 65534:65534
FROM ${DISTROLESS_IMAGE}

# Copy our static executable
COPY webex-notifier /webex-notifier

# Run the hello binary.
ENTRYPOINT ["/webex-notifier"]
