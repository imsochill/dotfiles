set nocompatible
filetype plugin indent on

"
" General
"
let mapleader=","   " Remap leader to ,
syntax on           " Enable syntax highlighting
set encoding=UTF-8  " Use UTF-8 encoding
set mouse=a         " Enable mouse support
set history=1000    " More history commands
set undolevels=1000 " More undos
set showmatch       " Show matching parenthesis
set title           " Set terminal title

"
" Indentation
"
set autoindent      " Auto indent
set smartindent     " Use smart indenting on new lines
set tabstop=4       " Set tabs to 4 spaces
set shiftwidth=4    " Use 4 spaces to indent
set softtabstop=4   " Use 4 spaces to insert/backspace
set smarttab        " Insert tabes based on shiftwidth, not tabstop
set expandtab       " Use the correct number of spaces in insert mode

"
" Search
"
set hlsearch    " Highlight all search matches
set incsearch   " Show search matches as you type

"
" Completion
"
set complete=.,w,b,u,t,i,kspell           " Look for completions in buffers, ctags, imports and dictionary if spell check
autocmd FileType tex setlocal spell       " Enable spell-check for LaTeX files
autocmd FileType markdown setlocal spell  " Enable spell-check for Markdown files
autocmd FileType gitcommit setlocal spell " Enable spell-check for git commit buffers
autocmd FileType txt setlocal spell       " Enable spell-check for text files

"
" Line Numbers
"
set number relativenumber " Show line numbers, use relativenumber only in normal mode
:augroup numbertoggle
:   autocmd!
:   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
:augroup END

"
" File Handling
"
set autoread        " Reload open files
set hidden          " Allow buffers to not need windows
set noswapfile      " Disable swap files
set nobackup        " No backup before overwriting a file
set nowritebackup   " No backup before overwriting a file

"
" Line handling
"
set nowrap  " Don't wrap lines
set list    " Higlight bad characters
set listchars=tab:̣⭾,nbsp:␣,trail:·

" Plugins
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'nanotech/jellybeans.vim'                          " Jellybeans theme

Plug 'tpope/vim-fugitive'                               " Git wrapper
Plug 'airblade/vim-gitgutter'                           " Git diff markers

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " Filesystem tree
Plug 'xuyuanp/nerdtree-git-plugin'                      " Git status for NERDTree

Plug 'junegunn/fzf'                                     " File fuzzy search
Plug 'majutsushi/tagbar'                                " C-tags
Plug 'majutsushi/tagbar'                                " Code navigation tag bar
Plug 'ctrlpvim/ctrlp.vim'                               " CtrlP for fuzzy file/buffer/mru/tag finder
Plug 'mileszs/ack.vim'                                  " Ack, grep like editting for source code

Plug 'scrooloose/syntastic'                             " Syntax check
Plug 'w0rp/ale'                                         " Async linting
Plug 'puremourning/vimspector'                          " Visual debugger

Plug 'vim-airline/vim-airline'                          " Statusline/tabline
Plug 'vim-airline/vim-airline-themes'                   " Statusline themes

Plug 'scrooloose/nerdcommenter'                         " Comment functions

Plug 'kien/rainbow_parentheses.vim'                     " Rainbow parentheses
Plug 'jiangmiao/auto-pairs'                             " Auto pairing for parentheses, quotes, etc.
Plug 'tpope/vim-surround'                               " Surrond editting

Plug 'mg979/vim-visual-multi'                           " Multiple cursors

Plug 'godlygeek/tabular'                                " Tabular formatting

Plug 'bronson/vim-trailing-whitespace'                  " Clean trailing whitespaces

Plug 'valloric/youcompleteme'                           " Code completion

Plug 'ryanoasis/vim-devicons'                           " Dev icons

Plug 'vim-scripts/LargeFile'                            " Large file support

Plug 'rust-lang/rust.vim'                               " Rust language support
Plug 'eagletmt/neco-ghc'                                " Haskell language support

" Initialize plugin system
call plug#end()

colorscheme jellybeans " Use jellybean color scheme

" Enable filesystem side bar
autocmd vimenter * NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd vimenter * Tagbar " Enable tagbar

autocmd BufWritePre * FixWhitespace " Fix whitescapes on buffer write
autocmd BufWritePost * GitGutter    " Update git hunk changes on buffer write

" Enable rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:LargeFile=200 " Large file size (in MB)

"
" Airline
"
let g:airline#extensions#tabline#enabled = 1                        " Enable airline
let g:airline_powerline_fonts = 1                                   " Use powerline fonts
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " Better file names
"let g:airline#extensions#tabline#left_sep = ' '                     " Straight buffer tabs
"let g:airline#extensions#tabline#left_alt_sep = '|'                 " Straight buffer tabs

"
" Comments
"
let g:NERDSpaceDelims = 1               " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1           " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'         " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1         " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1    " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1       " Enable NERDCommenterToggle to check all selected lines is commented or not

"
" Syntastic
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"
" Ale
"
let g:ale_sign_error = '✗✗'
let g:ale_sign_warning = '⚠⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"
" Rust
"
let g:rustfmt_autosave = 1 " Rust formatting on buffer write

" GitGutter status line
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"
" Commands
"
nnoremap ; :
nnoremap : ;

" Fix page up/down
noremap <silent> <PageUp> 1000<C-U>
noremap <silent> <PageDown> 1000<C-D>
inoremap <silent> <PageUp> <C-O>1000<C-U>
inoremap <silent> <PageDown> <C-O>1000<C-D>

" Force saving files that require root permission
cnoremap w!! w !sudo tee % > /dev/null

" Easy swap between buffers
nnoremap <leader>a :bp<cr>
nnoremap <leader>s :bn<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>x :x<cr>
nnoremap <leader>q :cq<cr>

" Line numbers
nnoremap <silent> <leader>l :set relativenumber!<cr>

" Clear highlighting
nnoremap <silent> <leader>/ :nohlsearch<cr>

" Tabularize
vnoremap <silent> <leader>t :Tab /

" Code navigation
nnoremap <leader>cg :YcmCompleter GoTo<cr>
nnoremap <leader>ci :YcmCompleter GoToImplementation<cr>
nnoremap <leader>cr :YcmCompleter GoToReferences<cr>
nnoremap <leader>cd :YcmCompleter GetDoc<cr>
nnoremap <leader>cx :YcmCompleter FixIt<cr>
nnoremap <leader>cr :YcmCompleter RefactorRename<cr>
nnoremap <leader>cf :YcmCompleter Format<cr>

" Ale
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>lr :lrewind<CR>

" Git mappings
nnoremap <leader>z :GitGutterUndoHunk<cr>
nnoremap <leader>[ :GitGutterPrevHunk<cr>
nnoremap <leader>] :GitGutterNextHunk<cr>
nnoremap <leader># :GitGutterFold<cr>

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector
nnoremap <leader>dd :call vimspector#Launch()<cr>
nnoremap <leader>dx :VimspectorReset<cr>
nnoremap <leader>de :VimspectorEval
nnoremap <leader>dw :VimspectorWatch
nnoremap <leader>do :VimspectorShowOutput

" Side-bars
nnoremap <leader>` :NERDTreeToggle<cr> :TagbarToggle<cr>

" Searching
nnoremap <leader>ff :FZF<cr>
nnoremap <leader>fp :CtrlP<cr>