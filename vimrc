" ##### Plugins #####
"
" Download Plug and isntall it if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

" Python
Plug 'davidhalter/jedi-vim'
Plug 'hynek/vim-python-pep8-indent'
" Plug 'klen/python-mode', { 'for': 'python', 'branch': 'develop' } " For later

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Generic
Plug 'ervandew/supertab'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Git
Plug 'tpope/vim-fugitive'

" Theming/Color
Plug 'vim-scripts/wombat256.vim'

" Hardmode.... Why not...?.... ;(
Plug 'takac/vim-hardtime'

" Return to last edit position
Plug 'farmergreg/vim-lastplace'

" Directory Tree
Plug 'scrooloose/nerdtree'

" Fancy Bar at the bottom of the screen
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" ##### Sets and Lets #####
"
" Set Color scheme
colorscheme wombat256mod

" Set up a better encoding
set encoding=utf-8

" Set terminal color depth
set t_Co=256

" autoindent: Does not reset cursor to left of window.
set autoindent

" Buffer Related
set hidden

" expandtab: tabs make spaces, smarttab: better alignment
set expandtab
set smarttab

" shiftwidth: how many spaces tab will take up
" softtabstop: backspacing through spaces isn't hell
set shiftwidth=2
set softtabstop=2

" Set line numbers
set number

" Relative Numbers
set relativenumber

" Fixes the WRONG default split values
set splitright splitbelow

" This shows what you are typing as a command.
set showcmd

" check to make sure vim has been compiled with colorcolumn support
" " before enabling it
if exists("+colorcolumn")
  set colorcolumn=80
endif

" Default Hardmode to on
let g:hardtime_default_on = 1
" airline settings
" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" Set the airline theme
let g:airline_theme='wombat'

" ##### Remapping #####
"
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Insert -> Normal ft. Dr Casey
inoremap jk <ESC>

" Leader
" let mapleader = "\<Space>"

" Quick editing of VimRC and Sourcing it too
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Toggle NERDTree
nnoremap <leader>N :NERDTreeToggle<CR>

" Hardmode Toggle
nnoremap <leader>h <Esc>:call HardTimeToggle()<CR>

" Paste Mode
nnoremap <leader>p :set paste!<CR>

" ##### Misc. #####
"
" Uses appropriate syntax highlighting.
syntax on

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
