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
Plugin 'Yggdroot/indentLine'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mboughaba/i3config.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'

Plugin 'NLKNguyen/papercolor-theme'
Plugin 'morhetz/gruvbox'
Plugin 'mhartington/oceanic-next'
Plugin 'sonobre/briofita_vim'
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
set mouse=

" hide status info
:set noshowmode 

" appearance
set background=dark
set termguicolors
colorscheme gruvbox
" nice without termguicolors
" colorscheme pablo

" unsaved changes: ask instead of fail
set confirm

" shortcut timeouts
set timeout timeoutlen=500 ttimeout ttimeoutlen=200

" tabs
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" case insensitive search except when using capital letters
set ignorecase
set smartcase
set hlsearch


"----------------- search and replace ----------------------
" search recursively
map <M-s> :execute "vimgrep //j **" <bar> cw<left><left><left><left><left><left><left><left><left><left><left>

" Replace all ocurrences of the word under the cursor.
:nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gc<left><left><left>

" Replace all
nnoremap <leader>ra :%s//gc<left><left><left>


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

"-------------------- fugit --------------------------------
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gp :Gpull<cr>

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

" some simple snipptes
autocmd FileType python inoremap öw while<space>:<left>
autocmd FileType python inoremap öi if<space>:<left>
autocmd FileType python inoremap öd def<space>(self):<esc>F(i
autocmd FileType python inoremap öp <esc>0f)i,<space>
autocmd FileType python inoremap ön None
autocmd FileType python inoremap öe <space>==<space>
autocmd FileType python inoremap öx <space>!=<space>
autocmd FileType python inoremap öh <space><<space>
autocmd FileType python inoremap öl <space>><space>
autocmd FileType python inoremap öH <space><=<space>
autocmd FileType python inoremap öL <space>>=<space>
autocmd FileType python inoremap öv <space>is<space>
autocmd FileType python inoremap öc <space>is not<space>
autocmd FileType python inoremap ör return<space>
autocmd FileType python inoremap ös self.
autocmd FileType python inoremap öt True
autocmd FileType python inoremap öf False
" getter and setter
autocmd FileType python inoremap öag <esc>bywodef<space>get_<esc>pa(self):<cr>return<space>self.<esc>pkkdd
autocmd FileType python inoremap öas <esc>bywodef<space>set_<esc>pa(self,<space><esc>pa):<cr>self.<esc>pa<space>=<space><esc>pkkdd


"-------------------- Mappings -----------------------------
" general bindings
inoremap jk <esc>
inoremap kj <esc>
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
noremap <M-u> <C-u>
noremap <M-d> <C-d>
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
nnoremap <m-x> :bd<cr>


"--------------------- fzf ---------------------------------
set rtp+=~/.fzf
nnoremap <M-e> :Buffers<cr>
nnoremap <M-h> :Files<cr>
nnoremap <leader>fo :Files<cr>
nnoremap <leader>fg :GitFiles?
nnoremap <M-g> :GitFiles?<cr>
nnoremap <leader>fd  :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <M-r> :History<cr>
nnoremap <leader>fr :History<cr>
nnoremap <leader>ff :Files<space>
nnoremap <leader>hk :Maps<cr>
nnoremap <leader>hc :Commands<cr>
nnoremap <leader>zc :Colors<cr>
nnoremap <M-e> :Buffers<cr>
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
nmap ö <Plug>(easymotion-bd-f)
" move up/down
map <M-j> <Plug>(easymotion-j)
map <M-k> <Plug>(easymotion-k)

"--------------------- airline -----------------------------
:let g:airline_theme='gruvbox'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"--------------------- ale ---------------------------------
nnoremap <M-w> :lnext<cr>
nnoremap <M-S-w> :lprevious<cr>
" let g:ale_fix_on_save = 1
nnoremap S :write<cr>:ALEFix<cr>
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'yapf'],
\}

" 'add_blank_lines_for_python_control_statements' - Add blank lines before control statements.
" 'autopep8' - Fix PEP8 issues with autopep8.
" 'black' - Fix PEP8 issues with black.
" 'isort' - Sort Python imports with isort.
" 'yapf' - Fix Python files with yapf.


"--------------------- ultisnips ---------------------------
let g:UltiSnipsSnippetDirectories = ['~/.vim/bundle/vim-snippets/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<m-v>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


"--------------------- YouCompleteMe -----------------------
let g:ycm_autoclose_preview_window_after_completion=1
set completeopt-=preview
nnoremap <C-b> :YcmCompleter GoTo<CR>
nnoremap <C-M-b> :YcmCompleter GoToDefinition<CR>
