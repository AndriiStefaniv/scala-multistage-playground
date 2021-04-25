# Overview
This project implements basic configuration needed for [Docker Multi-stage Build](https://docs.docker.com/develop/develop-images/multistage-build/).

# Play
## Build
```sh
docker build -t scala-multistage-playground:$(git branch --show-current) .
```
## Run
```sh
docker run --rm scala-multistage-playground:$(git branch --show-current)
```
## Inspect
```sh
docker image ls -a | grep scala-multistage-playground
docker stats --no-stream
```
