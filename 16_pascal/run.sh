#!/bin/sh -eu

fpc pascal$1.pas -opascal$1.out > /dev/null
./pascal$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm pascal$1.o
rm pascal$1.out
