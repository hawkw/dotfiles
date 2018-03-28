#
#   BASH runtime config
#   by Eliza Weisman
#

# load shared shell configuration
[ $(uname -s) = "Darwin" ] && source $HOME/.bash_profile
source $HOME/.shrc.sh

# added by travis gem
[ -f /Users/eliza/.travis/travis.sh ] && source /Users/eliza/.travis/travis.sh
