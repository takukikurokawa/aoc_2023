#!/bin/sh -eu

cp x10$1.x10 Main.x10
x10c Main.x10
x10 Main < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm Main*
