#!/usr/bin/env bash

# generate ./kv.pb from read.proto protobufs
buf build --as-file-descriptor-set -o kv.pb