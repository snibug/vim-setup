filetype off                  " required
set nocompatible

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Add your bundles here
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
Plugin 'c0nk/vim-gn'
Plugin 'davidhalter/jedi-vim' " jedi
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/vim-scripts/google.vim.git'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'marijnh/tern_for_vim'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'tomlion/vim-solidity'
Plugin 'tpope/vim-surround'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'Vimjas/vim-python-pep8-indent'

"...All your other bundles...
if iCanHazVundle == 0
  echo "Installing Vundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

call vundle#end()

" setting start
syntax on
colorscheme busybee
hi Visual term=reverse ctermbg=8 guibg=LightGrey

" tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" search settings
set ignorecase
set smartcase " do not ignore case when query is mixed case
set incsearch
set showmatch
set hlsearch " highlight search
set nowrap

map N Nzz " move search result to mid screen
map n nzz
map r :redraw!<CR>

" tab navigation
set showtabline=2 " always show tab line
map <C-t> :tabnew<CR> :Explore<CR>
map <tab> :tabnext<CR>
map <S-tab> :tabprevious<CR>
map <C-w> :tabclose<CR>
map <C-e> :Explore<CR>

" line wraps
set wrap
set textwidth=0
set autoindent
set pastetoggle=<F8>
" save when focus is lost
au FocusLost * :wa
set encoding=utf8
set fileencodings=utf8

set laststatus=2 " always show status line
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ %{fugitive#statusline()}\ [%l,%v][%p%%]
set scrolljump=1 " 1 line scrolls
set scrolloff=3 " start scrolling with 3 lines remaining on screen
set visualbell
set cursorline " show cursor line
set ttyfast "
set ruler " show cursor location
set backspace=indent,eol,start " fix backspace
set mouse=r " use mouse
set showmode "
set showcmd "
set hidden "
set wildmenu " autocomplete
set wildmode=list:longest,full
set whichwrap=b,s,h,l
set lazyredraw " do not redraw while running macros
set history=1000 "
set undolevels=1000 "

let mapleader = "\\"

set foldmethod=syntax
set foldlevel=999 " do not fold at first

" keyboard maps
" ===========

nnoremap j gj
nnoremap k gk
" type ; instead of :
nnoremap ; :
" copy to EOL
nnoremap Y y$
" shift in visual mode
vnoremap < <gv
vnoremap > >gv

" leader commands
" =============

" reindent whole file
nmap <silent> <leader><tab> mzgg=G`z
" get rid of search highlights
nmap <silent> <leader><space> :nohlsearch<cr>
" get rid of trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" source this vimrc
nnoremap <leader>sv :so $MYVIMRC<CR>
" select last pasted
nnoremap <leader>v V`]
" vertical split
nnoremap <leader>w <C-w>v<C-w>l
" horizontal split
nnoremap <leader>e <C-w>s<C-w>j
" close split
nnoremap <leader>q <C-w>q
" move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-l> <C-w>l
nnoremap <leader>= <C-w>=

" open in current directory..
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

" open explore tab when open a empty file
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Explore | endif

" plugin commands
" =================

" CtrlP
set wildignore=*.pyc,*.o,*.out,*.png
nnoremap <leader>t :CtrlP<CR>
let g:ctrlp_map = '<leader>t'
let g:ctrlp_working_path_mode = 0

" Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column --nojs"
nnoremap <leader>a :Ack
nnoremap <leader>A :Ack <C-R><C-W><CR>

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
let g:yankring_history_dir='~/.vim'

" bufexplorer
map <leader>o :BufExplorer<CR>

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>

nnoremap <F2> :call ToggleMouse()<CR>
nnoremap <F3> :set wrap!<CR>
function! ToggleMouse()
  if &mouse == 'a'
	set nonu
    set mouse=
    echo "Mouse usage disabled"
  else
	set nu
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

silent !stty -ixon > /dev/null 2> /dev/null
nnoremap <C-q> :qa<CR>

let g:gitgutter_enabled = 0
nnoremap <leader>gg :GitGutterToggle<CR>

" highlite a trailing space
highlight ExtraWhitespace ctermbg=yellow guibg=yellow

augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END

function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

" highright tab space
function! HighrightTabs()
  syntax match TAB /\t/
  hi TAB ctermbg=red ctermfg=red
endfunction

function! CancelHighrightTabs()
  syntax match TAB /\t/
  hi TAB ctermbg=234 ctermfg=234
endfunction

au BufEnter,BufRead * call HighrightTabs()
au BufEnter,BufRead *.go call CancelHighrightTabs()

" support jsx on js file
let g:jsx_ext_required = 0

" YouCompleteMe options
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0
let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_echo_current_diagnostic = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_error_symbol = '>>'
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_goto_buffer_command = 'new-tab'
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_previous_completion = ['', '']
let g:ycm_key_list_select_completion = ['', '']
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1
let g:ycm_path_to_python_interpreter = '' "default ''
let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:ycm_server_log_level = 'info' "default info
let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_show_diagnostics_ui = 1
let g:ycm_warning_symbol = '>*'
set completeopt-=preview

highlight YcmErrorSign guibg=#3f0000
highlight YcmErrorLine guibg=#3f0000
map <C-n> :lnext<CR>
map <C-p> :lprevious<CR>

" javascript
let g:tern_map_keys=0
"let g:tern_show_argument_hints='on_hold'
let g:tern_show_argument_hints='no'

" c++ options

call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"
Glaive codefmt clang_format_style="google"

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " autocmd FileType python AutoFormatBuffer autopep8
augroup END

"must be last
filetype plugin indent on " load filetype plugins/indent settings


" autocmds
" ========
autocmd FileType c,cpp,js,python set ts=2
autocmd FileType c,cpp,js,python set shiftwidth=2
autocmd FileType c,cpp,js,python set softtabstop=2
autocmd FileType c,cpp,js,python set tabstop=2
autocmd FileType c,cpp,js,python set expandtab

