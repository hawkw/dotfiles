" language client: use rust-analyzer
let g:LanguageClient_serverCommands = {
   \ 'rust': ['~/.cargo/bin/ra_lsp_server'],
   \ }

" goyo/limelight

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!