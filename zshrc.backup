#
#   ZSH runtime config
#   by Eliza Weisman
#

debug() {
    if [[ -v DOTFILE_DEBUG ]]; then
      echo "$1"
    fi
}

# Import colorscheme from 'wal' asynchronously
(cat "${HOME}/.cache/wal/sequences" &)


# To add support for TTYs this line can be optionally added.
source "${HOME}/.cache/wal/colors-tty.sh"

# load shared shell configuration
debug "[zshrc] load shared config"
source $HOME/.shrc.sh

# is there a local configuration? if so, load that first.
if [ -f "$HOME/.zshrc.local" ]; then
    source $HOME/.zshrc.local
fi

export ZPLUG_HOME=${HOME}/.zplug


# if this is defined, a bunch of common unix utilities are aliased to use more 
# modern Rust implementations. 
#
# note: since these aliases are only applied for *interactive* sessions, this
#       shouldn't break any scripts that rely on specific behaviors of ls, ps, 
#       cat, etc.
RUST_UTILS=1

ZSH_THEME=starship

# all of our zsh files
typeset -U config_files
config_files=($HOME/.zsh/**/*.zsh)

debug "[zshrc] load config"
# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  debug " source \"$file\""
  source $file
done

debug "[zshrc] source config files"
# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  debug " source \"$file\""
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -Uz compinit
compinit

# load every completion after autocomplete loads
debug "[zshrc] source completions"
for file in ${(M)config_files:#*/completion.zsh}
do
  debug " source \"$file\""
  source $file
done

# added by travis gem
[ -f /Users/eliza/.travis/travis.sh ] && source /Users/eliza/.travis/travis.sh

## Zsh Navigation Tools #####################################################

# export znt_panelize_active_text="underline"
# znt_history_nlist_coloring_color="cyan"
# znt_list_colorpair="white/black"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

