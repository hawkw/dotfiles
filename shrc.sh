#
#   General purpose shell config portable to all shells
#   by Eliza Weisman
#

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nano'
else
   export EDITOR='atom-beta'
fi
