#
#   ZSH runtime config
#   by Eliza Weisman
#

# load shared shell configuration
source $HOME/.shrc.sh

# all of our zsh files
typeset -U config_files
config_files=($HOME/.zsh/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load iterm2 shell integration
# source $HOME/.iterm2_shell_integration.zsh

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -Uz compinit
compinit

# autoload -Uz async && async
source $HOME/.oh-my-zsh/custom/plugins/zsh-async/async.zsh

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

source $ZSH/oh-my-zsh.sh

# added by travis gem
[ -f /Users/eliza/.travis/travis.sh ] && source /Users/eliza/.travis/travis.sh

## Zsh Navigation Tools #####################################################

# export znt_panelize_active_text="underline"
# znt_history_nlist_coloring_color="cyan"
# znt_list_colorpair="white/black"
