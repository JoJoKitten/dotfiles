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
Plugin 'mildred/vim-bufmru'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'jnurmine/Zenburn'
Plugin 'Lokaltog/powerline'
Plugin 'mboughaba/i3config.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
call vundle#end()
"----------------------------------------------------------

let mapleader = " "

" general
set encoding=utf-8
syntax enable
filetype plugin indent on
set showcmd
set hidden
" we don't need the following because of the + register
" set clipboard=unnamedplus
set nostartofline
set splitbelow splitright
set ruler
set number relativenumber
set scrolloff=10
" highlight cursor line
set cursorline
" 2 to always show status bar
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
set timeout timeoutlen=500 ttimeout ttimeoutlen=200

" tabs
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"-------------------- folding ------------------------------
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set foldminlines=0
:highlight Folded guibg=none guifg=LightGrey
:highlight FoldColumn guibg=none guifg=white
set fillchars=fold:\ ,

function! NeatFoldText() "{{{2
let lines_count = v:foldend - v:foldstart + 1
return repeat(' ', v:foldlevel*4) . '+++ ' . lines_count
endfunction
set foldtext=NeatFoldText()
" }}}2

"-------------------- python -------------------------------
" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
autocmd FileType python match Excess /\%81v.*/
autocmd FileType python set textwidth=80 colorcolumn=81
autocmd FileType python set foldmethod=indent

" goto method
autocmd FileType python nmap <M-m> :Lines<cr>def

" snipptes
autocmd FileType python inoremap öw whsle<space>:<left>
autocmd FileType python inoremap öi if<space>:<left>
autocmd FileType python inoremap öf def<space>(self):<esc>F(i
autocmd FileType python inoremap öp <esc>0f)i,<space>
autocmd FileType python inoremap ön None
autocmd FileType python inoremap ör return<space>
autocmd FileType python inoremap ös self.
" getter and setter
autocmd FileType python inoremap öag <esc>bywodef<space>get_<esc>pa(self):<cr>return<space>self.<esc>pkkdd
autocmd FileType python inoremap öas <esc>bywodef<space>set_<esc>pa(self,<space><esc>pa):<cr>self.<esc>pa<space>=<space><esc>pkkdd

"-------------------- Mappings -----------------------------
" general bindings
inoremap jk <esc>
nnoremap Y y$
nnoremap <M-l> :nohl<cr><C-L>
nnoremap <leader>ho <C-]>

inoremap xn <C-x><C-n>
inoremap xp <C-x><C-p>
inoremap xl <C-x><C-l>

" copy/paste
noremap <M-c> "+y
nnoremap <M-p> "+p
noremap! <M-p> <C-r>+

" cd
nnoremap <leader>cd :cd %:p:h<cr>
nnoremap <leader>cdw :lcd %:p:h<cr>

inoremap jj <C-o>o
inoremap jh <C-o>o<backspace>
inoremap hh <backspace>

" Files
nnoremap s :w<cr>
:nnoremap <leader>fs :w<cr>
:nnoremap <leader>fq :wq<cr>
:nnoremap <leader>qz :qa<cr>

" Replace all ocurrences of the word under the cursor.
:nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gc<left><left><left>

" Replace all
nnoremap <leader>ra :%s//gc<left><left><left>

" options
nnoremap <leader>zw :set invwrap<cr>

" line numbers
nnoremap <leader>nr :set number relativenumber<cr>
nnoremap <leader>na :set number norelativenumber<cr>
nnoremap <leader>nn :set nonumber norelativenumber<cr>

" split
nnoremap <leader>sv :vs<cr>
nnoremap <leader>sh :sp<cr>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" too lazy to press Ctrl :)
nnoremap <M-u> <C-u>
nnoremap <M-d> <C-d>
nnoremap <M-o> <C-o>
nnoremap <M-i> <C-i>

" folds
nnoremap <M-a> za
nnoremap <tab> za
nnoremap <M-tab> zO
nnoremap <M-+> zo
nnoremap <M--> zc
nnoremap <M-S-+> zR
nnoremap <M-S--> zM

" windows
nnoremap <leader>wd :q<cr>
nnoremap <leader>wm <C-w>o

" buffers
nnoremap <M-f> :BufMRUNext<cr>
nnoremap <M-S-f> :BufMRUPrev<cr>
nnoremap <leader>bn :enew<cr>
nnoremap <leader>bd :bd<cr>


"--------------------- fzf ---------------------------------
set rtp+=~/.fzf
nnoremap <M-e> :Buffers<cr>
nnoremap <M-h> :Files<cr>
nnoremap <leader>fo :Files<cr>
nnoremap <M-r> :History<cr>
nnoremap <leader>fr :History<cr>
nnoremap <leader>ff :Files<space>
nnoremap <leader>hk :Maps<cr>
nnoremap <leader>hc :Commands<cr>
nnoremap <leader>zc :Colors<cr>
nnoremap <M-e> :Buffers<cr>
nnoremap <M-l> :Lines<cr>
nnoremap gl :Lines<cr>

"--------------------- i3config.vim ------------------------
autocmd BufRead,BufNewFile ~/dotfiles/dotfiles/i3/config set filetype=i3config


"--------------------- Nerd tree ---------------------------
nnoremap <M-n> :NERDTreeToggle<cr>
let NERDTreeWinPos="right"
let NERDTreeIgnore=['\.pyc$', '\~$']

"--------------------- vimwiki -----------------------------
let g:vimwiki_folding='expr'

"--------------------- easymotion --------------------------
:let g:EasyMotion_keys="asdghklqwertyuiopzxcvbnmfj"
" move to char
nmap f <Plug>(easymotion-bd-f)
" move up/down
map <M-j> <Plug>(easymotion-j)
map <M-k> <Plug>(easymotion-k)

"--------------------- syntastic ---------------------------
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python']

"--------------------- YouCompleteMe -----------------------
let g:ycm_autoclose_preview_window_after_completion=1
set completeopt-=preview
nnoremap <C-b> :YcmCompleter GoTo<CR>
nnoremap <C-M-b> :YcmCompleter GoToDefinition<CR>


