#!/bin/sh -eu

#erlc erlang$1.erl
#erl -noshell -eval "erlang$1:main()." -s init stop < data/in.txt > data/out$1.txt

escript erlang$1.erl < data/in.txt > data/out$1.txt

cat data/out$1.txt

#rm erlang$1.beam
