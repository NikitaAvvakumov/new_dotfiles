call plug#begin('~/.vim/plugged')

" Appearance
Plug 'bling/vim-airline'
Plug 'morhetz/gruvbox'

" Syntax, completion & linting
Plug 'cakebaker/scss-syntax.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'elzr/vim-json'
Plug 'leafgarland/typescript-vim'
Plug 'neomake/neomake'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'

" Improvements
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dietsche/vim-lastplace'
Plug 'Shougo/deoplete.nvim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

" Code
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'scss', 'less', 'html', 'xdefaults', 'javascript', 'javascript.jsx'] }
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

call plug#end()

" ================== Appearance ======================
colorscheme gruvbox
set background=dark
set guifont=Ubuntu\ Mono:h16
highlight LineNr ctermbg=black

" ================ General Config ====================

set number                      "Show line numbers
set relativenumber              "Show line numbering relative to current
set history=1000                "Store lots of :cmdline history
set showmode                    "Always show current mode
set showcmd                     "Show incomplete cmds down the bottom
set visualbell                  "No sounds
let mapleader=','

set nowrap
set colorcolumn=80
set expandtab
"
" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" All of the below should be covered by tpope/vim-sleuth
" set smartindent
" set shiftwidth=2
" set softtabstop=2
" set tabstop=2
" set JS, liquid & HTML indent to 4 spaces
" au Filetype javascript setlocal shiftwidth=4 softtabstop=4
au Filetype html setlocal shiftwidth=4 softtabstop=4
au BufRead,BufNewFile *.liquid setlocal shiftwidth=4 softtabstop=4

" Wrap the quickfix window
au FileType qf setlocal wrap linebreak

" Set text width to 80 chars for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

set splitbelow
set splitright

" ================ Persistent Undo ==================
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

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

" ================ Key mappings ========================
" Move between splits easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> <BS> <C-W><C-H>

 " 0 goes to the first character in line, ^ goes to beginning of line
nnoremap 0 ^
nnoremap ^ 0

map <Leader>p :CtrlP<CR>
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

nmap [<Space> O<Esc>
nmap ]<Space> o<Esc>

" vim-rspec
let g:rspec_runner = 'os_x_iterm'
let g:rspec_command = "Dispatch rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" ================== Neomake =========================
autocmd! BufReadPost,BufWritePost * Neomake
let g:neomake_css_enabled_makers = ['csslint']
let g:neomake_elixir_enabled_makers = ['credo']
let g:neomake_html_enabled_makers = ['htmlhint']
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_markdown_enabled_makers = ['markdownlint']
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
let g:neomake_scss_enabled_makers = ['sass-lint']
let g:neomake_sh_enabled_makers = ['sh']
let g:neomake_sql_enabled_makers = ['sqlint']
let g:neomake_typescript_enabled_makers = ['tsc']
let g:neomake_yaml_enabled_makers = ['yamllint']

" ================ vim-airline =====================
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#tab_nr_type = 2

" ================ deoplete ========================
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list = 10
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tag']
" enable tab completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
