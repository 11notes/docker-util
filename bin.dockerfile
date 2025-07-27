# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
# :: FOREIGN IMAGES
  FROM 11notes/distroless:upx AS distroless-upx
  FROM 11notes/distroless:strip AS distroless-strip
  FROM 11notes/distroless:file AS distroless-file
  FROM 11notes/distroless:pv AS distroless-pv
  FROM 11notes/distroless:curl AS distroless-curl

# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: FILE SYSTEM
  FROM alpine AS file-system

  COPY ./rootfs /

  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    chmod +x -R /usr/local/bin/.eleven;

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: HEADER
  FROM scratch
  COPY --from=distroless-upx / /
  COPY --from=distroless-strip / /
  COPY --from=distroless-file / /
  COPY --from=distroless-pv / /
  COPY --from=distroless-curl / /
  COPY --from=file-system /usr/local/bin /usr/local/bin