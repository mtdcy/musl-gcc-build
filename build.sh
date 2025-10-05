#!/bin/bash -ex

TAG=${TAG:-v0.9.11}

build=musl-cross-make
target=$(uname -m)-unknown-linux-musl

# submodules
git submodule update --init --recursive --force

pushd "$build"

git checkout $TAG --force 

sed -i Makefile \
    -e 's/ftpmirror.gnu.org/mirrors.ustc.edu.cn/g' 

# cached packages
ln -sf ../sources .

touch sources/*

cp config.mak.dist config.mak

TARGET=$target make

TARGET=$target make install

popd

tar -C $build/output -cvf $target.tar.xz .
