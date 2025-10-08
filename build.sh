#!/bin/bash -ex

TAG=${TAG:-v0.9.11}

REPO=${REPO:-https://git.mtdcy.top:8443/mtdcy/musl-gcc-build.git}

test -f build.sh || {
    git clone $REPO musl-gcc
    cd musl-gcc
    exec ./build.sh
}

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

ln -sfv ../config.mak .

{ 
    TARGET=$target make

    TARGET=$target make install
} | tee "../$target.log"

popd

make config.md

tar -C $build/output -cvf $target.tar.xz .
