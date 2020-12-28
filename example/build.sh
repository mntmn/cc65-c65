#!/bin/bash

set -xe

CC65=../../mega65-tools/cc65/bin

$CC65/cl65 -O -t none --cpu 6502 -o example.prg --config ../c65.cfg -m example.map example.c ../c65.lib
