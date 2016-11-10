#
#   General purpose shell environment portable to all shells
#   by Eliza Weisman
#

# PATH configuration #########################################################
# prioritize Homebrew bin
export PATH="/usr/local/bin"
# other bin dirs
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin"
# latex bin
export PATH="$PATH:/usr/texbin"
# latex bin on El Capitan
export PATH="$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin"
# Julia
export PATH="$PATH:/Applications/Julia-0.3.0.app/Contents/Resources/julia/bin"
# golang
export PATH="$PATH:/usr/local/bin/go:$HOME/Development/go/bin"
# perl 5?
export PATH="$PATH:$HOME/perl5/bin"
# llvm
export PATH="$PATH:/usr/local/opt/llvm/bin/"
# cross-compiled binutils
export PATH="$HOME/opt/cross/bin:$PATH"
# Rust apps installed with cargo
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/opt/bin/"
# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ];
then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# Other path environment variables ############################################
export GOPATH="$HOME/Development/go"
# Rust sources (racer needs this)
export RUST_SRC_PATH="/usr/local/src/rust/src/"

# ssh
export SSH_KEY_PATH="$HOME/.ssh/id.rsa"
# LeJOS EV3
export EV3_HOME="/opt/lejos-ev3"
# OpenSSL bits
export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib

export GH_TOKEN="6353fb099fc52f91067d5ee1c97e60af292a2612"
export CARGO_TOKEN="h12iJk5JKCcVY1CR9OQpGpXdpQldzPoY"
export VERSIONEYE_API_KEY="022c68589ca94418c558"

# Disable emoji in Homebrew (this makes Hyperterm unhappy) ###################
[ "$TERM_PROGRAM" = "Hyper" ] && export HYPER=1
if [ $HYPER ]
then
  export HOMEBREW_NO_EMOJI=1
fi

# Enable Terminal.app folder icons ###########################################
[ "$TERM_PROGRAM" = "Apple_Terminal" ] && export TERMINALAPP=1
if [ $TERMINALAPP ]
then
  set_terminal_app_pwd() {
    # Tell Terminal.app about each directory change.
    printf '\e]7;%s\a' "$(echo "file://$HOST$PWD" | sed -e 's/ /%20/g')"
  }
fi
[ -s ~/.lastpwd ] && [ "$PWD" = "$HOME" ] && \
  builtin cd `cat ~/.lastpwd` 2>/dev/null
[ $TERMINALAPP ] && set_terminal_app_pwd
