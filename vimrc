" required for vundle stuff
set nocompatible
filetype off

" install vundle and plugins if needed
let install_plugins = 0
let vundle_path = expand('$HOME/.vim/bundle/Vundle.vim')
if !isdirectory(vundle_path)
    echo "Cloning vundle\n"
    execute 'silent! !mkdir ' . vundle_path
    execute 'silent! !git clone https://github.com/VundleVim/Vundle.vim ' .
        \ vundle_path
    let install_plugins = 1
endif

" initialize vundle
execute 'set rtp+=' . vundle_path
call vundle#begin()

" plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'tomasr/molokai'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'easymotion/vim-easymotion'
Plugin 'llvm-mirror/llvm', {'rtp': 'utils/vim/'}
Plugin 'leafgarland/typescript-vim'

call vundle#end()

" if vundle was just cloned from github, then the plugins must not have been
"  installed yet, so do that now to prevent errors
if install_plugins
    PluginInstall
    " exit the window that PluginInstall creates
    quit
endif

filetype on
filetype plugin on
filetype indent on

" theme settings
set t_Co=256
colorscheme molokai
let g:molokai_original = 1
set conceallevel=1
set concealcursor=inc

" render json as js so the quotes aren't hidden
autocmd BufNewFile,BufRead *.json set filetype=javascript

" override typescript-vim indentation with my own settings
let g:typescript_indent_disable = 1

" enable use of the mouse
set mouse=a

" makes everything smoother when working with large files in multiple windows
set ttyfast
set lazyredraw

" make the backspace key work like most other apps
set backspace=indent,eol,start

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

" disable automatic backups since everything's on git these days
set nobackup nowb noswapfile

" wrap lines when over the character limit
set wrap

" highlight in red any text that's over the 80 character limit
highlight BadText term=underline ctermbg=red ctermfg=white guibg=red
    \ guifg=white
autocmd FileType c,cpp,def match BadText /\%81v.\+/

" use 4wide soft tabs
set softtabstop=4 expandtab shiftwidth=4

" except for makefiles, which require hard tabs
autocmd FileType make setlocal noexpandtab

" custom indentation settings
set cindent
set cinoptions=Ls,:0,l1,g0,N-s,p0,t0,cs,C1,(s
set formatoptions+=tcroqj

" show line numbers
set number

" things to save when doing :mks
set sessionoptions=resize,sesdir,tabpages,winsize

" always display the really cool statusline from vim-airline
set laststatus=2

" pressing gt and gT is too hard, let's use the actual tab key instead
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" used for switching between windows in a tab
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l
