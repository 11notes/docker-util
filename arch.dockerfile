# :: Header
  FROM 11notes/alpine:stable
  ARG APP_NO_CACHE

# :: Run
  USER root
  COPY ./rootfs /
  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    chmod +x -R /usr/local/bin/.eleven; \
    eleven init;
  USER docker