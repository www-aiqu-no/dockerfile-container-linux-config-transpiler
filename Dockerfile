FROM golang:alpine
ARG GIT_BRANCH=master

WORKDIR $GOPATH/src/github.com/coreos/container-linux-config-transpiler

RUN apk add --no-cache --virtual .build-deps bash git make dumb-init \
  && \
    git clone --quiet --branch $GIT_BRANCH https://github.com/coreos/container-linux-config-transpiler.git . && \
    make && mkdir -p /export && mv bin/ct /export/ct && mv /usr/bin/dumb-init /export/dumb-init \
  && \
   rm -rf $GOPATH && apk del .build-deps

# ------------------------------------------------------------------------------

FROM golang:alpine

COPY --from=0 /export/* /usr/bin/

ENTRYPOINT ["/usr/bin/dumb-init","/usr/bin/ct"]
CMD ["-help"]
