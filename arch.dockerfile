# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: file system
  FROM alpine AS file-system
  ARG APP_NO_CACHE
  USER root

  COPY ./rootfs /

  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    chmod +x -R /usr/local/bin/.eleven;

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: HEADER
  FROM scratch
  COPY --from=file-system /usr/local/bin /usr/local/bin