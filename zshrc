#
#   ZSH runtime config
#   by Eliza Weisman
#


# Another profiling method to easily find slow plugins/themes/functions is zsh/zprof. Just add this to the top of your .zshrc and then run env ZSH_PROF= zsh -ic zprof:

# if [[ -v ZSH_PROF ]]; then
#   zmodload zsh/zprof
# fi

# load shared shell configuration
source $HOME/.shrc.sh

# Add Homebrew zsh completions
fpath=(
  $HOME/.zsh
  /usr/local/share/zsh-completions
  $HOME/.zfunc
  $fpath
)
autoload -Uz compinit
autoload -Uz async && async

# autoload znt-history-widget
# zle -N znt-history-widget
# bindkey "^R" znt-history-widget

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DEFAULT_USER=eliza
export TERM=xterm-256color
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

ICON_MODE='nerdfont-fontconfig'
case $ZSH_THEME in
  spaceship*)
    source $HOME/.scripts/icons.zsh
    source $HOME/.spaceshiprc.sh
    ;;
  powerlevel9k*)
    source $HOME/.powerlevel9krc.sh
    ;;
esac

COMPLETION_WAITING_DOTS="true"
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    docker
    cargo
    z
    brew
    osx
    zsh-syntax-highlighting
    zsh-autosuggestions
    # zsh-navigation-tools
    httpie
    kubectl
    # zsh-iterm-touchbar
    golang
    iterm2
    )

source $ZSH/oh-my-zsh.sh

# User configuration ########################################################

export LSCOLORS="Fxfxcxdxbxegedabagacad"

# added by travis gem
[ -f /Users/eliza/.travis/travis.sh ] && source /Users/eliza/.travis/travis.sh

## Zsh Navigation Tools #####################################################

# export znt_panelize_active_text="underline"
# znt_history_nlist_coloring_color="cyan"
# znt_list_colorpair="white/black"

## Aliases ##################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="nano ~/.zshrc && source ~/.zshrc"
alias tmuxconfig "nano ~/.tmux.conf"
alias ohmyzsh="atom ~/.oh-my-zsh"
alias apm=apm-beta
alias atom=atom-beta


# Change the current Kubernetes NS
change-ns() {
  local current_context
  current_context=`kubectl config current-context`
  kubectl config set-context $current_context --namespace=$1
}

kube-list() {
  kubectl get "$1" | grep "$2" | cut -f1 -d " "
}

kube-tear() {
  kube-list "$1" "$2" | xargs kubectl delete "$2"
}


yelling_git() {
  cmd=$1
  shift
  real_git="$( where -p git )"
  if [ "$cmd" '==' "add" ] && [ "$1" '==' "." ]; then
    dry_run=$(
      $real_git add . --dry-run | while IFS= read -r line; do
        echo " - $line\n"
      done
    )
    msg=$(cowsay -W70 <<EOM
NO YOU DON'T, DUMBASS!!!!

If you actually ran that command, the following files would be committed:

$dry_run

Are you SURE [y/N]?
EOM
)
  msg+=$'\n'
  read -r "response?$msg"
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    "$real_git" add -v .
  fi
  elif [ "$cmd" '==' "push" ] && [ "$1" '==' "--force" ]; then
    msg=$(cowsay <<EOM
NICE TRY, IDIOT!!!!

Maybe you should use 'git push --force-with-lease' instead...
EOM
)
  (>&2 echo "$msg")
  else
    "$real_git" "$cmd" "$@"
  fi
}
alias git='yelling_git'
compdef git='git'
setopt complete_aliases

