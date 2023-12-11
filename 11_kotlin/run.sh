#!/bin/sh -eu

kotlinc-native kotlin$1.kt -o kotlin$1
./kotlin$1.kexe < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm kotlin$1.kexe
