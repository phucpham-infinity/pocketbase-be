FROM golang AS build-backend

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -o appName .

FROM alpine:latest AS production
COPY --from=build-backend /app .
EXPOSE 8080
CMD ["./appName", "serve", "--http=0.0.0.0:8080"]