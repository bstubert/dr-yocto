#!/bin/bash

# argument 1: code name of the Yocto version (e.g., rocko, zeus) used as container tag

docker run -it --rm -v $PWD:/public/Work dr-yocto:$1

