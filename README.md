# musl-gcc|musl-g++ prebuilts of [musl-cross-make](https://github.com/richfelker/musl-cross-make/) for Linux

## Quick Start 

```shell
# Github
curl -fsSL https://github.com/mtdcy/musl-gcc-build/releases/latest/download/$(uname -m)-unknown-linux-musl.tar.xz | tar -C /opt -xJv
# CN
curl -fsSL https://git.mtdcy.top:8443/mtdcy/musl-gcc-build/releases/download/latest/$(uname -m)-unknown-linux-musl.tar.xz | tar -C /opt -xJv

export PATH=/opt/bin:$PATH

$(uname -m)-unknown-linux-musl-gcc --version
```

## How to build

```shell
# Github
git clone https://github.com/mtdcy/musl-gcc-build.git
# CN
git clone https://git.mtdcy.top:8443/mtdcy/musl-gcc-build.git

cd musl-gcc-build

# custom build settings
nvim config.mak

./build.sh
```

## License

- [musl-cross-make](https://github.com/richfelker/musl-cross-make/) is licensed under MIT.
- This project is liecensed under BSD-2-Clause.
