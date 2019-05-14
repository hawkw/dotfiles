#! /usr/bin/zsh
#
#   iterm2-specific configuration
#   by Eliza Weisman
#

if [[ ! -v ${ITERM2} ]]; then
  debug "[zsh/iterm2] current terminal is not iTerm2; doing nothing"
  return
fi

debug "[zsh/iterm2] iTerm2 detected"

if [[ ! -a "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  debug "[zsh/iterm2] install shell integration"
  curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
fi

debug "[zsh/iterm2] load shell integration"
source "${HOME}/.iterm2_shell_integration.zsh"

iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context)
}