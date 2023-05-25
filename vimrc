"
" 2023 copyright snibug@gmail.com
"

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax highlighting and indentation
Plug 'clangd/coc-clangd'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/indentpython.vim'


" File explorer
Plug 'scrooloose/nerdtree'

" File commant
Plug 'preservim/nerdcommenter'


" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
Plug 'morhetz/gruvbox'

" Github Copilot
Plug 'github/copilot.vim'

" close-open pair
Plug 'Raimondi/delimitMate'

call plug#end()

" General settings
set shiftwidth=2 " indentation width
set tabstop=2 " tab width

set autoindent " auto-indent new lines
set smartindent " smart auto-indent

set expandtab " use spaces instead of tabs
set number " show line numbers

" Hightlight
set cursorline " highlight current line
set hlsearch " Highlight search results
set ignorecase " Ignore case
set smartcase " Ignore case if search query is all lowercase
set incsearch " Show search results as you type

" Theme settings
colorscheme busybee
set background=dark

" highlite a trailing space
highlight TrailingWhitespace ctermbg=red guibg=red
autocmd BufEnter,WinEnter,FileType * match TrailingWhitespace /\s\+\%#\@<!$/

" highright tab space
highlight TabWhitespace ctermbg=red guibg=red
match TabWhitespace /\t/


" Auto-close brackets settings
let g:AutoPairsFlyMode = 1

" coc-settings
let g:coc_global_extensions = [
\ 'coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-go',
\ 'coc-eslint', 'coc-prettier', 'coc-snippets', 'coc-syntax']

" Automatically run Coc diagnostics on cursor hold and on InsertLeave
nnoremap <Leader>d :CocList diagnostics<CR>
nnoremap <Leader>n :CocNext<CR>
nnoremap <Leader>p :CocPrev<CR>


" Python Setting
"
autocmd FileType python let b:coc_root_patterns = ['.git', '.direnv']

" Format on save
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.html,*.css,*.scss,*.md,*.py,*.go,*.c,*.cpp call CocAction('runCommand', 'editor.action.formatDocument')

" Set up code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Set up code completion
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Set up linting
"autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.json,*.html,*.css,*.scss,*.md,*.py,*.go,*.c,*.cpp CocCommand eslint.executeAutofix


" Enable NERDTree on startup
"
autocmd vimenter * NERDTree

" Set nerd tree
"
function! CloseNERDTreeOnQuit()
  " NERDTree가 열려 있는지 확인
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    NERDTreeClose
  endif
endfunction

function! ToggleNERDTree()
  " NERDTree가 이미 열려 있는지 확인
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    " NERDTree가 열려 있다면 focus를 옮기기
    wincmd p
  else
    " NERDTree가 닫혀 있다면 열기
    NERDTree
  endif
endfunction

nnoremap <S-e> :call ToggleNERDTree()<CR>
nnoremap <S-t> :tabedit<CR>

autocmd VimEnter * NERDTree | wincmd p
autocmd QuitPre * call CloseNERDTreeOnQuit()

nnoremap <S-w> :NERDTreeToggle<CR>

" Set nerd comment
"
map <leader>c<space> <plug>NERDComComment

" Set Tab
map <tab> :tabnext<CR>
map <S-tab> :tabprevious<CR>

" Set backspace
set backspace=indent,eol,start

" Copilot settings
"
noremap <silent> <C-p> :Copilot<CR>

let g:copilot_keymap = {
 \ 'complete': '<C-x><C-o>',
 \ 'commit': '<C-c>'
 \}


" Javascript settings
"
autocmd FileType javascript call JsHighlightSelf()
function! JsHighlightSelf()
  if !hlexists("jsSelf")
    syn match jsSelf "\<self\>"
    hi link jsSelf jsGlobalObjects
  endif
endfunction

" c++settings
"
function! Formatonsave()
  let l:pos = getpos(".")
  let l:winview = winsaveview()
  let l:formatdiff = &formatprg
  let &formatprg = 'clang-format'
  normal! gggqG
  let &formatprg = l:formatdiff
  call setpos('.', l:pos)
  call winrestview(l:winview)
endfunction

autocmd BufWritePre *.cpp,*.hpp,*.cc,*.h call Formatonsave()
