call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'divan/incognito'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tmhedberg/matchit'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
if has('nvim')
	Plug 'Shougo/deoplete.nvim'
	Plug 'zchee/deoplete-go', { 'do': 'make'}
else
	Plug 'Shougo/neocomplete.vim'
	Plug 'SirVer/ultisnips'
endif
Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
" Plug 'bdauria/angular-cli.vim'
Plug 'chase/vim-ansible-yaml'
Plug 'ternjs/tern_for_vim'
call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required

" Basics
set modelines=3
set number
set ts=4
set sw=4

" Colors & higliting
syntax enable
colors incognito
" set background=light

" make braket matching highlight more comfortable
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Settings
set scrolloff=7
set nobackup          	" Don't create annoying backup files
set ruler		" Show ruler
set splitright          " Split vertical windows right to the current windows
set encoding=utf-8      " Set default encoding to UTF-8
set termencoding=utf-8

set showbreak=>\
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set lazyredraw          	" Wait to redraw "
set ttyfast
set wildmenu
set wildmode=longest,list,full
set undofile
set undodir=/tmp
set dir=/tmp
set laststatus=2
set hidden

syntax sync minlines=256
set synmaxcol=300
set re=1
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Common hotkeys
nmap <F7> :NERDTree<CR>
let NERDTreeQuitOnOpen=1

nmap <Leader>c :close<CR>
nmap <Leader>W :set wrap!<cr>
nmap <Leader>N :set number!<cr>

" Fast saving and quitting
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>

" Close location list (window with errors) easily
nnoremap <leader>a :lclose<CR>
" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Do not show stupid q: window
map q: :q

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ==================== Vim-go ====================
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
let g:go_autodetect_gopath = 1
let g:go_disable_autoinstall = 1

let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap gr <Plug>(go-run)
au FileType go nmap gb <Plug>(go-build)
au FileType go nmap gt <Plug>(go-test)
au FileType go nmap gl <Plug>(go-test-compile)
au FileType go nmap gi <Plug>(go-info)
au FileType go nmap gn <Plug>(go-doc-browser)
au FileType go nmap gh <Plug>(go-doc)
au FileType go nmap gv <Plug>(go-doc-vertical)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap gds <Plug>(go-def-split)

au FileType go nmap <Leader>a <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)

au FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <Leader>i :GoImports<CR>
au FileType go nmap <Leader>t :GoAlternate<CR>

" airline
let g:airline#extensions#tabline#enabled = 1

set autowrite


" ==================== completion and snippet =========================
" use deoplete for Neovim and neocomplete for Vim.
set pumheight=10             " Completion window max size<Plug>delimitMateCR
" disable preview window for autocomplete
set completeopt-=preview
if has('nvim')
	" Path to python interpreter for neovim
	let g:python3_host_prog  = '/usr/local/bin/python3'
	" Skip the check of neovim module
	let g:python3_host_skip_check = 1

	let g:deoplete#enable_at_startup = 1

	" Use partial fuzzy matches like YouCompleteMe
	call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
else
	let g:acp_enableAtStartup = 1

	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_smart_case = 1
	let g:neocomplete#sources#syntax#min_keyword_length = 5
	let g:neocomplete#manual_completion_start_length = 5
	let g:neocomplete#auto_completion_start_length = 5
	call neocomplete#custom#source('ultisnips', 'min_pattern_length', 2)

	if !exists('g:neocomplete#sources')
		let g:neocomplete#sources = {}
	endif
	let g:neocomplete#sources._ = ['buffer', 'member', 'tag', 'file', 'dictionary']
	let g:neocomplete#sources.go = ['omni']

	" disable sorting
	call neocomplete#custom#source('_', 'sorters', [])
endif

function! s:tab_complete()
	if pumvisible()
		return "\<c-n>"
	endif

	if neosnippet#expandable_or_jumpable() 
		return "\<Plug>(neosnippet_expand_or_jump)"
	endif

	return "\<tab>"
endfunction
imap <silent><expr><TAB> <SID>tab_complete()

" smap <expr><tab> neosnippet#expandable_or_jumpable() ? 
"			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" imap <silent><expr> <CR> pumvisible() ? "\<C-y>" : '\<CR>'

" autocmd InsertLeave * NeoSnippetClearMarkers

" Tagbar for Go
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
	\ }

nmap <F8> :TagbarToggle<CR>

autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal g`\"" |
			\ endif

if has('nvim')
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_complete_start_length = 6
	let g:deoplete#auto_complete_delay = 100
	let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
	let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
endif

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.vim/plugged/vim-go/gosnippets/snippets/'

set relativenumber

" Typescript
au FileType typescript setl sw=2 sts=2 et

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd FileType javascript JsPreTmpl html
autocmd FileType typescript JsPreTmpl markdown
autocmd FileType typescript syn clear foldBraces
autocmd FileType javascript set noet

" autocmd FileType typescript,html call angular_cli#init()
" au FileType typescript,css nmap <leader>t :ETemplate<CR>
" au FileType html,css nmap <leader>c :EComponent<CR>
" au FileType typescript,html nmap <leader>s :EStylesheet<CR>
" au FileType typescript,html,css nmap <leader>e :ESpec<CR>

" Easier buffer switching
nnoremap <leader>§ :e #<CR>
nnoremap <leader>1 :b 1<CR>
nnoremap <leader>2 :b 2<CR>
nnoremap <leader>3 :b 3<CR>
nnoremap <leader>4 :b 4<CR>
nnoremap <leader>5 :b 5<CR>
nnoremap <leader>6 :b 6<CR>
nnoremap <leader>7 :b 7<CR>

"Relative with start point or with line number or absolute number lines
function! NumberToggle()
    if(&nu == 0)
        set number
        set relativenumber
    else
        set norelativenumber
        set nonumber
    endif
endfunction

nnoremap <silent> <leader>n :call NumberToggle()<CR>

nnoremap <Leader><Leader> <C-^>

