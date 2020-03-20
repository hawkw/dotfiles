call plug#begin('~/.local/share/nvim/plugged')

" pywal color scheme
Plug 'dylanaraps/wal.vim'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" " language server client
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" " (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" COC: intellisense/language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fugitive/Rhubarb : git wrapper, plus GitHub extensions.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'

" Which Key: show keybindings in popup.
Plug 'liuchengxu/vim-which-key'

" goyo/limelight: distraction free mode

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Initialize plugin system
call plug#end()