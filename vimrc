call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("autocmd")
  filetype plugin indent on
endif

fun! MySys()
   return "linux"
endfun
set runtimepath=~/.vimruntime,~/.vimruntime/after,$VIMRUNTIME
source ~/.vimruntime/vimrc
helptags ~/.vimruntime/doc
