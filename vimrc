syntax on

" vi 호환성 버리기
set nocompatible
" pathogen 을 이용해 다른 플러그인들을 로드한다
filetype off
call pathogen#helptags()

"call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" 탭 세팅
"set softtabstop=2

" set color scheme
colorscheme busybee


" 검색 설정
set ignorecase " 대소문자 무시하지만..
set smartcase " 검색어에 대소문자 섞여 있는 경우엔 존중해드림
set incsearch
set showmatch
set hlsearch " 검색 결과를 하이라이트한다.
map N Nzz " 검색 결과를 화면 가운데로!
map n nzz

" 탭 내비게이션
set showtabline=2 " 탭 언제나 보여주기
map <C-t> :tabnew<CR>
map <tab> :tabnext<CR>
map <S-tab> :tabprevious<CR>
map <C-w> :tabclose<CR>
map <C-a> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-n> :tnext<CR>
map <C-p> :tprevious<CR>

" 라인 랩 관련 설정
"set wrap
"set textwidth=0 " 니맘대로 줄바꿈하지마 ㄱㅅㄲ야

" 인덴트.
set autoindent
set smartindent
set cindent
set pastetoggle=<F8>

" 포커스를 잃으면 자동 세이브
"au FocusLost * :wa
" 필요없는 공백을 하이라이트
"set list
"
set listchars=tab:»·,trail:·,extends:#,nbsp:·
" 파일 인코딩은 언제나 utf-8. 안되면 cp949 시도
set encoding=utf8
set fileencodings=utf8
set laststatus=2 " 상태라인 항상 보여주세요
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
set scrolljump=1 " 스크롤은 1줄씩만
set scrolloff=3 " 3줄 남기고 스크롤 설정
set visualbell " 비주얼 벨 써야지여
set cursorline " 커서 위치 보여주세요
set ttyfast " 느리지 않아요 로컬이에요
set ruler " 커서 위치 보여주세요
set backspace=indent,eol,start " 백스페이스 설정
set mouse=an " 마우스 지원
set autochdir " 파일 열면 해당 디렉토리로 chdir. cmd-t 랑 잘 안맞는당
set showmode " 현재 상태 (insert/visualize) 표시.. 이거 디폴트로 안켜있나?
set showcmd " 현재 명령어 (ex 모드) 표시
set hidden " 버퍼가 안보이게 되면 변경 내용 버리기.
set wildmenu " 자동완성시 리스트를 보여준다
set wildmode=list:longest,full
"set whichwrap=b,s,h,l,<,>,[,] " 줄 끝에서 다음 줄로 넘어가기 위해 사용할 수 있는 키들
set lazyredraw " 매크로 수행중 다시 그리기 없기
set history=1000 " 기억 많이 하면 좋지
set undolevels=1000 " 이것도 많이 기억하도록

" 난 , 리더키로 쓰는거 정말 싫음. 나만 그런가. -_-;
let mapleader = "\\"

" 폴드
" ====
"set foldmethod=syntax " 문법 기반 폴딩
"set foldlevel=999 " 처음엔 폴드하지마요

" 탭으로 matching brackets 사이를 오가기
"vnoremap <tab> %
nnoremap j gj
nnoremap k gk
" : 대신 ; 를 치자
nnoremap ; :
" 줄끝까지 복사
nnoremap Y y$
" visual mode 내에서 시프트해도 나가지 않기 (!)
vnoremap < <gv
vnoremap > >gv
" F2 로 라인 넘버 토글
nnoremap <F2> :set relativenumber!<CR>

" autocmds
" ========
" trailing space를 highlight해준다.
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

" 플러그인 커맨드들
" =================

" Command-T: 다음 파일들은 무시해주세요
set wildignore=*.o,*.out,*.png

" Ack
"let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"nnoremap <leader>a :Ack

" Yankring
"nnoremap <silent> <F3> :YRShow<cr>
"inoremap <silent> <F3> <ESC>:YRShow<cr>
"let g:yankring_history_dir='~/.vim'

" 키보드 매핑
" ===========
set tabstop=2
set shiftwidth=2
set expandtab

"highlight RedundantWhitespace ctermbg=yellow guibg=yellow
"match RedundantWhitespace /\s\+\%#\@<!$/| \+\ze\t/
"match RedundantWhitespace /\s\+\%#\@<!$/

" pathogen
execute pathogen#infect()

" thrift
au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/syntax/thrift.vim

" action script
au Bufread,BufNewFile *.as set filetype=actionscript
au! Syntax thrift source ~/.vim/syntax/actionscript.vim

" go
"au BufEnter,BufRead *.go call HighrightTabs()

"set convert-meta off
"set meta-flag on
"set output-meta on

"tags
set tags=./tags;/

" Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'davidhalter/jedi-vim'

" gyp bundle
Bundle 'kelan/gyp.vim'
