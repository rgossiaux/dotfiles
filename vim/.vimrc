" Syntax highlighting
syntax on

" Save temporary files in tmp
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" Play nicely with inotify
set backupcopy=yes

" Unfuck tabs
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Match indendentation
set autoindent

" Stop beeping at me
set visualbell

" Show the current command
set showcmd

" Allow per-project config files
set exrc

" Don't open that annoying menu for autocomplete
set completeopt-=preview

" Show line numbers on the bottom...
set ruler

" ...and the side
" Disabling for now since it seems distracting
" set number

" Always show the status line
set laststatus=2

" Better display for messages
set cmdheight=2

" Backspace fix thing (was needed for YCM)
set backspace=indent,eol,start

" Buffer fixes
set hidden

" Mouse is ok
set mouse=a

" Show first search result
set incsearch

" Increase command history
set history=200

" Tab comletion for commands
set wildmode=longest,list,full
set wildmenu

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show at least one line above/below
set scrolloff=1

" Ignore octal for C-a and C-x
set nrformats-=octal

" Filetype detection
filetype plugin indent on

" Better timeouts for ESC
set ttimeout
set ttimeoutlen=50

" Write swap files sooner than the 4s default
set updatetime=300

" Leader is \
let mapleader = "\\"

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" fzf for fuzzy completion
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_nvim_statusline = 0
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>f :BLines<CR>

" Plug 'rust-lang/rust.vim'

Plug 'dense-analysis/ale'
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_rust_rls_toolchain = 'stable'

highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap gy :ALEGoToTypeDefinition<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap <leader>rn :ALERename<CR>


" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax highlighting and indentation
Plug 'sheerun/vim-polyglot'

" For git integration, especially :Gdiff
Plug 'tpope/vim-fugitive'

" Adds gc motion to toggle comments
Plug 'tpope/vim-commentary'

" Adds ys, ds, cs, and S in visual mode for
" adding, deleting, changing surrounds
Plug 'tpope/vim-surround'

" Adds a lot of handy things with [ and ]
" [<space>: add <count> blank lines above
" ]n: next git conflict marker
" [x: html encode
" [u: url encode
" [q: prev quicklist
" [l: prev loclist
" [b: prev buffer
Plug 'tpope/vim-unimpaired'

" Makes some other plugins work well with . command
Plug 'tpope/vim-repeat'

" Adds a lot of handy text objects, including lots of
" separators like _ and + and a for arguments.
" Possibly consider switching to textobj-user though.
Plug 'wellle/targets.vim'

call plug#end()

" Defend against bad .vimrc files
set secure
