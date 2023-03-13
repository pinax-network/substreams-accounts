# Antelope Accounts substream

### Quickstart
This docker container runs key-value sink for [accounts substreams](https://github.com/pinax-network/substreams/releases/tag/accounts-v0.4.0) and offers multiple ways to access the data

#### Start the sink in Docker
```
$ docker compose up
```

#### Query


gRPC:
```
grpcurl --plaintext -d '{"key":"ha4tonjtgmge"}' localhost:8000 sf.substreams.sink.kv.v1.Kv/Get
```

Connect:
```
curl http://localhost:8000/sf.substreams.sink.kv.v1.Kv/Get -H 'content-type: application/json' --data-raw '{"key":"ha4tonjtgmge"}'
```

HTTP GET:
```
curl http://localhost:8080/get?key=ha4tonjtgmge
```

Note that currently you will need to decode the `value` using `accounts.proto` protobuf

In addition to `Get` method, also `GetMany`, `GetByPrefix`, and `Scan` methods are available:
```
curl http://localhost:8080/getbyprefix?prefix=eosnation&limit=1
```
```
curl http://localhost:8080/getmany?keys=eosnationftw&keys=ha4tonjtgmge
```
```
curl http://localhost:8080/scan?begin=eosnation&limit=10
```