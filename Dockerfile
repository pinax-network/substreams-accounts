FROM alpine:latest

RUN apk update && apk add --no-cache wget tar

RUN wget -O- https://github.com/streamingfast/substreams-sink-kv/releases/download/v2.1.3/substreams-sink-kv_linux_x86_64.tar.gz | tar -xz -C /usr/local/bin

CMD [ "sh", "-c", "substreams-sink-kv run --listen-addr=0.0.0.0:8000 -e ${SUBSTREAMS_ENDPOINT} badger3:///my-badger.db ${SPKG_URL} kv_out" ]
