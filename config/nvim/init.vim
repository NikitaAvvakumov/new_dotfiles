call plug#begin('~/.vim/plugged')

" Appearance
" Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

" Syntax, completion & linting
Plug 'cakebaker/scss-syntax.vim'
Plug 'davidhalter/jedi-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-rails'
Plug 'w0rp/ale'

" Improvements
" Plug 'kassio/neoterm'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dietsche/vim-lastplace'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'

" Code
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'scss', 'less', 'html', 'xdefaults', 'javascript', 'javascript.jsx'] }
Plug 'janko-m/vim-test'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'

call plug#end()

" ================== Appearance ======================
" colorscheme gruvbox
set termguicolors
colorscheme nord
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
set colorcolumn=100
set expandtab
set cursorline
set cursorcolumn
set formatoptions+=j            "improved line joins with 'J'
"
" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Wrap the quickfix window
au FileType qf setlocal wrap linebreak

" Set text width to 80 chars for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

set splitbelow
set splitright

" Search
set ignorecase "ignore case when searching
set smartcase  "unless search string includes uppercase letter
set inccommand=nosplit "substitution preview in place

" `Find` command to use ripgrep to search in files
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

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

set scrolloff=8         "Start scrolling when 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ==================== Errors ==========================

" Highlight trailing whitespaces
match ErrorMsg '\s\+$'
" Highlight characters past line length of 120
match ErrorMsg '\%>120v.\+'

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

map <Leader>p :Files<CR>
" Use Ctrl-n to remove highlighting of search results
map <C-n> :nohl<CR>

" vim-surround mappings:
" ,# Surround a word with #{ruby/elixir interpolation}
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

" search from selection in Normal mode
vnoremap // y/<C-R>"<CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let test#strategy = "neovim"

function! ElixirUmbrellaTransform(cmd) abort
  if match(a:cmd, 'apps/') != -1
    return substitute(a:cmd, 'mix test apps/\([^/]*/\)', 'cd apps/\1 \&\& mix test ', '')
  else
    return a:cmd
  endif
endfunction

let g:test#preserve_screen = 0
let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'

" ==================== ale =========================
let g:ale_linters = {
  \ 'javascript': ['eslint', 'flow'],
  \ 'elixir': ['elixir', 'elixir-ls'],
  \ 'ruby': ['rubocop', 'ruby']
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\   'elixir': ['mix_format']
\}
let g:ale_fix_on_save = 1

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_sign_error = '>>' " could use emoji
let g:ale_sign_warning = '--' " could use emoji
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_ruby_rubocop_executable = 'bundle'
" Run RuboCop with Rails cops
let g:ale_ruby_rubocop_options = '-R'
let g:ale_elixir_elixir_ls_release = '/Users/nikita/.elixir/elixir-ls/rel'
let g:ale_elixir_elixir_ls_config = {
\   'elixirLS': {
\     'dialyzerEnabled': v:false,
\   },
\ }
" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

" ================ deoplete ========================
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#max_list = 10
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['tabnine', 'buffer', 'tag', 'around']
" call deoplete#custom#option({
" \ 'smart_case': v:true,
" \ 'max_list': 10,
" \ 'sources': {
" \   '_': ['tabnine', 'buffer', 'tag', 'around'],
" \ }
" \ })

" enable tab completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ================ alchemist ========================
let g:alchemist_iex_term_split = 'vsplit'
let g:alchemist_iex_term_size = 100

" ================ vim-jedi ========================
let g:jedi#force_py_version = 3

" =================== neoterm ======================
let g:neoterm_default_mod = 'botright'
