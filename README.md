# Docker container for Yocto builds

The script `build.sh` creates a Docker image, in which you can run a Yocto build. Calling

    build.sh <tag> <dir-path>

builds the Docker image "dr-yocto:\<tag>" from the `Dockerfile` located in `<dir-path>`. 
This project provides a Dockerfile based on Ubuntu 18.04 in the subdirectory `./18.04`.
Ubuntu 18.04 LTS is suited to build Yocto Thud, Warrior, Zeus and most likely Dunfell. 
You can build the Docker image with the command `build.sh 18.04 ./18.04` from the base 
directory of the repository.

The script `run-shell.sh` runs the Docker image built before interactively. The syntax is

    run.sh <tag>

For example, `run.sh 18.04` runs the Docker image `dr-yocto:18.04` and starts a shell.


