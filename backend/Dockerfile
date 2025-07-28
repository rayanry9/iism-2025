FROM golang:1.24 AS build-stage
 
WORKDIR /root

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY ./internal ./internal
COPY ./main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o app

FROM scratch

WORKDIR /

COPY --from=build-stage /root/app ./app
COPY ./internal/migrations/ ./internal/migrations/

EXPOSE 8173

CMD ["./app"]

