#!/bin/sh -eu

unicon -s unicon$1.icn -x < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm unicon$1
