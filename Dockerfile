FROM node:23-slim

RUN apt-get update && apt-get install -y \
  vim
