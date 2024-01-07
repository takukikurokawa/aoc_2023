#!/bin/sh -eu

java -jar /opt/yeti.jar yeti$1.yeti < data/in.txt > data/out$1.txt

cat data/out$1.txt
