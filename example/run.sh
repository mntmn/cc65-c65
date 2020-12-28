#!/bin/bash

# this loads the program to $0500
# so start it on the C65 with SYS 1280
# or via serial monitor with g500

m65 -l /dev/ttyUSB1 -1 ./example.prg

