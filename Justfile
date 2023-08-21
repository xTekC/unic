#!/bin/just

##############################
#                            #
#  Copyright (c) xTekC.      #
#  Licensed under MPL-2.0.   #
#  See LICENSE for details.  # 
#                            #
##############################

_default:
  clear && just --list --unsorted

# Watch with fmt and clippy
w:
    clear
    cargo watch -x "cargo fmt --all && cargo clippy --locked --all-targets"

# Build debug profile
b:
    clear
    cargo build

# Run debug profile
r:
    clear
    cargo run

# Format and Lint
fl:
    clear
    cargo fmt --all
    cargo clippy --locked --all-targets

# Dprint fmt
dp:
    clear
    dprint fmt --config config/dprint.json

# Test all
t:
    clear
    cargo test

# Update locked Dependencies
u:
    clear
    cargo update

# Clean build artifacts and Cargo.lock
c:
    clear
    rm -rf target/
    rm Cargo.lock

# Create a new release
rel version:
    bash scripts/release.sh {{ version }}
