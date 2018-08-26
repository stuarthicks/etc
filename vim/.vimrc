filetype plugin indent on
syntax enable

" Theming!
set termguicolors
set background=dark

colorscheme NeoSolarized

let g:mapleader = ' '
let g:maplocalleader = '\'

let g:NERDTreeIgnore = ['\.pyc$']

" Searching
set hlsearch
set showmatch
set smartcase
set wildmode=longest,list
set wildignore+=*/.idea/*
set wildignore+=*/.git/*
set wildignore+=*/.svn/*
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
nnoremap <silent> <Leader><space> :nohlsearch<cr>

set clipboard^=unnamed,unnamedplus
set completeopt=longest,menuone
set diffopt+=iwhite
set foldlevelstart=20
set foldmethod=syntax
set hidden
set listchars=tab:›—,trail:_,space:.
set modelines=1
set mouse=a
set nolist
set nowrap
set nowrapscan
set number
set path+=**
set scrolloff=5
set sidescrolloff=5
set splitbelow
set splitright
set synmaxcol=500
set timeoutlen=300

" Navigation
nnoremap <Leader>e :Explore<cr>
nnoremap <Leader>n :NERDTreeToggle<cr>
nnoremap <Leader>f :Files<cr>
nnoremap <Leader>g :grep<space>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :TagbarToggle<cr>

" Annoying typo fixes
nnoremap q: <nop>
nnoremap ; :

" Don't jump cursor when using * to search for word under cursor
nnoremap * *``

" Play q macro
nnoremap Q @q

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" junegunn/vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" Remove trailing whitespace
nnoremap <Leader>w :%s/\s\+$//<cr>

" Auto handle paste-mode
nnoremap <Leader>P :set paste<CR>o<esc>"*]p:set nopaste<cr>
set pastetoggle=<C-i>

" Arrow keys to resize vim splits
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Return to previous edit point
nnoremap <BS> <C-^>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Delete erroneous [No Name] buffers
nnoremap <silent> <Leader>B :call g:buffers#CleanNoNameEmptyBuffers()<CR>

" Don't clutter directories with .swp files
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set backupdir=~/.vim/backup
set directory=~/.vim/backup

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
