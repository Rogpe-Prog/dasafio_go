FROM golang AS builder

WORKDIR /build
COPY hello.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  go build -o app \
  -ldflags="-w" hello.go

FROM scratch
COPY --from=builder /build/app /app
ENTRYPOINT [ "/app" ]

# docker build -t rogpe/codeeducation .
# docker run -it --rm rogpe/codeeducation