# User configuration ########################################################

export LSCOLORS="Fxfxcxdxbxegedabagacad"

# autoload znt-history-widget
# zle -N znt-history-widget
# bindkey "^R" znt-history-widget

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# export DEFAULT_USER=eliza
export TERM=xterm-256color
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="spaceship-prompt/spaceship"

export COMPLETION_WAITING_DOTS="true"
# Uncomment the following line to use case-sensitive completion.
export CASE_SENSITIVE="true"

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
export DISABLE_UNTRACKED_FILES_DIRTY="true"

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

if [[ -n "$PRESENTING" ]]; then
  # In presentation mode, turn off suggestions
    export plugins=(
        git
        docker
        cargo
        z
        brew
        osx
        zsh-syntax-highlighting
        httpie
        kubectl
        golang
        iterm2
    )
else
    export ZSH_AUTOSUGGEST_USE_ASYNC=true
    export plugins=(
        git
        docker
        cargo
        z
        brew
        osx
        zsh-syntax-highlighting
        zsh-autosuggestions
        httpie
        kubectl
        golang
        iterm2
    )
fi
