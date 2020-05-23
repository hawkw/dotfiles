source $HOME/.shenv.sh
LOCAL="$HOME/.sh_profile.local"
export CLR_OPENSSL_VERSION_OVERRIDE=47

if [ -f ]"$LOCAL" ]; then
    source "$LOCAL"
fi

# source ~/.docker/dockerrc

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin:/Applications/Wireshark.app/Contents/MacOS:/Users/eliza/Code/google-cloud-sdk/bin:/Users/eliza/opt/cross/bin:/usr/texbin:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:/usr/local/opt/llvm/bin/:/Users/eliza/.cargo/bin:/Users/eliza/opt/bin/:/usr/local/bin/rust-os-gdb/bin:/Users/eliza/.local/bin:/Users/eliza/.cabal/bin:/Users/eliza/Code/go/bin:/usr/local/opt/go/libexec/bin:/Users/eliza/.cargo/bin