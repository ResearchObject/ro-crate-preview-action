# syntax=docker/dockerfile:1.4.2

FROM node:19

## Install ro-crate-html-js
RUN npm install --global ro-crate-html-js

## Copy code file from repo to Docker filesystem
COPY entrypoint.sh /entrypoint.sh

## Code to run when the docker container starts
ENTRYPOINT ["/entrypoint.sh"]
