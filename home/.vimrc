" pathogen to load all other plugins
call pathogen#infect()
call pathogen#helptags()

" no-compaitable mode for a better vim
set nocompatible

" set line numbers on left
set number

" turn syntax highlighting on
syntax on

" set encoding
set encoding=utf-8

" show title in window title-bar
set title
" title option:
autocmd BufEnter * let &titlestring=hostname() . " [" . expand("%:t") . "]"
" when exiting vim, don't display the 'Thanks for flying VIM' in the title
set titleold=""

" don’t add newlines at the end of a file
set binary
set noeol

" set listchars
set list listchars=trail:·,extends:>,precedes:<
if has("unix")
  " issues with these characters on windows?
  set listchars+=tab:▸\ 
  set listchars+=eol:¬
endif

" add an undofile
set undofile
" set undo file dir
set undodir=~/.vimundo

" set indent options
set smartindent
set autoindent
set cindent

" whitespace settings
set wrap
set linebreak
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" sensible searching options
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set wrapscan
" clear highlighted searches using <leader> + '/'
noremap <silent> <leader>/ :nohlsearch<CR>

" no sounds
set visualbell
set noerrorbells

" turn ruler on to see info at bottom
" set ruler

" set status bar to 2 to show status line
set laststatus=2
" set status line (instead of ruler)
" file name + flags, line # of total lines, position in file, etc.
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" set shellslash to fix backslashes in file names problem
set shellslash

" show the line the cursor is on
set cursorline

" convenient command to save files where 'sudo' was left off
cnoremap w!! w !sudo tee >/dev/null %

" tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
" set complete to not select first item and update completion list as I type
set completeopt=longest,menuone
" autocomplete binding re-map
inoremap <leader><Space> <C-x><C-o>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Use modeline overrides
set modeline
set modelines=10

" add capability for left & right navigation to wrap to next line
set whichwrap+=h,l

" minimum number of lines to keep above and below cursor
set scrolloff=1

" set the /g flag on substitutions by default
set gdefault

" jump down to next line in editor correctly (when lines wrap)
nnoremap j gj
nnoremap k gk

" force self to *not* use escape for leaving insert mode, but jk instead
"inoremap jj <esc>
" don't use escape:
"inoremap <esc> <nop>

noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>ev :edit $MYVIMRC<cr>

" 'alias' 'W' to 'w' so a capital :W will still write
cnoreabbrev W w
cnoreabbrev Q q

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" change autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" save when editor loses focus
autocmd FocusLost * :wa!

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

" custom indentation for python
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,exc
" add in custom indentation preferences here:
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab autoindent smartindent
" PEP 8 style-comply
autocmd FileType python setlocal ts=8 sts=4 sw=4 expandtab autoindent
" treat .rss and .atom files as type .xml files
autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

" omni-complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Rackup, Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby files
autocmd BufRead,BufNewFile Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru setfiletype ruby
" add json syntax highlighting
autocmd BufNewFile,BufRead *.json setfiletype javascript

" folding for vim files
autocmd FileType vim set foldmethod=marker

" for other files
set ofu=syntaxcomplete#Complete

" ============
" COLOR THEMES
" ============
set t_Co=256

" solarized settings {{{
"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized
"syntax enable
set background=dark
colorscheme solarized
" }}}

" github color-theme, white-space BG color edited {{{
"colorscheme github
"hi NonText      guifg=#808080 ctermfg=250  guibg=#ECECEC ctermbg=231  gui=NONE cterm=NONE
"hi SpecialKey   guifg=#FFFFFF ctermfg=250  guibg=#FF1100 ctermbg=231  gui=ITALIC cterm=NONE
" }}}

" monokai color-theme, white-space BG color edited {{{
"colorscheme monokai
"hi NonText ctermfg=59 ctermbg=235 cterm=NONE guifg=#49483e guibg=#31322c gui=NONE
"hi SpecialKey ctermfg=59 ctermbg=235 cterm=NONE guifg=#49483e guibg=#3c3d37 gui=NONE
" }}}

" =======
" PLUGINS
" =======

" NERDTree {{{
" How can I open a NERDTree automatically when vim starts up?
autocmd vimenter * NERDTree
" How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd vimenter * if !argc() | NERDTree | endif
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Give focus to non NERDTree window on start
autocmd VimEnter * wincmd w
" show hidden files/dotfiles
let NERDTreeShowHidden=1
" }}}

" NERDTree Tabs {{{
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:nerdtree_tabs_smart_startup_focus = 1
" }}}

" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" }}}