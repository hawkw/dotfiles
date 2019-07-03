#
#   ZSH runtime config
#   by Eliza Weisman
#

debug() {
    if [[ -v DOTFILE_DEBUG ]]; then
      echo "$1"
    fi
}
# load shared shell configuration
debug "[zshrc] load shared config"
source $HOME/.shrc.sh

export ZPLUG_HOME=/usr/local/opt/zplug

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

source $ZSH/oh-my-zsh.sh

# added by travis gem
[ -f /Users/eliza/.travis/travis.sh ] && source /Users/eliza/.travis/travis.sh

## Zsh Navigation Tools #####################################################

# export znt_panelize_active_text="underline"
# znt_history_nlist_coloring_color="cyan"
# znt_list_colorpair="white/black"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

