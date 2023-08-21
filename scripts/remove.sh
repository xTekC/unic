#!/bin/sh

##############################
#                            #
#  Copyright (c) xTekC.      #
#  Licensed under MPL-2.0.   #
#  See LICENSE for details.  # 
#                            #
##############################

set -e

RED='\033[0;31m'
NC='\033[0m' # No Color

red_printf() {
  printf '%b\n' "${RED}$1${NC}"
}

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
BIN_DIR="$HOME/${BIN_NAME}"

remove_bin() {
  clear
  if [ -d $BIN_DIR ]; then
    rm -rf $BIN_DIR

    if [ $BIN_ARCH = "aarch64-linux-android" ]; then
      red_printf "Removed ${NC}$BIN_NAME${RED} binary from ${NC}$BIN_DIR${RED}.\n"
      sed -i '/alias '$BIN_NAME'=".\/'$BIN_NAME'\/bin\/'$BIN_NAME'"/d' $HOME/.bashrc
      red_printf "Removed ${NC}$BIN_NAME${RED} binary alias."
    else
      red_printf "Removed ${NC}$BIN_NAME${RED} binary from ${NC}$BIN_DIR${RED}.\n"     
      red_printf "Root is needed to remove ${NC}$BIN_NAME${RED} symlink in ${NC}/usr/local/bin${RED}."
      if [ $BIN_ARCH = "x86_64-unknown-freebsd" ] || [ $BIN_ARCH = "x86_64-unknown-netbsd" ]; then
        su -c "rm /usr/local/bin/$BIN_NAME"
      else
        sudo rm /usr/local/bin/$BIN_NAME
      fi
      red_printf "Removed ${NC}$BIN_NAME${RED} symlink from ${NC}/usr/local/bin${RED}."
    fi
    
  else
    red_printf "\n${NC}$BIN_NAME${RED} binary not found."
  fi
}

remove_bin
