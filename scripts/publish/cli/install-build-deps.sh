#!/usr/bin/env bash

set -euo pipefail

target="${CLI_TARGET:-}"

sudo apt-get update
case "$target" in
aarch64-unknown-linux-gnu)
  sudo apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
  ;;
x86_64-unknown-linux-musl | aarch64-unknown-linux-musl)
  sudo apt-get install -y musl-tools g++

  # musl-tools only ships musl-gcc (C compiler wrapper). C++ crates like
  # clipper-sys need musl-g++. We use plain g++ (no musl specs) because
  # cc-rs only compiles .cpp -> .o (no linking). The musl specs strip C++
  # stdlib include paths (<vector> etc.), causing compilation failures.
  # Actual musl linking is handled by cargo via CARGO_TARGET_*_LINKER=musl-gcc.
  sudo ln -sf "$(command -v g++)" /usr/local/bin/musl-g++
  echo "Created musl-g++ symlink -> $(command -v g++)"
  ;;
*) ;;
esac
