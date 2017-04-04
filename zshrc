#
#   ZSH runtime config
#   by Eliza Weisman
#

# load shared shell configuration
source $HOME/.zshenv
source $HOME/.shrc.sh

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DEFAULT_USER=eliza

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="hawk"
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-fontconfig'
POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_SHOW_CHANGESET=true
# POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

POWERLEVEL9K_HOME_SUB_ICON='$(print_icon "HOME_ICON")'
POWERLEVEL9K_DIR_PATH_SEPARATOR=' $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") '
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"
POWERLEVEL9K_DIR_HOME_BACKGROUND="004"
POWERLEVEL9K_DIR_HOME_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="004"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="007"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="004"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="007"

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="255"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="255"

POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_CONTEXT_BACKGROUND="008"
POWERLEVEL9K_CONTEXT_FOREGROUND="012"
POWERLEVEL9K_TIME_BACKGROUND="008"
POWERLEVEL9K_TIME_FOREGROUND="012"
POWERLEVEL9K_HISTORY_FOREGROUND="007"
POWERLEVEL9K_HISTORY_BACKGROUND="004"
POWERLEVEL9K_STATUS_BACKGROUND="012"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs history time )

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
plugins=(atom git command-not-found history ssh z brew gradle osx sbt scala cabal zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Add Homebrew zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

# User configuration ########################################################

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nano ~/.zshrc && source ~/.zshrc"
alias tmuxconfig "nano ~/.tmux.conf"
alias ohmyzsh="atom ~/.oh-my-zsh"
alias git=hub # use GitHub's hub script for Git. See https://hub.github.com
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

PERL_MB_OPT="--install_base \"/Users/hawk/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/hawk/perl5"; export PERL_MM_OPT;

ZSH_TMUX_AUTOSTART=false;

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
