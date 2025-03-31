# :: Header
  FROM alpine AS build
  ARG APP_NO_CACHE

# :: Run
  USER root
  COPY ./rootfs /
  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    chmod +x -R /usr/local/bin/.eleven; \
    /usr/local/bin/eleven init;

# :: Distroless
  FROM scratch
  COPY --from=build /usr/local/bin/ /usr/local/bin