#!/bin/sh -eu

maxima -q -b maxima$1.mac > /dev/null

cat data/out$1.txt
