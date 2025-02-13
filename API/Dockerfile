FROM golang:1.16

# Install SQLite
RUN apt-get update && apt-get install -y sqlite3

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main .

EXPOSE 5000

CMD ["./main"] 