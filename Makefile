.PHONY: build
build:
	cargo build --target wasm32-unknown-unknown --release

.PHONY: stream
stream:
	substreams run -e eos.firehose.eosnation.io:9001 substreams.yaml map_accounts -s 1000 -t +10

.PHONY: codegen
codegen:
	substreams protogen ./substreams.yaml --exclude-paths sf/antelope,sf/substreams,google

.PHONY: pack
pack:
	substreams pack ./substreams.yaml
