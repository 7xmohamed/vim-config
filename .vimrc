" ============================================================================
" Minimalist Vim Configuration with IDE-like features (Vim Compatible)
" ============================================================================

" Initialize vim-plug plugin manager
call plug#begin('~/.vim/plugged')

" ============================================================================
" Appearance & Themes
" ============================================================================
Plug 'sainnhe/everforest'                 " Modern, eye-friendly theme
Plug 'vim-airline/vim-airline'            " Status line
Plug 'vim-airline/vim-airline-themes'     " Status line themes

" ============================================================================
" IDE-like Features
" ============================================================================
Plug 'preservim/nerdtree'                 " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'        " Git status in NERDTree

" ============================================================================
" Development Tools
" ============================================================================
Plug 'tpope/vim-fugitive'                 " Git integration
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'               " Auto-close brackets/quotes
Plug 'tpope/vim-commentary'               " Easy commenting
Plug 'airblade/vim-gitgutter'             " Git diff indicators

" ============================================================================
" Search & Navigation
" ============================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                   " Fuzzy finder

" ============================================================================
" Syntax & Language Support
" ============================================================================
Plug 'sheerun/vim-polyglot'               " Multi-language syntax pack

call plug#end()

" ============================================================================
" General Settings
" ============================================================================
syntax on
filetype plugin indent on

" Line numbers
set number
set relativenumber
set cursorline                  " Subtle current line highlight

" Theme and appearance
set background=dark
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
let g:everforest_enable_italic = 1
colorscheme everforest

if has('termguicolors')
  set termguicolors            " Enable 24-bit RGB colors if supported
endif

" Clean interface
set noshowmode                 " Don't show mode (status line handles this)
set laststatus=2               " Always show status line

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set cindent
set autoindent

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" General improvements
set mouse=a
if has('clipboard')
  set clipboard=unnamedplus    " Use system clipboard if available
endif
set scrolloff=8                " Keep 8 lines visible when scrolling
set sidescrolloff=8
set nowrap                     " Disable line wrapping
set hidden                     " Allow switching buffers without saving
set updatetime=300             " Faster completion
set timeoutlen=500             " Faster key sequence completion

" Split behavior
set splitbelow
set splitright

" File management
set nobackup
set nowritebackup
set noswapfile
if has('persistent_undo')
  set undofile                 " Persistent undo
  set undodir=~/.vim/undodir
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif
endif

" Performance
set lazyredraw                 " Don't redraw during macros
set ttyfast                    " Faster terminal connection

" ============================================================================
" Airline Configuration (Clean tabs and status)
" ============================================================================
let g:airline_theme = 'everforest'
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1

" Enable tabline (top tabs)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Clean separators
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '│'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = '│'

" Status line sections - minimal and clean
let g:airline_section_a = airline#section#create_left(['mode'])
let g:airline_section_b = airline#section#create(['branch'])
let g:airline_section_c = airline#section#create(['%f'])
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_y = airline#section#create(['%p%%'])
let g:airline_section_z = airline#section#create(['%l:%c'])

" Extensions
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1

" Custom symbols (simple ASCII)
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = '[RO]'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = '*'

" ============================================================================
" GitGutter Configuration
" ============================================================================
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '▸'
let g:gitgutter_sign_removed_first_line = '▾'
let g:gitgutter_sign_modified_removed = '~'
let g:gitgutter_preview_winsize = 30
let g:gitgutter_diff_relative_to = 'working_tree'

" ============================================================================
" NERDTree Configuration
" ============================================================================
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']
let g:NERDTreeStatusline = ''
let g:NERDTreeWinSize = 30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeQuitOnOpen = 0

" ============================================================================
" Key Mappings
" ============================================================================
let mapleader = " "

" NERDTree toggle
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>e :NERDTreeFind<CR>

" Buffer navigation (tab-like behavior)
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap <leader>X :bufdo bd<CR>

" Buffer selection with airline tabline numbers
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" FZF fuzzy search
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <leader>b :Buffers<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlighting
nnoremap <Esc> :noh<CR><Esc>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Toggle relative line numbers
nnoremap <leader>n :set relativenumber!<CR>

" Git operations
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>

" ============================================================================
" Copy/Paste Functionality (Ctrl+C / Ctrl+V)
" ============================================================================

" Visual mode: Ctrl+C to copy selection to system clipboard
vnoremap <C-c> "+y

" Normal mode: Ctrl+C to copy current line to system clipboard
nnoremap <C-c> "+yy

" Insert mode: Ctrl+V to paste from system clipboard
inoremap <C-v> <C-r>+

" Normal mode: Ctrl+V to paste from system clipboard
nnoremap <C-v> "+p

" Visual mode: Ctrl+V to paste and replace selection
vnoremap <C-v> "+p

" Command mode: Ctrl+V to paste from system clipboard
cnoremap <C-v> <C-r>+

" Additional useful mappings
" Ctrl+A to select all
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG

" Ctrl+S to save (common habit)
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Ctrl+Z to undo (insert mode)
inoremap <C-z> <C-o>u

" Make sure we have system clipboard support
if has('clipboard')
  set clipboard=unnamedplus
endif

" ============================================================================
" CoC Configuration
" ============================================================================
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" ============================================================================
" Auto Commands
" ============================================================================
augroup MyAutoCommands
  autocmd!
  " Auto-close NERDTree if it's the last window
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

  " Remove trailing whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Highlight current line only in active window
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" ============================================================================
" FZF Configuration
" ============================================================================
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = { 'down': '40%' }

" Customize fzf colors to match everforest theme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ============================================================================
" Custom Commands
" ============================================================================
" Quick config edit
command! Config edit ~/.vimrc
command! Reload source ~/.vimrc

" Better command-line completion
set wildmenu
set wildmode=longest:full,full

" Show matching brackets
set showmatch

" Better backup, swap and undo directory handling
if !isdirectory($HOME.'/.vim/backup')
  call mkdir($HOME.'/.vim/backup', 'p')
endif
if !isdirectory($HOME.'/.vim/swap')
  call mkdir($HOME.'/.vim/swap', 'p')
endif
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" ============================================================================
" Custom Startup Screen Configuration
" ============================================================================

" Custom startup screen function
function! StartScreen()
  enew
  setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ norelativenumber
        \ nospell
        \ noswapfile
        \ signcolumn=no

  " ASCII Art for 7xmohamed
  let l:header = [
        \ '',
        \ '',
        \ '    ███████╗██╗  ██╗███╗   ███╗ ██████╗ ██╗  ██╗ █████╗ ███╗   ███╗███████╗██████╗ ',
        \ '    ╚════██║╚██╗██╔╝████╗ ████║██╔═══██╗██║  ██║██╔══██╗████╗ ████║██╔════╝██╔══██╗',
        \ '        ██╔╝ ╚███╔╝ ██╔████╔██║██║   ██║███████║███████║██╔████╔██║█████╗  ██║  ██║',
        \ '       ██╔╝  ██╔██╗ ██║╚██╔╝██║██║   ██║██╔══██║██╔══██║██║╚██╔╝██║██╔══╝  ██║  ██║',
        \ '      ██║   ██╔╝ ██╗██║ ╚═╝ ██║╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║███████╗██████╔╝',
        \ '      ╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═════╝ ',
        \ '',
        \ '                            ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄',
        \ '                            █        www.7xmohamed.com        █',
        \ '                            ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀',
        \ '',
        \ '                                    Quick Start:',
        \ '                              Ctrl+n    File Explorer',
        \ '                              Ctrl+p    Find Files',
        \ '                              Ctrl+c    Copy',
        \ '                              Ctrl+v    Paste',
        \ '                              Space+w   Save File',
        \ '                              Space+q   Quit',
        \ '',
        \ '                           Press any key to start coding...',
        \ ''
        \ ]

  " Calculate center position
  let l:longest = max(map(copy(l:header), 'strwidth(v:val)'))
  let l:left_padding = (&columns - l:longest) / 2

  " Add the header with proper centering
  call append(0, map(copy(l:header), 'repeat(" ", l:left_padding) . v:val'))

  " Position cursor and make it disappear
  normal! gg
  setlocal nomodifiable

  " Auto-start when any key is pressed
  nnoremap <buffer><silent> <Space> :call <SID>close_start_screen()<CR>
  nnoremap <buffer><silent> <CR> :call <SID>close_start_screen()<CR>
  inoremap <buffer><silent> <Esc> <C-o>:call <SID>close_start_screen()<CR>

  " Map most keys to close the start screen
  for s:key in ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    execute 'nnoremap <buffer><silent> ' . s:key . ' :call <SID>close_start_screen()<CR>'
    execute 'nnoremap <buffer><silent> ' . toupper(s:key) . ' :call <SID>close_start_screen()<CR>'
  endfor
endfunction

" Function to close start screen
function! s:close_start_screen()
  enew
  doautocmd VimEnter
endfunction

" Show start screen only when starting vim without arguments
augroup StartScreen
  autocmd!
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call StartScreen() | endif
  autocmd StdinReadPre * let s:std_in=1
augroup END
