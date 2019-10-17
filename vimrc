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
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Rip-Rip/clang_complete'
Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
Plugin 'benmills/vimux'
Plugin 'c0nk/vim-gn'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'garbas/vim-snipmate'
Plugin 'godlygeek/tabular'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'honza/vim-snippets'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/vim-scripts/google.vim.git'
Plugin 'janko-m/vim-test'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'leafgarland/typescript-vim'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'pangloss/vim-javascript'
Plugin 'pitluga/vimux-nose-test'
Plugin 'plasticboy/vim-markdown'
Plugin 'posva/vim-vue'
Plugin 'psf/black'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomlion/vim-solidity'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-surround'
Plugin 'udalov/kotlin-vim'
Plugin 'w0rp/ale'

"...All your other bundles...
if iCanHazVundle == 0
  echo "Installing Vundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

call vundle#end()


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/dart_language_server'
Plug 'natebosch/vim-lsc'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

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
set number relativenumber

map N Nzz " move search result to mid screen
map n nzz
map r :redraw!<CR>

" tab navigation
set showtabline=2 " always show tab line
map <S-t> :tabnew<CR> :Explore<CR>
map <tab> :tabnext<CR>
map <S-tab> :tabprevious<CR>
map <S-w> :tabclose<CR>
map <S-e> :Explore<CR>

" line wraps
set textwidth=100
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
"set wildignore=*.pyc,*.o,*.out,*.png
"nnoremap <leader>t :CtrlP<CR>
"let g:ctrlp_map = '<leader>t'
"let g:ctrlp_working_path_mode = 0

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

map <C-n> :lnext<CR>
map <C-p> :lprevious<CR>

" javascript
"let g:tern_show_argument_hints='on_hold'
"let g:tern_show_argument_hints='no'
let g:javascript_plugin_flow = 1

" glaive setup
call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"
Glaive codefmt clang_format_style="google"

" autoformat
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer clang-format
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType typescript AutoFormatBuffer clang-format
augroup END

" autocmds
autocmd FileType c,cpp,js,python set ts=2
autocmd FileType c,cpp,js,python set shiftwidth=2
autocmd FileType c,cpp,js,python set softtabstop=2
autocmd FileType c,cpp,js,python set tabstop=2
autocmd FileType c,cpp,js,python set expandtab

" NERD Commenter
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1 " Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting

" NERD customize keymapping
map <Leader>c<space> <plug>NERDComToggleComment
map <Leader>cc <plug>NERDComComment

" clang complete
let s:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
if isdirectory(s:clang_library_path)
  let g:clang_library_path=s:clang_library_path
endif

" ag settings
let g:ag_highlight=1
let g:ag_working_path_mode='r'

set completeopt-=preview

" change CWD when the NERDtree is first loaded to the directory initialized in
" (e.g. change CWD to the directory hitted by CtrlPZ)
"let g:NERDTreeChDirMode = 1
"let NERDTreeIgnore = ['\.pyc$']

" <Leader>N toggles NERDTree (across tab)
"map <F9> :NERDTreeToggle<CR>

" c/c++
au FileType cpp nmap <leader>d :YcmCompleter GoTo<CR>

" golang
au FileType go nmap <leader>d :GoDef<CR>
au FileType go nmap <leader>b :GoBuild<CR>
au FileType go nmap <leader>t :GoTest<CR>

" golang gofmt and go build
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'test']

" python
au FileType python nmap <Leader>t :TestNearest<CR>

" dart
let dart_corelib_highlight=v:false
let dart_format_on_save = 1
let dart_html_in_string=v:true
let dart_style_guide = 2

" language server client
let lsc_enable_autocomplete = v:false
let lsc_server_commands = {'dart': 'dart_language_server'}

" vim-test
let test#go#runner = 'gotest'
let test#python#runner = 'nose'

" You Complete Me
let g:ycm_confirm_extra_conf = 0

" Asynchronous Lint Engine
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_fix_on_text_changed = 0
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'vue': ['prettier', 'eslint']}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_linter_aliases = {'vue': ['vue', 'javascript', 'css']}
let g:ale_linters = {'vue': ['eslint', 'vls', 'csslint', 'stylelint'], 'javascript': ['eslint']}
let g:ale_vls_use_global = 1

" Language Server Client
let g:lsc_enable_autocomplete = v:false

"must be last
filetype plugin indent on " load filetype plugins/indent settings

