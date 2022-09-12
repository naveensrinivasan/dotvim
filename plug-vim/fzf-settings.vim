"fzf
" If installed using git
set rtp+=~/.fzf
command! -bang -nargs=*  All
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,vendor/*}"', 'down': '40%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))

command! -bang -nargs=*  Foo
 \  call fzf#vim#grep("rg --column --line-number --no-heading --color=always --glob '!{node_modules/*,.git/*,vendor/*}' --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
nnoremap \ :Foo<CR>
nnoremap <C-p> :FZF<cr>
nnoremap <C-r> :Foo<cr>
nnoremap <tab> :History<cr>
nnoremap <C-b> :Buffers<cr>
