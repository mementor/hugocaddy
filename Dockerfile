FROM alpine:edge
MAINTAINER Thibault NORMAND <me@zenithar.org>

ENV GOPATH /go
ENV CADDY_TAG v0.8.0
ENV OPENSSL_VERSION 1.0.2e-r0

RUN echo '@community http://dl-4.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk add --update musl \
    && apk add ca-certificates 'go@community>=1.4.3' "openssl>=$OPENSSL_VERSION" git mercurial \
    && mkdir /go \
    && cd $GOPATH \
    && go get -d github.com/caddyserver/caddyext \
    && cd $GOPATH/src/github.com/caddyserver/caddyext \
    && go build -a -installsuffix cgo -tags netgo -ldflags '-w' -o $GOPATH/bin/caddyext \
    && go get -d github.com/mholt/caddy \
    && cd $GOPATH/src/github.com/mholt/caddy \
    && git checkout ${CADDY_VERSION} \
    && cd $GOPATH \
    && bin/caddyext install git \
    && bin/caddyext build bin/ \
    && mv $GOPATH/bin/customCaddy /bin/caddy \
    && mkdir /caddy \
    && apk del --purge mercurial go \
    && rm -rf $GOPATH /var/cache/apk/* \
    && printf "0.0.0.0" > /etc/Caddyfile

RUN mkdir /srv

EXPOSE 	   2015
EXPOSE 	   80
EXPOSE 	   443

WORKDIR    /srv

ENTRYPOINT [ "/bin/caddy" ]
CMD        [ "--conf", "/etc/Caddyfile" ]
