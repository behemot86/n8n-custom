FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk update && apk --no--cache ffmpeg

#npm packaages you wanted
RUN npm install -g axios music-metadata

USER node
