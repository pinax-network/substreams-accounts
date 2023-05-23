FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget git python3

RUN wget -O- https://github.com/streamingfast/substreams-sink-kv/releases/download/v2.1.3/substreams-sink-kv_linux_x86_64.tar.gz \
    | tar -xz -C /usr/local/bin

RUN wget -O- https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh \
    | bash

CMD [ "sh", "-c", "substreams-sink-kv run --listen-addr=0.0.0.0:8000 -e ${SUBSTREAMS_ENDPOINT} badger3:///my-badger.db ${SPKG_URL} kv_out" ]
