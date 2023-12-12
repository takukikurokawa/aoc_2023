#!/bin/sh -eu

clisp lisp$1.lisp < data/in.txt > data/out$1.txt

cat data/out$1.txt
