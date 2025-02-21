" Vim configuraton file for Eric Xu
"
" Maintainer:	Erix Xu	<ee.chengxu@gmail.com>
" Last change:	2022 Oct 27
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" set leader key to space bar
let mapleader=" "

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

"""""""""""""""""""""""""""
" vim-plug plugin manager "
"""""""""""""""""""""""""""
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes


" Auto completion engine for various language (c-family, python3, java, rust, etc)
Plug 'ycm-core/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" :lopen and :lclose to see the full diagnostic message for the current file
let g:ycm_always_populate_location_list = 1
" map go to symbol key
nmap <leader>ysw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>ysd <Plug>(YCMFindSymbolInDocument)
" Additional LSP server for other languages
let g:ycm_language_server = [
  \   {
  \	'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ 'vim-language-server' , '--stdio' ]
  \   },
  \ ]
"  \   {
"  \	'name': 'hdl_checker',
"  \     'filetypes': [ 'vhdl', 'verilog', 'systemverilog' ],
"  \     'cmdline': [ 'hdl_checker' , '--lsp' ]
"  \   }
let g:ycm_error_symbol = 'E'
let g:ycm_warning_symbol = 'W'
let g:ycm_max_diagnostics_to_display = 0

" Add syntax check
Plug 'dense-analysis/ale'
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" Disable ALE's own LSP functionality beacuse using YCM
let g:ale_disable_lsp = 1
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'vhdl'      : ['hdl_checker', 'xvhdl'],
  \ }

" Add PEP 8 checking for python
Plug 'nvie/vim-flake8'

" trying out some color scheme
Plug 'jnurmine/Zenburn'

" file system explorer in VIM
Plug 'preservim/nerdtree'
let NERDTreeShowHidden=1

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Airline statusbar and theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git Intergration
Plug 'tpope/vim-fugitive'

" unicode support
Plug 'chrisbra/unicode.vim'

" text filtering and alignment
Plug 'godlygeek/tabular'

" diffs on blocks of code/text
Plug 'AndrewRadev/linediff.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()            " required
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
" To turn on selectively on some file type:
" autocmd BufRead,BufNewFile *.py filetype indent on

""""""""""""""""""""
" User Key Mapping "
""""""""""""""""""""
nnoremap <leader>sp :set spell<CR>
nnoremap <leader>ns :set nospell<CR>
nnoremap <leader>h :noh<CR>
nnoremap <leader>l :lopen<CR>
nnoremap <leader>c :lclose<CR>
nnoremap <leader>r :%s/\<<C-r><C-w>\>/
nnoremap <leader>t :NERDTreeToggle<CR>
" move selected lines up one line
xn%s/\<<C-r><C-w>\>/oremap <S-k> :m-2<CR>gv=gv
" move selected lines down one line
xnoremap <S-j> :m'>+<CR>gv=gv
" copy selected objects using ctrl+c
"vnoremap <C-c> <Esc>`>a<CR><Esc>`<i<CR><Esc>vg_:w !xclip -i -selection c<CR><CR>kJJ
vnoremap <silent><C-c> "zy
\:call writefile(getreg('z', 1, 1), $HOME."/.vim/vim_clipboard")<CR>
\:call system("xclip -r -sel c $HOME/.vim/vim_clipboard")<CR>

""""""""""""""""""""""""""""""""""""""""
"********** General Settings **********"
""""""""""""""""""""""""""""""""""""""""
" Color and Highlight "
" use more precise color
if has("termguicolors")
  set termguicolors
endif

" Load nice color scheme if it is installed
if !empty(globpath(&rtp, "colors/zenburn.vim"))
  colorscheme zenburn
else
  colorscheme default
endif

" highlight current line
set cursorline
highlight Cursorline ctermbg=238

" Keep text selected original color
highlight Visual ctermfg=NONE guifg=NONE
" Keep background color of Line number column same as gutter
highlight LineNr guibg=#343434
highlight CursorLineNr guibg=#343434

"show extrx info about completion candiate in popup window
set completeopt=popup,menuone

" Enable mouse support
set mouse=a

" Always enable statuslien for any window
set laststatus=2

" specify how vim formats text
"set formatoptions=tcql

" turn on relative line numbers for all files
set number
set relativenumber

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable switching buffer without save the current change
set hidden

" Enable folding with the spacebar
" nnoremap <space> za

" Using UTF-8 encoding
set encoding=utf-8

" Set different cursor shape in normal or insert mode
let &t_SI = "\e[6 q" "insert mode steady bar
let &t_EI = "\e[2 q" "normal mode steady block

" When started as "evim", evim.vim will already have done these settings, bail out.
if v:progname =~? "evim"
  finish
endif

" keep a backup file (restore to previous version)
set backup
set backupdir=~/.vim/tmp/
set dir=~/.vim/tmp/swap/ " set the directory for swap files
"if has('persistent_undo')
"  set undofile	 " undo changes after closing
"endif

" Switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

" Initilize vim ariline status bar
function! AirlineInit()
  "let g:airline_powerline_fonts = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " powerline symbols
  let g:airline_left_sep = ""
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.colnr = ' ℅:'
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ' :'
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.whitespace = '⌷'
  let g:airline_symbols.dirty = '⚡'
  let g:airline_theme = 'zenburn'

  let g:airline_section_z = '%p%% %l:%v'

  let g:airline#extensions#ale#enabled = 1
  let g:airline#extensions#fzf#enabled = 1
  let g:airline#extensions#ycm#enabled = 1
  let g:airline#extensions#wordcount#enabled = 1
endfunction

call AirlineInit()

augroup MyYCMCustom
  autocmd!
  autocmd FileType vim let b:ycm_hover = {
    \ 'command': 'GetHover',
    \ 'syntax': &filetype
    \ }
augroup END

" Put all autocmd in an autocmd group, so that we can reload vimrc safely.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 88 characters.
  autocmd FileType text setlocal textwidth=88

  " follow PEP8 coding style for python code
  au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

  " Start NERDTree. If a file is specified, move the cursor to its window.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if !exists('b:NERDTree') | NERDTree | endif | if argc() > 0 || exists("s:std_in") | wincmd p | endif

  " If using Ubuntu terminal change the size, do not change size in windows
  "+terminal
  "autocmd VimEnter * if $TERM_UBUNTU == 1 | set columns=140 lines=70 | endif | NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif


  " Exit Vim if NERDTree is the only window remaining in the only tab.
  "autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | if $TERM_UBUNTU == 1 | set columns=100 lines=40 | endif | quit | endif
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

  " enable python syntax highlighting
  autocmd BufRead,BufNewFile *.py let python_highlight_all=1

  au BufRead,BufNewFile * filetype indent off

  "au FileType vhdl filetype indent on

  " 2 whitespace indent for vhdl souce file
  au BufRead,BufNewFile *.vhd
    \ let g:vhdl_indent_genportmap = 0 |
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set fileformat=unix

  " Flag unnecessary whitespace
  au BufRead,BufNewFile *.py
    \ hi BadWhitespace ctermbg=88 |
    \ match BadWhitespace /\s\+$/

  "au VimLeave * if $TERM_UBUNTU == 1 | set columns=100 lines=40 | endif

augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

""""""""""""""""""
" Custom Command "
""""""""""""""""""
" This command is similar to the original Rg but allow user to specify additional options to ripgrep
" before the match expression
command! -bang -nargs=* Rgx
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
      \   fzf#vim#with_preview(), <bang>0)

hi Terminal ctermbg=237 ctermfg=188
