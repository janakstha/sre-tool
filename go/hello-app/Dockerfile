FROM golang:1.23.2 as builder
WORKDIR /app
RUN go mod init hello-app
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-app

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /hello-app /hello-app
ENV PORT 9000
USER nonroot:nonroot
CMD ["/hello-app"]