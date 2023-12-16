#!/bin/sh -eu

ocamlc ocaml$1.ml -o ocaml$1.out
./ocaml$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm ocaml$1.cmi
rm ocaml$1.cmo
rm ocaml$1.out
