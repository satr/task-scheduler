#build the scheduler and run it
FROM golang:1.19-alpine3.18 AS builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o scheduler .

#run the scheduler
FROM bitnami/bitnami-shell
COPY --from=builder /app/scheduler /scheduler
USER 1000
CMD ["/scheduler", "--command=echo \"$(date)\"", "--schedule=0/5 * * * * *"]
