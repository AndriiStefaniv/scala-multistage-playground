# Builder image
FROM alpine:3.13.5 as builder
# Installing JDK and SBT
WORKDIR /workdir
RUN apk --no-cache add openjdk8 bash
RUN wget -q -O - "https://github.com/sbt/sbt/releases/download/v1.5.0/sbt-1.5.0.tgz" | gunzip | tar -x -C /usr/local
ENV PATH=/usr/local/sbt/bin:$PATH
# Build
WORKDIR /build
COPY . .
RUN sbt stage

# Production image
FROM openjdk:8u181-jre-alpine as production
RUN apk add --no-cache bash
WORKDIR /app
COPY --from=builder /build/target/universal/stage/ .
CMD [ "/app/bin/build" ]
