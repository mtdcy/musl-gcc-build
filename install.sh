#!/bin/bash -e

INSTALL_PATH="${INSTALL_PATH:-/opt}"

info()  { echo -e "🚀 \\033[32m$*\\033[39m"; }

if curl -fsSI --connect-timeout 1 https://git.mtdcy.top -o /dev/null; then
    url=https://git.mtdcy.top:8443/mtdcy/musl-gcc-build/releases/download/latest/$(uname -m)-unknown-linux-musl.tar.xz
else
    url=https://github.com/mtdcy/musl-gcc-build/releases/latest/download/$(uname -m)-unknown-linux-musl.tar.xz
fi

# shellcheck disable=SC2064
TEMPDIR="$(mktemp -d)" && trap "rm -rf $TEMPDIR" EXIT

TARGET="$TEMPDIR/$(basename "$url")"

info "curl < $url"
curl -fsSL "$url" -o "$TARGET"

info "unzip $(basename "$TARGET") > $INSTALL_PATH"
if [ -w "$INSTALL_PATH" ]; then
    tar -C "$INSTALL_PATH" -xf "$TARGET"
else
    sudo tar -C "$INSTALL_PATH" -xf "$TARGET"
fi

CC="$INSTALL_PATH/bin/$(uname -m)-unknown-linux-musl-gcc"

info "check $CC"
"$CC" --version

info "fix ld-musl"
sudo ln -sfv $(find "$INSTALL_PATH/$(uname -m)-unknown-linux-musl" -name libc.so) /lib/ld-musl-$(uname -m).so.1

info "Setup PATH"

append_path() {
    grep -q "PATH=.*$INSTALL_PATH/bin" "$1" || {
        info "echo PATH=$INSTALL_PATH/bin:\$PATH >> $1"

        echo -e "\n#musl-gcc:"                   >> "$1"
        echo    "PATH=$INSTALL_PATH/bin:\$PATH"  >> "$1"
    }
}

[ -f "$HOME/.zprofile" ] && append_path "$HOME/.zprofile" || append_path "$HOME/.zshrc"
[ -f "$HOME/.profile"  ] && append_path "$HOME/.profile"  || append_path "$HOME/.bashrc"
