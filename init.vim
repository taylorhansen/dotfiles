set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" use clipboard register when copying/pasting
set clipboard=unnamedplus
