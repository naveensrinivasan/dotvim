" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jessfraz/openai.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

filetype plugin indent on
" vim: foldmethod=marker
" vim: foldcolumn=2
" =============== Pathogen Initialization ==============={{{1
syntax on
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"=============== Window setttings==============================={{{1
" Maximize the window
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Meslo\ LG\ S\ for\ Powerline
   endif
endif

" ================ Plugins ===================={{{1
" ================ airline ====================
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

"===================auto save==================
let g:auto_save = 0 " enable AutoSave on Vim startup

let g:auto_save_silent = 1  " do not display the auto-save notification

" ================ General Config ===================={{{1

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamed           "like the OS clipboard as default
set autochdir                   "Change dir automatically
set cursorline
set wildmenu                    "autocomplete filename
set lazyredraw          " redraw only when we need to.
set colorcolumn=100
set t_Co=256
let g:Powerline_symbols = "fancy"
set laststatus=2

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set backupdir=$TMPDIR//
set directory=$TMPDIR//

"turn on syntax highlighting
syntax on
syntax enable   " enable syntax processing
" ================ TMUX SETTINGS ==================={{{1
if $TMUX != '' 
  function! TmuxSharedYank()
      " Send the contents of the 't' register to a temporary file, invoke
      " copy to tmux using load-buffer, and then to xclip
      " FIXME for some reason, the 'tmux load-buffer -' form will hang
      " when used with 'system()' which takes a second argument as stdin.
      let tmpfile = tempname()
      call writefile(split(@t, '\n'), tmpfile, 'b')
      call system('tmux load-buffer '.shellescape(tmpfile).';tmux show-buffer | xclip -i -selection clipboard')
      call delete(tmpfile)
    endfunction

    function! TmuxSharedPaste()
      " put tmux copy buffer into the t register, the mapping will handle
      " pasting into the buffer
      let @t = system('xclip -o -selection clipboard | tmux load-buffer -;tmux show-buffer')
    endfunction
    nnoremap <silent> <esc>p :call TmuxSharedPaste()<cr>"tp
    vnoremap <silent> <esc>p d:call TmuxSharedPaste()<cr>h"tp  
    set clipboard= " Use this or vim will automatically put deleted text into x11 selection('*' register) which breaks the above map
endif
" ================ SEARCH SETTINGS  ================={{{1
set incsearch        "Find the next match as we type the search
set hlsearch         "Highlight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set ignorecase
set smartcase
set gdefault
set showmatch
nnoremap <leader><space> :noh<cr>

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb
" ================ Indentation ======================{{{1

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=4  " number of visual spaces per TAB
set tabstop=4      "number of spaces in tab when editing
set expandtab      "expand tab to spaces

filetype plugin on
filetype indent on


set linebreak    "Wrap lines at convenient points

" ================ Scrolling ========================{{{1
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" ================ Color ========================
set background=dark
colors badwolf
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

"=============== GO ====================
" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1  
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['vet','golint','errcheck','unused','unparam','aligncheck','vet','deadcode','gocyclo','varcheck','structcheck','goconst','gosimple','gas','unconvert','dupl','interfacer','goconst','misspell','staticcheck']  
let g:go_metalinter_autosave_enabled = ['vet', 'golint' ]
let g:go_metalinter_deadline = "35s"
let g:go_auto_sameids = 1
set updatetime=100
autocmd FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>g <Plug>(go-doc)
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set rtp+=/usr/local/opt/fzf
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
"============== Control P=================
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" Ctrl- P mapping and two custom split keymappings (https://github.com/kien/ctrlp.vim)
let g:ctrlp_map = '<c-p>'
nmap <c-n>s :split<CR><c-w>j<c-p>
nmap <c-n>v :vsplit<CR><c-w>l<c-p>
"===============NeoComplete ================
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
set completeopt-=preview
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype gitcommit setlocal spell colorcolumn=73
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"=============== Clojure ====================
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1

"================= Key bindings ============={{{1
let mapleader=","
"Quickly switching buffers in Vim normal mode
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
" Arrow keys movement{{{2
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <PageUp> <NOP>
nnoremap <PageDown> <NOP>
nnoremap 0 <NOP>
nnoremap $ <NOP>

inoremap jk <esc>
inoremap jj <esc>
inoremap <PageUp> <NOP>
inoremap <PageDown> <NOP>

"==================== quick fix =============={{{2 

nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
"==================== custom bindings =============={{{2 
"Start of the line 
nnoremap H 0
"End of the line 
nnoremap L $
"move lines downward
nnoremap - ddp 
"move lines upward
nnoremap _ ddkP 
"Upper case in visual selection
vnoremap <leader> U 
"Quote the word 
nnoremap <leader>" Wa"<esc>bi"<esc>
"Single Quote the word 
nnoremap <leader>' Wa'<esc>bi'<esc>
"fold
nnoremap <Space> za
"======= Split movement ================{{{2
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"========= Save ======{{{2
:noremap <c-s> :w<CR>
:inoremap <c-s> <Esc>:w<CR>

" save session
:nnoremap <leader>s :mksession<CR>
"========== vimrc ==============={{{2
nnoremap <leader>ev :split $MYVIMRC<cr>

nnoremap <leader>sv :so $MYVIMRC<cr>
"=========== iabbreev=================='{{{1
:iabbrev adn and
:iabbrev waht what
:iabbrev tehn then 
:iabbrev ns naveensrinivasan@yahoo.com 
"===============Auto commands=================={{{1
:autocmd BufWritePre,BufRead *.html :normal gg=G
:autocmd BufNewFile,BufRead *.html setlocal nowrap
" defaulttt indenter for xml files
autocmd FileType xml setlocal equalprg=xmllint\ --format\ -
autocmd FileType fsharp :nnoremap <leader>f %!mono ~/.vim/bundle/fantomas/Fantomas.exe --stdout % <CR>

"Generates line numbers to print
function! GenerateLineNumbers()
 %s/^/\=printf('%-4d', line('.'))
endfunction

"=================Snippets======================{{{1
let g:UltiSnipsExpandTrigger="<c-j>"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['.vim/UltiSnips', 'UltiSnips','fatih/vim-go'] 
