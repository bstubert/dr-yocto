#!/bin/bash

# argument 1: code name of the Yocto version (e.g., rocko, zeus) used as container tag
# argument 2: path to Dockerfile

docker build --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --tag "dr-yocto:$1" $2

