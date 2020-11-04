" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

call plug#begin()
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

Plug 'https://github.com/xavierd/clang_complete'

Plug 'https://github.com/ycm-core/YouCompleteMe'

Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-clang'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

Plug 'https://github.com/xavierd/clang_complete'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


call plug#end()


" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.

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
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar



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

"Generates line numbers to print
function! GenerateLineNumbers()
 %s/^/\=printf('%-4d', line('.'))
endfunction

