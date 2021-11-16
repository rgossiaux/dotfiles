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

" (nvim) Live substitution
set inccommand=nosplit

" Increase command history
set history=200

" Light background
set background=light

" And colors
set termguicolors

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
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" fzf for fuzzy completion
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_nvim_statusline = 0
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>f :BLines<CR>

" Plug 'rust-lang/rust.vim'

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

" Try disabling the argument text object in favor of treesitter stuff below
autocmd User targets#mappings#user call targets#mappings#extend({
   \ 'a': {},
   \ })


""" nvim stuff
Plug 'neovim/nvim-lspconfig'

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gy :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>
nmap <silent> <C-k> :lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> <C-j> :lua vim.lsp.diagnostic.goto_next()<CR>

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 5000)
augroup END

" Formatter for per-project formatting
Plug 'mhartington/formatter.nvim'

" nvim LSP code action display
Plug 'kosayoda/nvim-lightbulb'
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" nvim treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': '0.5-compat'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch': '0.5-compat'}

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" Open all folds when opening a buffer
autocmd BufWinEnter * normal zR

" LSP snippets
" Feel like I have never used this though, TODO figure something out here lol

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

imap <expr> <Tab> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'        : '<Tab>'
smap <expr> <Tab> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'        : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)   ? '<Plug>(vsnip-jump-prev)'     : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)   ? '<Plug>(vsnip-jump-prev)'     : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet
" See https://github.com/hrsh7th/vim-vsnip/pull/50

nmap       s   <Plug>(vsnip-select-text)
xmap       s   <Plug>(vsnip-select-text)
nmap       S   <Plug>(vsnip-cut-text)
xmap       S   <Plug>(vsnip-cut-text)

" nvim LSP completion
Plug 'nvim-lua/completion-nvim'

let g:completion_enable_snippet = 'vim-vsnip'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" Set compleopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

autocmd BufEnter * lua require'completion'.on_attach()

" nvim quickfix fanciness
Plug 'kevinhwang91/nvim-bqf'
call plug#end()

" More nvim LSP stuff
:lua << EOF
local nvim_lsp = require'lspconfig'
local configs = require'lspconfig/configs'
nvim_lsp.pyright.setup{}
EOF

:lua << EOF
vim.lsp.set_log_level("debug")
EOF

:lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    update_in_insert = false,
    underline = true,
  }
)
EOF

autocmd Filetype python set omnifunc=v:lua.vim.lsp.omnifunc

" More treesitter config
lua << EOF
require 'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ap"] = "@block.outer",
        ["ip"] = "@block.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["g>"] = "@parameter.inner",
      },
      swap_previous = {
        ["g<"] = "@parameter.inner",
      },
    },
  },
  indent = {
    enable = true,
    disable = {"python"},
  },
  highlight = {
    enable = true,
  },
}
EOF

" Defend against bad .vimrc files
set secure
