" vim: foldmethod=marker
" vim: foldcolumn=2
" =============== Pathogen Initialization ==============={{{1
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins
call pathogen#infect()
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
syntax on
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
"=============== Window setttings==============================={{{1
" Maximize the window
if has("gui_running")
  if has("win32")
    au GUIEnter * simalt ~x 
  else
    au GUIEnter * silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz  
  endif
endif

" ================ Plugins ===================={{{1
" ================ airline ====================
set laststatus=2

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

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Search Settings  ================={{{1
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
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on


set linebreak    "Wrap lines at convenient points

" ================ Scrolling ========================{{{1
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" ================ Color ========================
set background=dark
colorscheme desert
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
"=============== Clojure ====================
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1

"================= Key bindings ============={{{1
let mapleader=","
" Arrow keys movement{{{2
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <BS> <NOP>
nnoremap <PageUp> <NOP>
nnoremap <PageDown> <NOP>
nnoremap 0 <NOP>
nnoremap $ <NOP>

inoremap jk <esc>
inoremap jj <esc>
inoremap <BS> <NOP>
inoremap <PageUp> <NOP>
inoremap <PageDown> <NOP>

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
"========== vimrc ==============={{{2
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
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
