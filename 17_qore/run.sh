#!/bin/sh -eu

qore qore$1.q < data/in.txt > data/out$1.txt

cat data/out$1.txt
