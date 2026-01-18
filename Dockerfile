# -------- STAGE 1: get ffmpeg ----------
FROM debian:bookworm-slim AS ffmpeg-builder

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# -------- STAGE 2: final n8n image ----------
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# copy ffmpeg binary from builder
COPY --from=ffmpeg-builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu

# install npm packages
RUN npm install -g axios music-metadata

USER node
