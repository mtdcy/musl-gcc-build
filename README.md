# musl-gcc|musl-g++ prebuilts of [musl-cross-make](https://github.com/richfelker/musl-cross-make/) for Linux

## Quick Start 

```shell
# Github
bash -c "$(curl -fsSL https://github.com/mtdcy/musl-gcc-build/raw/refs/heads/main/build.sh)"
# CN
bash -c "$(curl -fsSL https://git.mtdcy.top:8443/mtdcy/musl-gcc-build/raw/branch/main/install.sh)"
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
