# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: FILE SYSTEM
  FROM alpine AS file-system

  COPY ./rootfs/container /

  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    chmod +x -R /usr/local/bin/.eleven;

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
# :: HEADER
  FROM scratch
  COPY --from=file-system /usr/local/bin /usr/local/bin