FROM golang:1.23.2-alpine3.20 AS buildStage

WORKDIR /pasta

COPY go.mod ./
COPY main.go ./

RUN go build -o pasta

FROM alpine:3.20

USER root
RUN mkdir /pasta && chown 1001:1001 /pasta

USER 1001:1001
WORKDIR /pasta
COPY --from=buildStage /pasta/pasta /pasta
EXPOSE 8080

ENTRYPOINT ["/pasta/pasta"]
