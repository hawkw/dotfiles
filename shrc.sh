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

### Hyper Compatability #############################################
[ "$TERM_PROGRAM" = "Hyper" ] && export HYPER=1
if [[ $HYPER ]]; then
    # (see https://github.com/zeit/hyperterm/issues/360)
    export LANG="en_US.UTF-8"
    export LC_COLLATE="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_MESSAGES="en_US.UTF-8"
    export LC_MONETARY="en_US.UTF-8"
    export LC_NUMERIC="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
fi

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias fuck)
