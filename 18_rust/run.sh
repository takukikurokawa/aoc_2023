#!/bin/sh -eu

rustc rust$1.rs -o rust$1.out
./rust$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm rust$1.out
