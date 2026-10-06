# Build stage
FROM golang:1.24 AS builder

WORKDIR /app

COPY . .

RUN go mod init hello-app 2>/dev/null || true
RUN CGO_ENABLED=0 GOOS=linux go build -o hello-app .

# Runtime stage
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/hello-app .

CMD ["./hello-app"]
