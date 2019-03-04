"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|


let mapleader = " "

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

set clipboard=unnamedplus

set hlsearch

" delete trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Autocompletion
set wildmode=longest,list,full

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set autoindent

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

set relativenumber

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


" Indentation options
set shiftwidth=4
set softtabstop=4
set expandtab

set scrolloff=10

"-------------- Mappings ------------------------------------
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

:nnoremap <Leader>fs :wa<cr>
:nnoremap <Leader>qz :wqa<cr>

" Replace all ocurrences of the word under the cursor.
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
map gl :Lines<cr>

map <M>u <Ctrl>u


"--------------- Nerd tree ----------------------------------
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"--------------- vimwiki ------------------------------------
let g:vimwiki_folding='expr'

"--------------- easymotion ---------------------------------
" <Leader>s{char} to move to {char}
map  s <Plug>(easymotion-bd-f)
nmap s <Plug>(easymotion-overwin-f)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


"------------ dein plugin manager ---------------------------
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
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

  call dein#end()
  call dein#save_state()
endif

syntax enable
filetype plugin indent on
