" disable vi compatibility mode (must happen first)
set nocompatible

" required for vundle i guess
filetype off

" set runtime path to include vundle then initialize it
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Yggdroot/indentLine'
Plugin 'tomasr/molokai'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'easymotion/vim-easymotion'

call vundle#end()
filetype on
filetype plugin on
filetype indent on

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

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

" wrap lines when over the character limit
set wrap

" use 4wide soft tabs
set softtabstop=4 expandtab shiftwidth=4

" except for makefiles, which require hard tabs
autocmd FileType make setlocal noexpandtab

" custom indentation settings
set cindent
set cinoptions=Ls,:0,l1,g0,N-s,p0,t0,cs,C1,(s

" show line numbers
set number
