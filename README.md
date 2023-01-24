# Antelope Accounts substream

## Install Substreams CLI
`brew install streamingfast/tap/substreams` or one of the other options: https://substreams.streamingfast.io/getting-started/installing-the-cli

## Build and test substream
1. `make codegen`
2. `make build`
3. `make stream`

## Install Substreams KV sink
1. Download the Substream Key-Value sink release: https://github.com/streamingfast/substreams-sink-kv/releases
2. Extract the substreams-sink-kv from the tarball into a folder available in your PATH.

## Run
```
substreams-sink-kv run \
  "badger3:///$(pwd)/my-badger.db" \
  "eos.firehose.eosnation.io:9001" \
  "substreams.yaml" \
  kv_out
```

## Query
grpcurl --plaintext   -d '{"key":"ha4tonjtgmge"}' localhost:8000 sf.substreams.sink.kv.v1.Kv/Get