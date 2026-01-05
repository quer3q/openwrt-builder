FROM ubuntu:latest
RUN apt-get update -y && \
    apt-get install -y \
    sudo make git gcc g++ ack autoconf automake autopoint binutils bison \
    libncurses5-dev libncursesw5-dev build-essential bzip2 ccache cmake cpio \
    unzip wget python3 file rsync gawk xz-utils curl device-tree-compiler \
    fastjar flex gettext gperf haveged help2man intltool libelf-dev libssl-dev \
    libtool lrzsz mkisofs nano ninja-build p7zip patch pkgconf vim xxd \
    software-properties-common python3-pyelftools python3-setuptools swig python3-dev \
    golang-go && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m builder && \
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder

RUN git clone -b openwrt-25.12 --depth 1 https://github.com/openwrt/openwrt

WORKDIR /home/builder/openwrt