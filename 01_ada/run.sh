#!/bin/sh -eu

gnatmake ada$1.adb -o ada$1.out
./ada$1.out < in$1.txt > out$1.txt

cat out$1.txt

rm ada$1.ali
rm ada$1.o
rm ada$1.out
