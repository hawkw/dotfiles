#!/usr/bin/zsh

if [[ ! -e $ZPLUG_HOME/init.zsh ]]; then

    debug "[zsh/plugins ]install zplug"
    brew install zplug
fi

ZPLUG_ARGS=""
if [[ -v DOTFILE_DEBUG ]]; then
    ZPLUG_ARGS="--verbose"
fi

debug "[zsh/plugins] load plugins"

source $ZPLUG_HOME/init.zsh

# let zplug update itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zsh async plugin
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"

# fish-style syntax highlighting
#
# this must be loaded after compinit, so use defer.
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# spaceship theme (but use asyncified version)
zplug "maximbaz/spaceship-prompt", \
    from:"github", \
    use:"spaceship.zsh", \
    as:theme \

zplug "agkozak/zsh-z", from:"github"

zplug check ${ZPLUG_ARGS} || zplug install ${ZPLUG_ARGS}
zplug load ${ZPLUG_ARGS}


if [[ -v DOTFILE_DEBUG ]]; then
    echo "[zsh/plugins] $(zplug info)"
fi