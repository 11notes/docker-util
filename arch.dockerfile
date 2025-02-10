# :: Header
  FROM 11notes/alpine:stable

# :: Run
  USER root

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 /usr/local/bin;

# :: Start
  USER docker