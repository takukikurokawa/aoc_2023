#!/bin/sh -eu

cobc -x cobol$1.cob -o cobol$1.out
./cobol$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm cobol$1.out
