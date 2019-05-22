FROM golang:alpine

WORKDIR $GOPATH/src/github.com/coreos/container-linux-config-transpiler

RUN apk add --no-cache --virtual .build-deps bash git make dumb-init \
  && \
    git clone https://github.com/coreos/container-linux-config-transpiler.git . && \
    make && mkdir -p /export && mv bin/ct /export/ct && mv /usr/bin/dumb-init /export/dumb-init \
  && \
   rm -rf $GOPATH && apk del .build-deps && rm -rf /var/cache/apk

# ------------------------------------------------------------------------------

FROM golang:alpine
COPY --from=0 /export/* /usr/bin/
WORKDIR /ct

ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["/usr/bin/ct","-help"]
