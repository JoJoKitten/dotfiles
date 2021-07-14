"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|

"--------------- vim-plug plugin manager ---------------------
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'mildred/vim-bufmru'
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-css-color'
Plug 'junegunn/goyo.vim'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'baskerville/vim-sxhkdrc'
Plug 'MTDL9/vim-log-highlighting'
Plug 'sirtaj/vim-openscad'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'morhetz/gruvbox'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
call plug#end()


"----------------------------------------------------------
set nocompatible
filetype off

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
set sidescrolloff=20
" don't highlight cursor line
set nocursorline

" in C-A: don't assume a number starting with 0 to be octal
set nrformats-=octal

" 2 to always show status bar
set laststatus=2

" completion
set wildmenu
set wildmode=longest,list,full

set mouse=nv

" hide status info
set noshowmode

" appearance
set background=dark
set termguicolors
hi LineNr ctermbg=NONE guibg=NONE
let g:nvcode_termcolors=256
colorscheme nord
hi StatusLine ctermbg=NONE cterm=NONE

map <M-1> :set background=dark<cr>:set notermguicolors<cr>:colorscheme slate<cr>:hi StatusLine ctermbg=NONE cterm=NONE<cr>
map <M-2> :set background=dark<cr>:set termguicolors<cr>:colorscheme nord<cr>
map <M-3> :set background=dark<cr>:set termguicolors<cr>:colorscheme onedark<cr>
map <M-4> :set background=light<cr>:set termguicolors<cr>:colorscheme gruvbox<cr>

" unsaved changes: ask instead of fail
set confirm

" shortcut timeouts
set timeout timeoutlen=200 ttimeout ttimeoutlen=200

" tabs
set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" spell check
set nospell
set spelllang=en,de
map <leader>ss :set spell!<cr>

"----------------- search and replace ----------------------
" case insensitive search except when using capital letters
set ignorecase
set smartcase
set hlsearch

" allows incsearch highlighting for range commands
cnoremap <M-d> <CR>:t''<CR>
cnoremap <M-m> <CR>:m''<CR>

" search recursively
map <M-s> :execute "vimgrep //j **" <bar> cw<left><left><left><left><left><left><left><left><left><left><left>

" Replace all ocurrences of the word under the cursor.
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gc<left><left><left>

" Replace all
nnoremap <leader>ra :%s//gc<left><left><left>


"-------------------- folding ------------------------------
set foldmethod=syntax
set foldnestmax=3
set nofoldenable
set foldlevel=1
set foldminlines=3
highlight Folded ctermbg=none ctermfg=Grey
highlight FoldColumn ctermbg=none ctermfg=Grey
set fillchars=fold:\ ,

set foldtext=FoldText()
function! FoldText()
  let l:lpadding = &fdc
  redir => l:signs
    execute 'silent sign place buffer='.bufnr('%')
  redir End
  let l:lpadding += l:signs =~ 'id=' ? 2 : 0

  if exists("+relativenumber")
    if (&number)
      let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
    elseif (&relativenumber)
      let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1
    endif
  else
    if (&number)
      let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
    endif
  endif
  let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
  let l:info = ' (' . (v:foldend - v:foldstart) . ')'
  let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
  let l:width = winwidth(0) - l:lpadding - l:infolen
  let l:separator = ' … '
  let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
  let l:start = strpart(l:start , 0, l:width - l:separatorlen)
  let l:text = l:start . ' … '
  return l:text . repeat(' ', 5) . l:info
endfunction


"-------------------- YankRing -----------------------------
" fix for error message
let g:yankring_clipboard_monitor=0


"-------------------- fugit --------------------------------
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gp :Gpull<cr>

"-------------------- xml ----------------------------------
autocmd FileType xml set foldmethod=indent

"-------------------- json ---------------------------------
autocmd FileType xml set foldmethod=indent
autocmd FileType xml set shiftwidth=2
autocmd FileType xml set softtabstop=2

"-------------------- yaml ---------------------------------
autocmd FileType yaml set foldmethod=indent
autocmd FileType yaml set shiftwidth=2
autocmd FileType yaml set softtabstop=2

"-------------------- python -------------------------------
" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
autocmd FileType python match Excess /\%121v.*/
autocmd FileType python set textwidth=120
autocmd FileType python set foldmethod=indent

"-------------------- golang -------------------------------
autocmd FileType go setlocal noexpandtab

"-------------------- Mappings -----------------------------
" general bindings
inoremap jk <esc>
inoremap kj <esc>
nnoremap Y y$
nnoremap <leader>l :nohl<cr><C-l>

" . on all selected lines
vnoremap . :normal .<cr>
" execute tag t on all selected lines
vnoremap @ :normal @t<cr>

" copy/paste
noremap <M-c> "+y
nnoremap <M-p> "+p
noremap! <M-p> <C-r>+

noremap <leader>ya :%y+<cr>
noremap <leader>da ggdG
noremap <leader>pa ggdG"+p

" cd
nnoremap <leader>cd :cd %:p:h<cr>
nnoremap <leader>cdw :lcd %:p:h<cr>

" execute current file
nnoremap <F5> :! "%:p"<cr>

" Files
nnoremap s :w<cr>
nnoremap <leader>qq :q<cr>
nnoremap <leader>qa :qa<cr>
nnoremap <leader>wq :wq<cr>

" options
nnoremap <leader>zw :set invwrap<cr>

" line numbers
nnoremap <leader>nr :set number relativenumber<cr>
nnoremap <leader>na :set number norelativenumber<cr>
nnoremap <leader>nn :set nonumber norelativenumber<cr>

" split
nnoremap <leader>sv :vs<cr>
nnoremap <leader>sh :sp<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" too lazy to press Ctrl :)
noremap <M-u> <C-u>
noremap <M-d> <C-d>
nnoremap <M-o> <C-o>
nnoremap <M-i> <C-i>

" goto next/previous change
nnoremap H g;
nnoremap L g,

" tags
map <C-b> <C-]>

" horizontal scrolling
nnoremap zh zH
nnoremap zl zL

" folds
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
nnoremap <M-q> :bd<cr>

"--------------------- easy-align --------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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
nnoremap <M-l> :Lines<cr>
nnoremap <M-S-m> :Tags<cr>


"--------------------- sxhkd syntax ------------------------
autocmd BufRead,BufNewFile ~/dotfiles/dotfiles/sxhkd/sxhkdrc set filetype=sxhkdrc


"--------------------- Nerd tree ---------------------------
nnoremap <M-n> :NERDTreeToggle<cr>
nnoremap <M-S-n> :NERDTreeFind<cr>
let NERDTreeWinPos="left"
let NERDTreeIgnore=['\.pyc$', '\~$']

"--------------------- Goyo --------------------------------
nnoremap <M-0> :Goyo<cr>
let g:goyo_height="90%"
let g:goyo_width="120"

"--------------------- markdown ----------------------------
" disable folding, otherwise it does not work in vimwiki
let g:vim_markdown_folding_disabled = 1

"--------------------- easymotion --------------------------
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys="asdghklqwertyuiopzxcvbnmfj"
" move to char
nmap ö <Plug>(easymotion-bd-f)
" move up/down
map <M-j> <Plug>(easymotion-j)
map <M-k> <Plug>(easymotion-k)

"--------------------- coc.nvim ----------------------------
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <C-m> <Plug>(coc-definition)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>ga <Plug>(coc-codeaction)
nmap <leader>gl <Plug>(coc-format)
nmap <M-w> <Plug>(coc-diagnostic-next)
nmap <M-S-w> <Plug>(coc-diagnostic-next-error)
nmap <M-Enter> :CocFix<cr>
nnoremap <silent> <M-m> :<C-u>CocList outline<cr>

" show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"--------------------- treesitter --------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF


