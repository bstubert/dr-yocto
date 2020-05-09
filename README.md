# Docker container for Yocto builds

The script `build.sh` creates a Docker image, in which you can run a Yocto build. Calling

    build.sh <tag> <dir-path>

builds the Docker image "dr-yocto:\<tag>" from the `Dockerfile` located in `<dir-path>`. 
This project provides a Dockerfile for Yocto Zeus (3.0) in the subdirectory `./zeus`. You can
build it with the command `build.sh zeus ./zeus` from the base directory of the repository.

The script `run-shell.sh` runs the Docker image built before interactively. The syntax is

    run.sh <tag>

For example, `run.sh zeus` runs the Docker image `dr-yocto:zeus` and starts a shell.


