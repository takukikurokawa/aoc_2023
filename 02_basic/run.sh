#!/bin/sh -eu

fbc basic$1.bas -x basic$1.out
./basic$1.out 

cat data/out$1.txt

rm basic$1.out
