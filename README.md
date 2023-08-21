<div align="center">

# unic
...

<!-- <a href="https://crates.io/crates/unic/"><img src="https://img.shields.io/crates/v/unic?style=flat&amp;labelColor=032a1a&amp;color=065535&amp;logo=Rust&amp;logoColor=white" alt="Crate Release"></a> -->
<br>
<a href="https://github.com/xTekC/unic/actions?query=workflow%3A%22Continuous+Integration%22"><img src="https://img.shields.io/github/actions/workflow/status/xTekC/unic/ci.yml?branch=main&amp;style=flat&amp;labelColor=032a1a&amp;color=065535&amp;logo=GitHub%20Actions&amp;logoColor=white&amp;label=Build" alt="Continuous Integration"></a>
<a href="https://github.com/xTekC/unic/actions?query=workflow%3A%22Continuous+Deployment%22"><img src="https://img.shields.io/github/actions/workflow/status/xTekC/unic/cd.yml?style=flat&amp;labelColor=032a1a&amp;color=065535&amp;logo=GitHub%20Actions&amp;logoColor=white&amp;label=Release" alt="Continuous Deployment"></a>
<!-- <a href="https://docs.rs/unic/"><img src="https://img.shields.io/docsrs/unic?style=flat&amp;labelColor=032a1a&amp;color=065535&amp;logo=Rust&amp;logoColor=white" alt="Documentation"></a> -->

[![GitHub license](https://img.shields.io/github/license/xTekC/unic.svg?style=flat&labelColor=032a1a&color=065535&logo=GitHub&logoColor=black&label=License)](https://github.com/xTekC/unic/blob/main/LICENSE)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A-Coffee-orange?style=flat&labelColor=FFFFFF&color=000000&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/xTekC)

<a href="#features">Features</a> •
<a href="#installation">Installation</a> •
<a href="#usage">Usage</a> •
<a href="#contribution">Contribution</a>
<!-- <a href="#roadmap">Roadmap</a> -->
<!-- <a href="#acknowledgements">Acknowlegements</a> • -->

</div>

## Features

**Supported systems**

_Linux_:
- riscv64gc-unknown-linux-gnu
- aarch64-linux-android
- aarch64-unknown-linux-gnu
- aarch64-unknown-linux-musl
- x86_64-unknown-linux-gnu
- x86_64-unknown-linux-musl

_BSD_:
- x86_64-unknown-freebsd
- x86_64-unknown-netbsd

_MacOS_:
- aarch64-apple-darwin
- x86_64-apple-darwin

_Windows_:
- aarch64-pc-windows-msvc
- x86_64-pc-windows-gnu
- x86_64-pc-windows-msvc

## Installation

**Cargo**

```
cargo install --git https://github.com/xTekC/unic --branch main --locked --profile rel-opt
```

<!-- **Prebuilt Binary**
<br>

(For Android, use Termux: `https://f-droid.org/repo/com.termux_118.apk`)

Unix-Like [Install](https://github.com/xTeKc/unic/blob/main/scripts/install.sh)<br>

```
curl -sSL https://raw.githubusercontent.com/xTeKc/unic/main/scripts/install.sh | sh
```

Unix-Like [Remove](https://github.com/xTeKc/unic/blob/main/scripts/remove.sh)

```
curl -sSL https://raw.githubusercontent.com/xTeKc/unic/main/scripts/remove.sh | sh
``` -->

<!-- - Download the release binary and the corresponding hash file from the [Releases](https://github.com/xTekC/unic/releases) page.

- _Unix-Like Systems:_
   - Verify the integrity of the binary by checking its hash: 
   ```
   sha512sum -c unic-v0.0.0-ARCH.tar.gz.sha512
   ```
   - Extract the binary to ~/ and create a symlink in /usr/local/bin/ for system-wide access: 
   ```
   tar -xzvf unic-v0.0.0-ARCH.tar.gz -C ~/ && sudo ln -s ~/unic/bin/unic /usr/local/bin/unic
   ```

**Android**

- Download Termux:
```
https://f-droid.org/repo/com.termux_118.apk
```

- Within Termux:

   [Install](https://github.com/xTeKc/unic/blob/main/scripts/android_i.sh):
   ```
   curl -sSL https://raw.githubusercontent.com/xTeKc/unic/main/scripts/android_i.sh | bash
   ```

   [Remove](https://github.com/xTeKc/unic/blob/main/scripts/android_rm.sh):
   ```
   curl -sSL https://raw.githubusercontent.com/xTeKc/unic/main/scripts/android_rm.sh | bash
   ``` -->

## Usage

```
unic -h
```

- `unic <TXT_file>` &nbsp; compiles <file_name>.txt to unicode and outputs as uni.<file_name>.txt 

## Contribution
Read the [Contributing Guide](CONTRIBUTING.md) before making a pull request.

<!-- ## Roadmap
A list of planned future developments for the project. -->

<!-- ## Acknowledgements
List of any external libraries, frameworks, or other resources used in the project. -->

<br>

Copyright (c) **xTekC** <br>
Licensed under [MPL-2.0](LICENSE)
