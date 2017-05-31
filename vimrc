" disable vi compatibility mode (must happen first)
set nocompatible

" required for vundle i guess
filetype off

" set runtime path to include vundle then initialize it
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'tomasr/molokai'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'easymotion/vim-easymotion'

call vundle#end()
filetype on

" use the molokai color scheme
colorscheme molokai
let g:molokai_original = 1

" auto read when a file is changed outside of vim
set autoread

" wild menu when entering in commands
set wildmenu

" try to be smart about cases
set smartcase

" when searching, highlight results as you type while ignoring case
set hlsearch incsearch ignorecase

" show matching brackets/parens/etc when the cursor is over them
set showmatch

" syntax highlighting yay
syntax enable

" enable 256 color palette
set t_Co=256

" disable automatic backups since everything's on git these days
set nobackup
set nowb
set noswapfile

" auto/smart indent for stuff
set ai si smarttab

" wrap lines when over the character limit
set wrap

" for java files, use 4wide soft tabs
autocmd Filetype java setlocal softtabstop=4 expandtab shiftwidth=4
