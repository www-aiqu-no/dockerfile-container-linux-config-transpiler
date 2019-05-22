FROM golang:alpine

WORKDIR $GOPATH/src/github.com/coreos/container-linux-config-transpiler

RUN apk add --no-cache --virtual .build-deps bash git make \
  && \
    git clone https://github.com/coreos/container-linux-config-transpiler.git . && \
    make && mkdir -p /export && mv bin/ct /export/ct \
  && \
   rm -rf $GOPATH && apk del .build-deps && rm -rf /var/cache/apk

FROM golang:alpine

COPY --from=0 /export/ct /usr/bin/

CMD ["-help"]

ENTRYPOINT ["/usr/bin/ct"]
