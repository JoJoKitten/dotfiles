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
  call dein#add('easymotion/vim-easymotion')
  call dein#add('vimwiki/vimwiki')
  call dein#add('tpope/vim-surround')
  call dein#add('mboughaba/i3config.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('morhetz/gruvbox')

  call dein#end()
  call dein#save_state()
endif

"----------------------------------------------------------

let mapleader = " "

syntax enable
filetype plugin indent on

set termguicolors
colorscheme gruvbox

" nice without termguicolors
" colorscheme pablo

" Better command-line completion
set wildmenu

" Autocompletion
set wildmode=longest,list,full

" Show partial commands in the last line of the screen
set showcmd

set clipboard=unnamedplus

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

set splitbelow splitright

set mouse=a


" case insensitive search except when using capital letters
set ignorecase
set smartcase
set hlsearch

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" 2 to display the status line
set laststatus=1

" unsaved changes: ask instead of fail
set confirm

set relativenumber
set scrolloff=10

set timeout timeoutlen=1000 ttimeout ttimeoutlen=200

set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"-------------------- Mappings -----------------------------
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

:nnoremap <leader>fs :wa<cr>

:nnoremap <leader>qz :wqa<cr>

" Replace all ocurrences of the word under the cursor.
:nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" Replace all
nnoremap <leader>ra :%s//gc<Left><Left><Left>

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

nnoremap <leader>hc :Commands<cr>

nnoremap <leader>zc :Colors<cr>

nnoremap <leader>nr :set relativenumber<cr>
nnoremap <leader>na :set number<cr>
nnoremap <leader>nn :set nonumber<cr>:set norelativenumber<cr>

imap jj <Esc>

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
map gl :Lines<cr>

map <M-u> <C-u>
map <M-d> <C-d>
map <M-o> <C-o>
map <M-i> <C-i>


"--------------------- i3config.vim ------------------------
autocmd BufRead,BufNewFile ~/dotfiles/dotfiles/i3/config set filetype=i3config

"--------------------- Nerd tree ---------------------------
map <C-n> :NERDTreeToggle<CR>

"--------------------- vimwiki -----------------------------
let g:vimwiki_folding='expr'

"--------------------- easymotion --------------------------
" <leader>s{char} to move to {char}
map  <M-j> <Plug>(easymotion-bd-f)
nmap <M-j> <Plug>(easymotion-overwin-f)

" JK motions: Line motions
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

