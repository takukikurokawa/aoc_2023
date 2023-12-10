#!/bin/sh -eu

julia julia$1.jl < data/in.txt > data/out$1.txt

cat data/out$1.txt
