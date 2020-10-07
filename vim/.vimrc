" Syntax highlighting
syntax on

" Save temporary files in tmp
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" Unfuck tabs
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Match indendentation
set autoindent

" Stop beeping at me
set visualbell

" Show the current command
set showcmd

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
set ttimeoutlen=100

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
let g:ale_linters = {'rust': ['rls','cargo']}
let g:ale_fixers = {'rust': ['rustfmt']}
" let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_rust_rls_toolchain = 'stable'

highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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


" ======= COC config ======
"

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, 
" requires document symbols feature of language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like:
" coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
