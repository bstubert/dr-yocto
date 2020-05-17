# Copyright 2019-2020, Burkhard Stubert (DBA Embedded Use)

# The parent directory contains two helper scripts to build and run the Docker image.
#
# The script
#     build.sh <tag> <dir-path>
# builds a Docker image with the name "dr-yocto" and the tag "<tag>" ("dr-yocto:<tag>", for
# short) from the Dockerfile found in <dir-path>. If you are in the parent directory of this
# file, you can call
#     ./build.sh 18.04 ./18.04
# to build the image "dr-yocto:18.04".
#
# The script
#     run-shell.sh <tag>
# runs the Docker image "dr-yocto:<tag>" just built. For example,
#     run-shell.sh 18.04
# runs the Docker image "dr-yocto:18.04".
#
# Note that you can use any string for <tag>. It need not be the name of a Ubuntu version.

# Use Ubuntu 18.04 LTS (Bionic Beaver) as the basis for the Docker image.
FROM ubuntu:18.04

# Install all Linux packages required for Yocto builds as given in section "Build Host Packages"
# on https://www.yoctoproject.org/docs/3.0.2/brief-yoctoprojectqs/brief-yoctoprojectqs.html.
# I added the package git-lfs, which I found missing during a Yocto build.
# Without DEBIAN_FRONTEND=noninteractive, the image build hangs indefinitely
# at "Configuring tzdata". Even if you answer the question about the time zone, it will
# not proceed.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm git-lfs

# These packages are not needed for the Yocto build but in this file below.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    locales sudo

# By default, Ubuntu uses dash as an alias for sh. Dash does not support the source command
# needed for setting up Yocto build environments. Use bash as an alias for sh.
RUN which dash &> /dev/null && (\
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash) || \
    echo "Skipping dash reconfigure (not applicable)"

# Install the repo tool to handle git submodules (meta layers) comfortably.
ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/repo

# Set the locale to en_US.UTF-8, because the Yocto build fails without any locale set.
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Add user "embeddeduse" to sudoers. Then, the user can install Linux packages in the container.
ENV USER_NAME embeddeduse
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME}

# The running container writes all the build artefacts to a host directory (outside the container).
# The container can only write files to host directories, if it uses the same user ID and
# group ID owning the host directories. The host_uid and group_uid are passed to the docker build
# command with the --build-arg option. By default, they are both 1001. The docker image creates
# a group with host_gid and a user with host_uid and adds the user to the group. The symbolic
# name of the group and user is embeddeduse.
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

# Perform the Yocto build as user embeddeduse (not as root).
# By default, docker runs as root. However, Yocto builds should not be run as root, but as a 
# normal user. Hence, we switch to the newly created user embeddeduse.
USER $USER_NAME

WORKDIR /public/Work


