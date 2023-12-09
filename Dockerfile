FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./


COPY *.go ./

RUN go build -o /project

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /project /project

USER nonroot:nonroot

ENTRYPOINT ["/project"]