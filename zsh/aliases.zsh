## Aliases ##################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

alias zshconfig="$EDITOR ~/.zshrc && source ~/.zshrc"
alias tmuxconfig "$EDITOR ~/.tmux.conf"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias cagro='cargo'
alias carg='cargo'

# Change the current Kubernetes NS
change-ns() {
  local current_context
  current_context=`kubectl config current-context`
  kubectl config set-context $current_context --namespace=$1
}

kube-list() {
  if [ $# -ne 2 ]; then
    echo "Usage: kube-list [resource] [regex]"
    exit 85
  fi
  kubectl get "$1" | grep "$2" | cut -f1 -d " "
}

kube-tear() {
  if [ $# -ne 2 ]; then
    echo "Usage: kube-tear [resource] [regex]"
    exit 85
  fi
  kube-list "$1" "$2" | xargs kubectl delete "$1"
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