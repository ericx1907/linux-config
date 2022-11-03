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


""""""""""""""""""
" Plugin Manager "
""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" simple fold
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" better handle auto-indentation in python
Plugin 'vim-scripts/indentpython.vim'

" Auto completion engine for various language (c-family, python3, java, rust,
" etc)
Plugin 'ycm-core/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" :lopen and :lclose to see the full diagnostic message for the current file
let g:ycm_always_populate_location_list = 1
" map go to symbol key
nmap <leader>ysw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>ysd <Plug>(YCMFindSymbolInDocument)

" Add syntax check for python, other langs are supported by YCM
Plugin 'vim-syntastic/syntastic'

" Add PEP 8 checking for python
Plugin 'nvie/vim-flake8'

" trying out some color scheme
Plugin 'jnurmine/Zenburn'

" file system explorer in VIM
Plugin 'preservim/nerdtree'
let NERDTreeShowHidden=1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""""""""""""""""""""
" General Settings "
""""""""""""""""""""
" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put all autocmd in an autocmd group, so that we can reload vimrc safely.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " follow PEP8 coding style for python code
  au BufNewFile,BufRead *.py
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set textwidth=79
      \ set expandtab
      \ set autoindent
      \ set fileformat=unix
  
  " Start NERDTree. If a file is specified, move the cursor to its window.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * set columns=120 lines=70 | NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
  
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | set columns=100 lines=30 | quit | endif
  
  " enable python syntax highlighting
  autocmd BufRead,BufNewFile *.py let python_highlight_all=1
  
  " 2 whitespace indent for vhdl souce file
  au BufNewFile,BufRead *.vhdl
      \ set tabstop=2
      \ set softtabstop=2
      \ set shiftwidth=2
  
  " Flag unnecessary whitespace
  au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
  
  " Restore the normal terminal size when leaving vim
  au VimLeave * set columns=100 lines=30

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

" turn on line numbers for all files
set number 

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za 

" Using UTF-8 enconding
set encoding=utf-8

" set the leader key
let mapleader="," 

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Load color scheme based which mode vim is running in
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif



