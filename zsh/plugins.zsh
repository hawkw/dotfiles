#!/usr/bin/zsh

if [[ ! -e $ZPLUG_HOME/init.zsh ]]; then
    brew install zplug
fi

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

zplug check || zplug install

zplug load