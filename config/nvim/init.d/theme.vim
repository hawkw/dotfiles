
" Use TrueColor
" if (has("termguicolors"))
"  set termguicolors
" endif

" colors
syntax enable
colorscheme wal

" highlight matching delimiters
set showmatch

" Line numbering settings
set number
set ruler
set nowrap

" " Initialize airline symbols dictionary.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Fill airline symbols dictionary.
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '¶'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


