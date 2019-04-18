#! /usr/bin/zsh
#
#   iterm2 user vars
#   by Eliza Weisman
#

iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context 2>/dev/null)
}