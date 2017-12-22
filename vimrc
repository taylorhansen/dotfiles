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
Plugin 'rdnetto/YCM-Generator'
Plugin 'Yggdroot/indentLine'
Plugin 'tomasr/molokai'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'easymotion/vim-easymotion'
Plugin 'llvm-mirror/llvm', {'rtp': 'utils/vim/'}

call vundle#end()
filetype on
filetype plugin on
filetype indent on

" ycm settings
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_error_symbol = 'X'
let g:ycm_warning_symbol = '!'
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<Tab>']
let g:ycm_key_list_previous_completion = ['<S-Tab>']
let g:ycm_disable_for_files_larger_than_kb = 0

" use the molokai color scheme
colorscheme molokai
let g:molokai_original = 1

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

" enable 256 color palette
set t_Co=256

" disable automatic backups since everything's on git these days
set nobackup
set nowb
set noswapfile

" wrap lines when over the character limit
set wrap

" highlight in red any text that's over the 80 character limit
highlight BadText term=underline ctermbg=red ctermfg=white guibg=red
    \ guifg=white
autocmd FileType c,cpp match BadText /\%81v.\+/

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

" pressing gt and gT is too hard lets use the actual tab key instead
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
