#
# config.mak.dist - sample musl-cross-make configuration
#
# Copy to config.mak and edit as desired.
#

# There is no default TARGET; you must select one here or on the make
# command line. Some examples:

# TARGET = i486-linux-musl
# TARGET = x86_64-linux-musl
# TARGET = arm-linux-musleabi
# TARGET = arm-linux-musleabihf
# TARGET = sh2eb-linux-muslfdpic
# ...

# By default, cross compilers are installed to ./output under the top-level
# musl-cross-make directory and can later be moved wherever you want them.
# To install directly to a specific location, set it here. Multiple targets
# can safely be installed in the same location. Some examples:

# OUTPUT = /opt/cross
# OUTPUT = /usr/local

# By default, latest supported release versions of musl and the toolchain
# components are used. You can override those here, but the version selected
# must be supported (under hashes/ and patches/) to work. For musl, you
# can use "git-refname" (e.g. git-master) instead of a release. Setting a
# blank version for gmp, mpc, mpfr and isl will suppress download and
# in-tree build of these libraries and instead depend on pre-installed
# libraries when available (isl is optional and not set by default).
# Setting a blank version for linux will suppress installation of kernel
# headers, which are not needed unless compiling programs that use them.

#LINUX_VER = 5.8.5
BINUTILS_VER = 2.33.1
GCC_VER = 13.3.0
MUSL_VER = 1.2.5
GMP_VER = 6.1.2
MPC_VER = 1.1.0
MPFR_VER = 4.0.2
ISL_VER = 0.21

# By default source archives are downloaded with wget. curl is also an option.

# DL_CMD = wget -c -O
# DL_CMD = curl -C - -L -o

# Check sha-1 hashes of downloaded source archives. On gnu systems this is
# usually done with sha1sum.

# SHA1_CMD = sha1sum -c
# SHA1_CMD = sha1 -c
# SHA1_CMD = shasum -a 1 -c

# Something like the following can be used to produce a static-linked
# toolchain that's deployable to any system with matching arch, using
# an existing musl-targeted cross compiler. This only works if the
# system you build on can natively (or via binfmt_misc and qemu) run
# binaries produced by the existing toolchain (in this example, i486).

# COMMON_CONFIG += CC="i486-linux-musl-gcc -static --static" CXX="i486-linux-musl-g++ -static --static"
ifneq ($(shell which $(TARGET)-gcc),)
	COMMON_CONFIG += CC="$(TARGET)-gcc -static --static"
	COMMON_CONFIG += CXX="$(TARGET)-g++ -static --static"
endif

# Recommended options for smaller build for deploying binaries:

# these configs affect only gcc and binutils
# 1. 增加 -pipe 以减少临时文件生成（虽然会多占一点内存，但对 I/O 友好）
# 2. 移除 -fPIC：如果是编译纯静态工具链，-fPIC 通常是不需要的，除非要做插件
COMMON_CONFIG += CFLAGS="-g0 -Os -pipe --static"
COMMON_CONFIG += CXXFLAGS="-g0 -Os -pipe --static"
COMMON_CONFIG += LDFLAGS="-s -static"
COMMON_CONFIG += --disable-nls

# MUSL_CONFIG does NOT taken COMMON_CONFIG settings
# Options for musl libc: both shared and static libc will be built, so not --static here
MUSL_CONFIG += CFLAGS="-g0 -Os -fPIC"

# Options you can add for faster/simpler build at the expense of features:

# GCC_CONFIG += --disable-libquadmath --disable-decimal-float
# GCC_CONFIG += --disable-libitm
# GCC_CONFIG += --disable-fixed-point
GCC_CONFIG += --disable-lto
GCC_CONFIG += --disable-nls
GCC_CONFIG += --disable-plugin
GCC_CONFIG += --disable-multilib

# 在 CI/Docker 镜像中，通常不需要三阶段校验，极大缩短构建时间
GCC_CONFIG += --disable-bootstrap
# 禁用预编译头，减少内存占用和 fork 时的文件 IO
GCC_CONFIG += --disable-libstdcxx-pch
# 禁用一些非核心组件，减少 GCC 内部的“链式反应”
GCC_CONFIG += --disable-libquadmath --disable-decimal-float --disable-fixed-point

# By default C and C++ are the only languages enabled, and these are
# the only ones tested and known to be supported. You can uncomment the
# following and add other languages if you want to try getting them to
# work too.

# build ffmpeg needs objc
GCC_CONFIG += --enable-languages=c,c++,objc

# You can keep the local build path out of your toolchain binaries and
# target libraries with the following, but then gdb needs to be told
# where to look for source files.

# COMMON_CONFIG += --with-debug-prefix-map=$(CURDIR)=
