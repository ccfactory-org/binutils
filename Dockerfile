FROM ccfactory/buildsystem:gcc-8.3 AS build

ARG BINUTILS_VER=2.36.1
WORKDIR /root

# download
RUN wget http://ftpmirror.gnu.org/binutils/binutils-${BINUTILS_VER}.tar.bz2

# unpack
RUN tar -xjvf binutils-${BINUTILS_VER}.tar.bz2

# configure
RUN mkdir /root/build
WORKDIR /root/build
ARG TARGET=x86_64-linux-gnu
ARG SDK_ROOT=/opt/${TARGET}
#RUN mkdir ${SDK_ROOT}
RUN ../binutils-${BINUTILS_VER}/configure --prefix=${SDK_ROOT} --target=${TARGET} --disable-multilib

# make
ARG MAKEFLAGS
RUN make -j

# install
RUN make install

# prepare final image
FROM debian:buster

COPY --from=build ${SDK_ROOT} ${SDK_ROOT}
