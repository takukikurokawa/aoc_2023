#!/bin/sh -eu

wren_cli wren$1.wren > data/out$1.txt

cat data/out$1.txt
