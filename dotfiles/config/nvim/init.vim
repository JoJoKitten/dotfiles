"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|

"----------------- dein plugin manager ---------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('junegunn/fzf.vim')
  call dein#add('vimwiki/vimwiki')
  call dein#add('vim-scripts/YankRing.vim')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('tpope/vim-surround')
  call dein#add('scrooloose/nerdtree')
  call dein#add('morhetz/gruvbox')
  call dein#add('jnurmine/Zenburn')
  call dein#add('mboughaba/i3config.vim')
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
  "call dein#add('Valloric/YouCompleteMe')

  call dein#end()
  call dein#save_state()
endif

"----------------------------------------------------------

let mapleader = " "

" general
set encoding=utf-8
syntax enable
filetype plugin indent on
set showcmd
set clipboard=unnamedplus
set nostartofline
set splitbelow splitright
set ruler
set laststatus=2
set relativenumber
set scrolloff=10

" Completion
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

" timeouts
set timeout timeoutlen=1000 ttimeout ttimeoutlen=200

" tabs
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" python
autocmd BufNewFile,BufRead *.py set textwidth=79 colorcolumn=80


"-------------------- Mappings -----------------------------
" general bindings
imap jk <Esc>
map Y y$
nnoremap <M-l> :nohl<CR><C-L>

" Files
:nnoremap <leader>fs :wa<cr>
:nnoremap <leader>qz :qa<cr>

" Replace all ocurrences of the word under the cursor.
:nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" Replace all
nnoremap <leader>ra :%s//gc<Left><Left><Left>

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

" buffers
nnoremap <M-f> :bnext<CR>
nnoremap <M-S-f> :bprevious<CR>
map <leader>bn :enew<cr>
map <leader>bd :bd<cr>


"--------------------- fzf ---------------------------------
set rtp+=~/.fzf
nnoremap <M-e> :Buffers<cr>
nnoremap <leader>fo :Files<cr>
nnoremap <leader>hk :Maps<cr>
nnoremap <leader>hc :Commands<cr>
nnoremap <leader>zc :Colors<cr>
nnoremap <M-e> :Buffers<cr>
map gl :Lines<cr>

"--------------------- i3config.vim ------------------------
autocmd BufRead,BufNewFile ~/dotfiles/dotfiles/i3/config set filetype=i3config


"--------------------- Nerd tree ---------------------------
map <M-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

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

