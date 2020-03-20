" install vim-plug to manage plugins
" (stole this one from Katie: https://github.com/data-pup/my-config/blob/f92557c56e4bd48e6358b77b347ee7d477304465/dotfiles/config/nvim/init.d/plug-install.vim)
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif