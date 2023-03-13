FROM alpine:latest

RUN apk update && apk add --no-cache wget tar

RUN wget -O- https://github.com/pinax-network/substreams/releases/download/accounts-v0.4.0/substreams-sink-kv.tar.gz | tar -xz -C /usr/local/bin

CMD [ "sh", "-c", "substreams-sink-kv run --listen-addr=0.0.0.0:8000 -e ${SUBSTREAMS_ENDPOINT} badger3:///my-badger.db ${SPKG_URL} kv_out" ]
