FROM alpine:latest

RUN apk update && apk add --no-cache wget tar

RUN wget -O- https://github.com/streamingfast/substreams-sink-kv/releases/download/v0.1.2/substreams_sink_kv_linux_x86_64.tar.gz | tar -xz -C /usr/local/bin

CMD [ "substreams-sink-kv", "run", "--listen-addr=0.0.0.0:8000", "badger3:///my-badger.db", "eos.firehose.eosnation.io:9001", "https://github.com/pinax-network/substreams/releases/download/accounts-v0.4.0/accounts-v0.4.0.spkg", "kv_out" ]
