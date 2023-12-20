#!/bin/sh -eu

swiftc swift$1.swift -o swift$1.out
./swift$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm swift$1.out
