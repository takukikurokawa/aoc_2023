#!/bin/sh -eu

go run go$1.go < data/in.txt > data/out$1.txt

cat data/out$1.txt
