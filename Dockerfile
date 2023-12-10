FROM golang:1.18-alpine

WORKDIR /

COPY ./tiny_http_server.go /tiny_http_server.go

RUN go build -v -o /usr/local/bin/tiny_http_server /tiny_http_server.go

EXPOSE 8080

ENV DIR=/data PORT=8080

RUN rm -rf /tiny_http_server.go $(go env GOCACHE) /go

ENTRYPOINT tiny_http_server -dir ${DIR} -port ${PORT}
