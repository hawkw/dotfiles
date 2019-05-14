
#####################################################################
# Spaceship theme
# SPACESHIP_PROMPT_SEPARATE_LINE=false

# case $ZSH_THEME in
#   spaceship*) ;;
#   *) return ;;
# esac

export SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_RUST_SYMBOL="🦀"
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_BATTERY_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=20

SPACESHIP_GIT_STATUS_COLOR="magenta"
SPACESHIP_GIT_STATUS_PREFIX="["
SPACESHIP_GIT_STATUS_SUFFIX="] "
SPACESHIP_GIT_STATUS_STASHED="$"
SPACESHIP_GIT_STATUS_UNMERGED="="
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_MODIFIED="»"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_AHEAD="⇡"
SPACESHIP_GIT_STATUS_BEHIND="⇣"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"
SPACESHIP_CHAR_SUFFIX=" "

if [[ -n "$PRESENTING" ]]; then
  # Override configs for a shorter prompt if in presentation mode.
  export SPACESHIP_USER_SHOW=always
  export SPACESHIP_HOST_SHOW=always
  export SPACESHIP_PROMPT_ORDER=(user dir exec_time exit_code char)
  export SPACESHIP_PROMPT_SEPARATE_LINE=false
else
  export SPACESHIP_PROMPT_ORDER=(
    time          # Time stampts section
    user          # Username section
    host          # Hostname section
    dir           # Current directory section
    #git           # Git section (git_branch + git_status)
    git_branch
    git_status
    #hg            # Mercurial section (hg_branch  + hg_status)
    rust          # Rust section
    package       # Package version
    node          # Node.js section
    #ruby          # Ruby section
    #elixir        # Elixir section
    xcode         # Xcode section
    swift         # Swift section
    golang        # Go section
    haskell       # Haskell Stack section
    # docker        # Docker section
    #aws           # Amazon Web Services section
    #venv          # virtualenv section
    kubecontext   # Kubectl context section
    exec_time     # Execution time
    # line_sep      # Line break
    #battery       # Battery level and status
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
  )
fi
