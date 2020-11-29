" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

call plug#begin()
Plug 'fatih/vim-go'
Plug 'sjl/badwolf'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

"fzf
" If installed using git
set rtp+=~/.fzf


colorscheme badwolf
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

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
"go"
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
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

