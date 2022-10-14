# syntax=docker/dockerfile:1.4.2

FROM ubuntu:20.04

## Install requirements

RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
                      apt-get install -y \
                                      nodejs \
                                      npm

## Install ro-crate-html-js
RUN npm install ro-crate-html-js
ENV PATH "/node_modules/.bin:$PATH"

## Copy code file from repo to Docker filesystem
COPY entrypoint.sh /entrypoint.sh

## Code to run when the docker container starts
ENTRYPOINT ["/entrypoint.sh"]
