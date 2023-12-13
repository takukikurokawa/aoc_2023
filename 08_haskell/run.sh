#!/bin/sh -eu

ghc haskell$1.hs -o haskell$1.out > /dev/null
./haskell$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm haskell$1.hi
rm haskell$1.o
rm haskell$1.out
