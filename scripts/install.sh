#!/bin/sh

##############################
#                            #
#  Copyright (c) xTekC.      #
#  Licensed under MPL-2.0.   #
#  See LICENSE for details.  # 
#                            #
##############################

set -e

ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

AUTHOR_NAME="xTeKc"
BIN_NAME="unic"

detect_architecture() {
  case "$(uname -s)" in
    Linux)
      case "$(uname -m)" in
        riscv64)
          echo "riscv64gc-unknown-linux-gnu"
          ;;
        aarch64)
          echo "aarch64-linux-android"
          ;;
        *)
          found_file=false
          for file in /lib*/ld-musl-*.so.1; do
            if [ -f "$file" ]; then
              found_file=true
              break
            fi
          done
          if [ "$found_file" = true ]; then
            echo "$(uname -m)-unknown-linux-musl"
          else
            echo "$(uname -m)-unknown-linux-gnu"
          fi
          ;;
      esac
      ;;
    FreeBSD)
      case "$(uname -m)" in
        x86_64)
          echo "x86_64-unknown-freebsd"
          ;;
        *)
          echo "Unsupported BIN_ARCH: $(uname -m)"
          exit 1
          ;;
      esac
      ;;
    NetBSD)
      case "$(uname -m)" in
        x86_64)
          echo "x86_64-unknown-netbsd"
          ;;
        *)
          echo "Unsupported BIN_ARCH: $(uname -m)"
          exit 1
          ;;
      esac
      ;;
    MacOS)
      case "$(uname -m)" in
        aarch64)
          echo "aarch64-apple-darwin"
          ;;
        x86_64)
          echo "x86_64-apple-darwin"
          ;;
        *)
          echo "Unsupported BIN_ARCH: $(uname -m)"
          exit 1
          ;;
      esac
      ;;
    *)
      echo "Unsupported operating system: $(uname -s)"
      exit 1
      ;;
  esac
}

BIN_ARCH=$(detect_architecture)
BIN_VERSION=$(curl -sSL https://api.github.com/repos/${AUTHOR_NAME}/${BIN_NAME}/releases/latest | grep 'tag_name' | cut -d'"' -f4)
BIN_URL="https://github.com/$AUTHOR_NAME/$BIN_NAME/releases/download/$BIN_VERSION/$BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz"
BIN_HASH_URL="https://github.com/$AUTHOR_NAME/$BIN_NAME/releases/download/$BIN_VERSION/$BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz.sha512"
BIN_DIR="$HOME/${BIN_NAME}"

orange_printf() {
  printf '%b\n' "${ORANGE}$1${NC}"
}

purple_printf() {
  printf '%b\n' "${PURPLE}$1${NC}"
}

purple_printf_nnl() {
  printf '%b' "${PURPLE}$1${NC}"
}

green_printf() {
  printf '%b\n' "${GREEN}$1${NC}"
}

cyan_printf() {
  printf '%b\n' "${CYAN}$1${NC}"
}

red_printf() {
  printf '%b\n' "${RED}$1${NC}"
}

ensure() {
  if ! "$@"; then
    echo "Command failed: $*"
    exit 1
  fi
}

download_files() {
  clear
  orange_printf "\n\n$BIN_NAME $BIN_VERSION\n\n"

  BIN_URL="https://github.com/$AUTHOR_NAME/$BIN_NAME/releases/download/$BIN_VERSION/$BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz"
  BIN_HASH_URL="https://github.com/$AUTHOR_NAME/$BIN_NAME/releases/download/$BIN_VERSION/$BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz.sha512"

  purple_printf "Downloading..."
  purple_printf "$BIN_ARCH binary."
  curl -LO "$BIN_URL"

  purple_printf "Downloading..."
  purple_printf "$BIN_ARCH.sha512 hash."
  curl -LO "$BIN_HASH_URL"
}

verify_hash() {
  purple_printf "Verifying binary hash..."
  if sha512sum -c $BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz.sha512 --quiet; then
    printf "#################################\n"
    green_printf "Hash verification succeeded."
    printf "#################################\n"
    purple_printf "Extracting binary..."
    tar -xzvf $BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz -C $HOME
    rm $BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz $BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz.sha512
    purple_printf "Installation complete."

    if [ $BIN_ARCH = "aarch64-linux-android" ]; then
      echo "alias $BIN_NAME=\"./$BIN_NAME/bin/$BIN_NAME\"" >>$HOME/.bashrc
      purple_printf "\nTo use the binary, exit the terminal and re-open.\n"
      purple_printf "Type ${PURPLE}'${NC}exit${PURPLE}'${PURPLE} and press ${NC}Enter${PURPLE}.\n"
    else
      create_symlink
    fi

  else
    printf "#################################\n"
    red_printf "Hash verification failed."
    printf "#################################\n"
    red_printf "The binary integrity cannot be guaranteed."
    rm $BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz $BIN_NAME-$BIN_VERSION-$BIN_ARCH.tar.gz.sha512
    purple_printf "Cleanup complete."
    sleep 2
    clear
  fi
}

create_symlink() {
  while :; do
    purple_printf_nnl "\nCreate a symlink for immediate use of ${NC}$BIN_NAME${PURPLE}? [${NC}Y${PURPLE}/${NC}n${PURPLE}]: "
    read -r response < /dev/tty

    case "$response" in
      [yY] | "" )
          purple_printf "\nRoot is needed to create the ${NC}$BIN_NAME${PURPLE} symlink in ${NC}/usr/local/bin${PURPLE}."
          sudo ln -s "$BIN_DIR/bin/$BIN_NAME" "/usr/local/bin/$BIN_NAME"
          purple_printf "Created ${NC}$BIN_NAME${PURPLE} symlink in ${NC}/usr/local/bin${PURPLE}."
          ls -l /usr/local/bin/$BIN_NAME | awk -v BIN_NAME="${BIN_NAME}" \
                                      -v CYAN="${CYAN}" \
                                      -v GREEN="${GREEN}" \
                                      -v NC="${NC}" \
                                      '{print CYAN "/usr/local/bin/"BIN_NAME NC " -> " GREEN $11 NC}'
          break
          ;;
      [nN] )
          purple_printf "\nAdd the following to ${NC}PATH${PURPLE}:\n"
          echo 'export PATH="$HOME/'$BIN_NAME'/bin:$PATH"'
          purple_printf "\nRestart the terminal session to use ${NC}$BIN_NAME${PURPLE}."
          break
          ;;
      * )
          red_printf "Invalid response. Enter ${NC}Y${RED}/${NC}y${RED} or ${NC}N${RED}/${NC}n${RED}."
          ;;
    esac
  done
}

BIN_ARCH=$(detect_architecture)
download_files
verify_hash
