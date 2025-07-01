# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: FOREIGN IMAGES
  FROM 11notes/distroless:upx AS distroless-upx
  FROM 11notes/distroless:strip AS distroless-strip
  FROM 11notes/distroless:file AS distroless-file
  FROM 11notes/distroless:pv AS distroless-pv

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: HEADER
  FROM scratch
  COPY --from=distroless-upx / /
  COPY --from=distroless-strip / /
  COPY --from=distroless-file / /
  COPY --from=distroless-pv / /