#!/bin/sh -eu

gdc d$1.d -o d$1.out
./d$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm d$1.out
