FROM alpine:latest AS builder
RUN apk add --no-cache g++ git make cmake ninja openssl-dev
RUN git clone https://github.com/duckdb/duckdb.git
WORKDIR /duckdb
RUN GEN=ninja make

FROM alpine:latest
COPY --from=builder /duckdb/build/release/duckdb /usr/local/bin/duckdb
ENTRYPOINT ["/usr/local/bin/duckdb"]