FROM golang:latest
RUN mkdir /app
WORKDIR /app
COPY main.go go.mod go.sum /app/
RUN go mod download
ARG VERSION
ENV VERSION=$VERSION
CMD ["go", "run", "main.go"]