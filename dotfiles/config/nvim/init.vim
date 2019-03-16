"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|

"--------------- Vundle plugin manager ---------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/fzf.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'jnurmine/Zenburn'
Plugin 'mboughaba/i3config.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
"----------------------------------------------------------

let mapleader = " "

" general
set encoding=utf-8
syntax enable
filetype plugin indent on
set showcmd
" we don't need the following because of the + register
" set clipboard=unnamedplus
set nostartofline
set splitbelow splitright
set ruler
set relativenumber
set scrolloff=10
" highlight cursor line
set cursorline
" always show status bar
set laststatus=2

" completion
set wildmenu
set wildmode=longest,list,full
set mouse=a

" appearance
set background=dark
set termguicolors
colorscheme gruvbox
" colorscheme zenburn
" nice without termguicolors
" colorscheme pablo

" case insensitive search except when using capital letters
set ignorecase
set smartcase
set hlsearch

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" unsaved changes: ask instead of fail
set confirm

" shortcut timeouts
set timeout timeoutlen=300 ttimeout ttimeoutlen=200

" tabs
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"-------------------- python -------------------------------
autocmd BufNewFile,BufRead *.py set textwidth=79 colorcolumn=80

autocmd FileType python inoremap öw while :<left>
autocmd FileType python inoremap öi if :<left>
autocmd FileType python inoremap öf def (self):<esc>F(i
autocmd FileType python inoremap öp <esc>0f)i,<space>
autocmd FileType python inoremap ön None
autocmd FileType python inoremap ös self.
" getter and setter
autocmd FileType python inoremap öag <esc>bywodef get_<esc>pa(self):<cr>return self.<esc>pkkdd
autocmd FileType python inoremap öas <esc>bywodef set_<esc>pa(self, <esc>pa):<cr>self.<esc>pa = <esc>pkkdd

"-------------------- Mappings -----------------------------
" general bindings
imap jk <esc>
map Y y$
nnoremap <M-l> :nohl<cr><C-L>
nnoremap <leader>ho <C-]>

inoremap xn <C-x><C-n>
inoremap xp <C-x><C-p>
inoremap xl <C-x><C-l>

" copy/paste
nnoremap <M-p> "+p
nnoremap <M-c> "+y

" cd
nnoremap <leader>cd :lcd %:p:h<cr>
nnoremap <leader>ca :cd %:p:h<cr>

inoremap jj <esc>o
inoremap jh <esc>o<backspace>
inoremap hh <backspace>

" Files
:nnoremap <leader>fs :w<cr>
:nnoremap <leader>fq :wq<cr>
:nnoremap <leader>qz :qa<cr>

" Replace all ocurrences of the word under the cursor.
:nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gc<left><left><left>

" Replace all
nnoremap <leader>ra :%s//gc<left><left><left>

" line numbers
nnoremap <leader>nr :set relativenumber<cr>
nnoremap <leader>na :set number<cr>
nnoremap <leader>nn :set nonumber<cr>:set norelativenumber<cr>

" split
nnoremap <leader>sv :vs<cr>
nnoremap <leader>sh :sp<cr>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" too lazy to press Ctrl :)
map <M-u> <C-u>
map <M-d> <C-d>
map <M-o> <C-o>
map <M-i> <C-i>

" folds
nnoremap <M-a> za
nnoremap <M-+> zo
nnoremap <M--> zc
nnoremap <M-S-+> zR
nnoremap <M-S--> zM

" windows
map <leader>wd :q<cr>
map <leader>wm <C-w>o

" buffers
nnoremap <M-f> :bnext<cr>
nnoremap <M-S-f> :bprevious<cr>
map <leader>bn :enew<cr>
map <leader>bd :bd<cr>


"--------------------- fzf ---------------------------------
set rtp+=~/.fzf
nnoremap <M-e> :Buffers<cr>
nnoremap <leader>fo :Files<cr>
nnoremap <leader>fr :History<cr>
nnoremap <leader>ff :Files<space>
nnoremap <leader>hk :Maps<cr>
nnoremap <leader>hc :Commands<cr>
nnoremap <leader>zc :Colors<cr>
nnoremap <M-e> :Buffers<cr>
map gl :Lines<cr>

"--------------------- i3config.vim ------------------------
autocmd BufRead,BufNewFile ~/dotfiles/dotfiles/i3/config set filetype=i3config


"--------------------- Nerd tree ---------------------------
map <M-n> :NERDTreeToggle<cr>
let NERDTreeWinPos="right"
"ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

"--------------------- vimwiki -----------------------------
let g:vimwiki_folding='expr'

"--------------------- easymotion --------------------------
:let g:EasyMotion_keys="asdghklqwertyuiopzxcvbnmfj"
" move to char
map  ö <Plug>(easymotion-bd-f)
nmap ö <Plug>(easymotion-overwin-f)
" move up/down
map <M-j> <Plug>(easymotion-j)
map <M-k> <Plug>(easymotion-k)

