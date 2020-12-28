# Experimental CC65 C Support for MEGA65 C65 Mode

This is a very minimalistic first step to target the C65 mode on MEGA65 with the CC65 toolchain. I followed the "customizing" steps but didn't take care of interrupt/vectors yet:

https://cc65.github.io/doc/customizing.html

I chose the zeropage ($18-$31) and RAM ($0500-$0FFF) locations experimentally and based on what I gathered from the PDF at: https://65site.de/map.php

There is no file i/o or any C stdlib support yet. This is only suitable for some baremetal tests (like in the `example` folder). The next step would be to unmap BASIC 10, because it makes a large amount of the 64kB area non-executable. Also, a malloc implementation should be added that makes use of the higher memory areas, and the usable parts from the C64-side MEGA65 clib should be pulled in.

## Building c65.lib

Edit the path to `cc65` in `build.sh` and run it.

## Building and running the example

Edit the path to `cc65` in `example/build.sh` and run it.

Load the resulting `example.prg` to your MEGA65 in C65 mode (see `example/run.sh`) and enter `SYS 1280` to start it (or `g500` in the monitor).
