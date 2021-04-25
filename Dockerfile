# Builder image
FROM alpine:3.13.5 as builder
# Installing JDK and SBT
WORKDIR /workdir
RUN apk --no-cache add openjdk8 bash
RUN wget -q -O - "https://github.com/sbt/sbt/releases/download/v1.5.0/sbt-1.5.0.tgz" | gunzip | tar -x -C /usr/local
ENV PATH=/usr/local/sbt/bin:$PATH
# Scala Native dependencies
RUN apk --no-cache add libc-dev build-base clang
# Build
WORKDIR /build
COPY . .
RUN sbt nativeLink

# Production image
FROM alpine:3.13.5 as production
RUN apk --no-cache add llvm
WORKDIR /app
COPY --from=builder /build/target/scala-2.13/build-out bin/build
CMD [ "/app/bin/build" ]
