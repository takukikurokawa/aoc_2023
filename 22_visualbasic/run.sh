#!/bin/sh -eu

vbnc visualbasic$1.vb > /dev/null
mono visualbasic$1.exe < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm visualbasic$1.exe
