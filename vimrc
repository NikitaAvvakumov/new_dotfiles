" ===================== Plugins ======================
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Appearance
Plugin 'skwp/vim-colors-solarized'
Plugin 'bling/vim-airline'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'

" Ruby, Rails, etc.
Plugin 'tpope/vim-rails.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'thoughtbot/vim-rspec'

" Syntax & completion
Plugin 'groenewege/vim-less.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'valloric/youcompleteme'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-liquid'
Plugin 'elixir-lang/vim-elixir'
Plugin 'kchmck/vim-coffee-script'

" Improvements
Plugin 'wincent/command-t'
Plugin 'tpope/vim-dispatch'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired'

call vundle#end()            " required
filetype plugin indent on    " required

" ================== Appearance ======================
colorscheme solarized
set background=dark
set guifont=Ubuntu\ Mono:h16

" ================ General Config ====================

set number                      "Line numbers are good
set relativenumber              "Show line numbering relative to current
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set timeout timeoutlen=3000 ttimeoutlen=100 "Short timeout for keycodes

"turn on syntax highlighting
syntax on

" Change leader to a comma
let mapleader=","

" Jump to matching delimiters
runtime macros/matchit.vim

" ===================== Search ======================
set incsearch  "find the next match while typing
set hlsearch   "highlight searches
set ignorecase "ignore case...
set smartcase  "unless an uppercase letter is entered

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points
set colorcolumn=80

if has("autocmd")
  " Jump to last known cursor position when opening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Set text width to 80 chars for markdown files
  au BufRead,BufNewFile *.md setlocal textwidth=80

  " Wrap the quickfix window
  au FileType qf setlocal wrap linebreak

  " Source .vimrc after saving it
  " au BufWritePost .vimrc source ~/.vimrc
  " -> breaks lightline colours, need to fix

  " set JS & HTML indent to 4 spaces
  au Filetype javascript setlocal shiftwidth=4 tabstop=4 sts=0
  au Filetype html setlocal shiftwidth=4 tabstop=4 sts=0
  au BufRead,BufNewFile *.liquid setlocal shiftwidth=4 tabstop=4 sts=0
endif

" ================ Splits ===========================

set splitbelow
set splitright

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Spell check ======================
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Spell-check Markdown files
autocmd FileType markdown setlocal spell

" Spell-check Git messages
autocmd FileType gitcommit setlocal spell

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Custom Settings ========================
" Key mappings
" Move between splits easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

 " 0 goes to the first character in line, ^ goes to beginning of line
nnoremap 0 ^
nnoremap ^ 0

" Misc
" git add, commit, push
map <Leader>gw :!git add --all && git commit -m 'WIP' && git push<cr>
" <Leader>t is used by vim-rspec
map <Leader>p :CommandT<CR>
" Use Ctrl-n to remove highlighting of search results
map <C-n> :nohl<CR>

" vim-surround mappings:
" ,# Surround a word with #{ruby interpolation}
map ,# ysiw#

" ," Surround a word with "double quotes"
map ," ysiw"

" ,' Surround a word with 'single quotes'
map ,' ysiw'

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)

" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[

" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{

" ,` Surround a word with `backticks`
map ,` ysiw`

so ~/.yadr/vim/settings/syntastic.vim
so ~/.yadr/vim/settings/vim-rspec.vim
so ~/.yadr/vim/settings/solarized.vim
so ~/.yadr/vim/settings/ycm.vim

" ==================== vim-airline =====================
set laststatus=2
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
