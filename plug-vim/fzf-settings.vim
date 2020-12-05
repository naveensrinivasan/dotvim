"fzf
" If installed using git
set rtp+=~/.fzf
command! -bang -nargs=*  All
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*}"', 'down': '40%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))


set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
nnoremap \ :Rg<CR>
nnoremap <C-p> :FZF<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :BLines<cr>
nnoremap <Leader>f :All<cr>
