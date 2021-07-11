FROM ccfactory/buildsystem:gcc-3.3 AS build

ARG BINUTILS_VER=2.15
WORKDIR /root

# download
RUN wget http://ftpmirror.gnu.org/binutils/binutils-${BINUTILS_VER}.tar.bz2

# unpack
RUN tar -xjvf binutils-${BINUTILS_VER}.tar.bz2

# configure
RUN mkdir /root/build
WORKDIR /root/build
ARG TARGET=mips-linux-elf
ARG SDK_ROOT=/opt/${TARGET}
#RUN mkdir ${SDK_ROOT}
RUN ../binutils-${BINUTILS_VER}/configure --prefix=${SDK_ROOT} --target=${TARGET} --disable-multilib

# make
RUN make -j

# install
RUN make install
