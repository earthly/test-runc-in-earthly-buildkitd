FROM earthly/buildkitd:v0.8.6
COPY entrypoint.sh /root/entrypoint.sh
WORKDIR /test-runc
COPY rootfs rootfs
COPY config.json .
ENTRYPOINT /root/entrypoint.sh
