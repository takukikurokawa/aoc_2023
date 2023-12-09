#!/bin/sh -eu

gfortran fortran$1.f90 -o fortran$1.out
./fortran$1.out < data/in.txt > data/out$1.txt

cat data/out$1.txt

rm fortran$1.out
