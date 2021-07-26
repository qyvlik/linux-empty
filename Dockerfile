FROM frolvlad/alpine-gxx as builder

RUN apk add --no-cache git build-base

WORKDIR /empty

RUN git clone https://git.code.sf.net/p/empty/code /empty

RUN make all

RUN ls -lah

FROM alpine:3.11

VOLUME /tmp

RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  bash \
  busybox-extras \
  oath-toolkit-oathtool \
  expect

COPY --from=builder /empty/empty /usr/bin/empty

RUN chmod 755 /usr/bin/empty
