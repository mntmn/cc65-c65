#!/bin/bash

# this loads the program to $2001
# and runs the BASIC loader that is embedded
# at the start

m65 -l /dev/ttyUSB1 -1 -r ./example.prg

