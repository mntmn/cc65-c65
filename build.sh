#!/bin/bash

CC65=../mega65-tools/cc65

cp $CC65/lib/supervision.lib ./c65.lib
$CC65/bin/ca65 crt0.s
$CC65/bin/ar65 a c65.lib crt0.o 

