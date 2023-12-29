#!/bin/sh -eu

ts-node typescript$1.ts < data/in.txt > data/out$1.txt

cat data/out$1.txt
