scriptencoding utf-8

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:mapleader = ' '
let g:maplocalleader = '\'
let g:python_host_prog = $HOME.'/.pyenv/shims/python2'
let g:python3_host_prog = $HOME.'/.pyenv/shims/python3'

let NERDTreeIgnore = ['\.pyc$', '\.yarb$']
let g:deoplete#enable_at_startup = 1
let g:go_dispatch_enabled = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'python'] }
let g:tagbar_type_make = { 'kinds': ['m:macros', 't:targets'] }
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

call g:plugins#Init()

filetype plugin indent on

" Theming!
set termguicolors
colorscheme molokai
set background=dark

" Searching
set ignorecase
set showmatch
set smartcase
set wildmode=longest,list
set wildignore+=*/.git/*
set wildignore+=*/.svn/*
set wildignore+=*/Godeps/*
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*

" Set mainly to improve performance
set lazyredraw
set nofoldenable
set synmaxcol=220

" Misc Options
set autowrite
set clipboard^=unnamed,unnamedplus
set completeopt=longest,menuone
set cursorline
set diffopt+=iwhite
set hidden
set linebreak
set listchars=tab:»—,trail:_
set modelines=1
set mouse=a
set nolist
set nowrap
set nowrapscan
set number
set path+=**
set scrolloff=10
set sidescrolloff=10
set splitbelow
set splitright
set timeoutlen=300

if executable('pt')
  set grepprg=pt\ --nocolor\ --nogroup\ --column\ --context\ 0
  set grepformat=%f:%l:%c:%m
endif

nnoremap <leader>f :find<space>
nnoremap <leader>g :grep<space>
nnoremap <leader>b :ls<cr>:b

" Annoying typo fixes
nnoremap q: <nop>
nnoremap ; :

" Play q macro
nnoremap Q @q

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Opposite of J. Split line at current point.
nmap <M-j> i<CR><Esc>d^==kg_lD

" Keep cursor in centre of screen after motions
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz
nnoremap gd gdzz

" Closing buffers/windows more conveniently
nnoremap <silent> <C-x> :bd<cr>
nnoremap <silent> <C-q> :q<cr>

au Filetype json nnoremap <leader>mf :%!python -mjson.tool<cr>
nnoremap <leader>mfw :%s/\s\+$//

nnoremap <leader><space> :nohlsearch<cr>
nnoremap <leader>e :Explore<cr>
nnoremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Arrow keys to resize vim splits
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Return to previous edit point
nnoremap <BS> <C-^>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction

nnoremap <silent> <leader>C :call CleanNoNameEmptyBuffers()<CR>

" Tab to trigger omnifunc completion
inoremap <Tab> <C-x><C-o>

" In completion, arrow keys to select, enter to confirm
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Don't clutter directories with .swp files
silent !mkdir ~/.config/nvim/backup > /dev/null 2>&1
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup

" Don't save backups of gpg asc files
set backupskip+=*.asc
set viminfo=

" Convenient editing of ascii-armoured encrypted files
augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END

" Mappings related to terminal buffers
tnoremap <leader><leader> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

nnoremap <silent> <leader>tv :vsplit +terminal<cr>
nnoremap <silent> <leader>ts :split +terminal<cr>
nnoremap <silent> <leader>tt :tabnew +terminal<cr>
