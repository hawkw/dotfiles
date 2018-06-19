
#####################################################################
# Spaceship theme
# SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  rust          # Rust section
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  haskell       # Haskell Stack section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  kubecontext   # Kubectl context section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
# SPACESHIP_GOLANG_SYMBOL=$(print_icon GO_ICON)
SPACESHIP_RUST_SYMBOL="🦀"
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_BATTERY_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=20