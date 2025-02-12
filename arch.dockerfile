# :: Header
  FROM 11notes/alpine:stable

# :: Run
  USER root
  COPY --chown=1000:1000 ./rootfs /
  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    chmod +x -R /usr/local/bin/.eleven; \
    chown -R 1000:1000 \
      /usr/local/bin \
      /usr/local/bin/.eleven; \
    eleven init;
  USER docker