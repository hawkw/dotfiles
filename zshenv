export PATH="/usr/local/bin" # prioritize Homebrew bin
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin" # other bin dirs
export PATH="$PATH:/usr/texbin" # latex bin
export PATH="$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin" # latex bin on El Capitan
export PATH="$PATH:/Applications/Julia-0.3.0.app/Contents/Resources/julia/bin" # Julia
export PATH="$PATH:/usr/local/bin/go:$HOME/Development/go/bin" # golang
export PATH="$PATH:$HOME/perl5/bin" # perl 5?
export PATH="$PATH:/usr/local/opt/llvm/bin/" # llvm
export PATH="$HOME/opt/cross/bin:$PATH" # cross-compiled binutils
export PATH="$HOME/.multirust/toolchains/nightly/cargo/bin:$PATH" # multirust Rust apps
export PATH="$PATH:$HOME/.cargo/bin"
export GOPATH="$HOME/Development/go"
# export MANPATH="/usr/local/man:$MANPATH"
export RUST_SRC_PATH="/Users/hawk/Development/rust/src/" # Rust sources (racer needs this)

# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# ssh
export SSH_KEY_PATH="~/.ssh/id.rsa"

# LeJOS EV3
export EV3_HOME="/opt/lejos-ev3"

# OpenSSL bits
export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib

export GH_TOKEN="6353fb099fc52f91067d5ee1c97e60af292a2612"
export CARGO_TOKEN="h12iJk5JKCcVY1CR9OQpGpXdpQldzPoY"
export VERSIONEYE_API_KEY="022c68589ca94418c558"
