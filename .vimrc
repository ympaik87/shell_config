scripte utf-8

" 오리지널 Vi 와의 호환성을 없애고, Vim 만의 기능들을 쓸 수 있게 함.
set nocp

" 모든 옵션을 원래대로 복원
set all&

" 명령어 기록을 남길 갯수 지정
set hi=100

" 백스페이스 사용
set bs=indent,eol,start

" 인코딩 설정
" 문서를 읽을 때 BOM 을 자동으로 제거하려면, fencs 맨 앞에 ucs-bom 를 추가하세요.
"let &tenc=&enc
"set enc=utf-8
set fenc=utf-8
set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,latin1,ucs-2le

" 커서의 위치를 항상 보이게 함.
set ru

" 완성중인 명령을 표시
set sc

" 줄 번호 표시
"set nu

" 줄 번호 표시 너비 설정
"set nuw=5

" 탭 크기 설정
set ts=8
set sw=4

" 탭 -> 공백 변환 기능 (사용 안함)
"set noet
set sts=4

" 마지막 편집 위치 복원 기능
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "norm g`\"" |
\ endif

" gVim 을 사용중일 경우 클립보드를 unnamed 레지스터로 매핑
" xterm_clipboard 기능이 있을 때에도 매핑 가능
if has("gui_running") || has("xterm_clipboard")
	set cb=unnamed
endif

" magic 기능 사용
set magic

" 여러 가지 이동 동작시 줄의 시작으로 자동 이동
set sol

" 비주얼 모드에서의 동작 설정
set sel=exclusive

" SHIFT 키로 선택 영역을 만드는 것을 허용
" 영역 상태에서 Ctrl+F,B 로 이동하면 영역이 해제되어 버려서 해제
"set km=startsel,stopsel

" 가운데 마우스 버튼으로 붙여넣기 하는 것을 무효화한다.
map <MiddleMouse> <Nop>
map! <MiddleMouse> <Nop>

" 괄호짝 찾기 기능에 사용자 괄호 종류를 더한다.
set mps+=<:>

" 새로 추가된 괄호의 짝을 보여주는 기능
"set sm

" Insert 키로 paste 상태와 nopaste 상태를 전환한다.
" 함수 방식으로 바꾸었다. 자세한 것은 아래로~
"set pt=<Ins>

" 키 입력 대기시간을 무제한으로, 그러나 key codes 에 대해서는 예외
set noto ttimeout

" 키 입력 대기시간 설정 (milliseconds) (ttm 을 음수로 설정하면 tm 을 따라감)
set tm=3000 ttm=100

" 영역이 지정된 상태에서 Tab 과 Shift-Tab 으로 들여쓰기/내어쓰기를 할 수 있도록 함.
vmap <Tab> >gv
vmap <S-Tab> <gv

" 입력이 중단된 후 얼마 후에 swap 파일을 쓸 것인지와
" CursorHold 이벤트의 대기시간을 설정 (milliseconds)
set ut=10

" 몇 글자를 입력받으면 swap 파일을 쓸 것인지 설정
set uc=200


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 모양 설정
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" GUI 이면, 시작시 크기 설정
if has("gui_running")
	set lines=40
	set co=85
endif

" 시작시 전체화면으로 설정
" 이제 이것도 귀찮아졌다...!
if has("win32")
"	au GUIEnter * simalt ~x
endif

" 추적 수준을 최대로
set report=0

" 항상 status 라인을 표시하도록 함.
set ls=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI 설정
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 폰트 설정
if has("gui_running")
	if has("win32")
		set gfn=굴림체:h9:cHANGEUL
"		set gfn=GulimChe:h9:cHANGEUL
	else
		set gfn=GulimChe\ 9
	endif
"	set gfn=Jung9\ 9
"	set gfn=Fixedsys:h12:cHANGEUL
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype 기능 & Syntax Highlighting 기능
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 파일의 종류를 자동으로 인식
filet plugin indent on

" 몇몇 커스텀 확장자들에게 파일 형식 설정
"au BufRead,BufNewFile *.dic setl ft=php

" 파일 형식에 따른 Syntax Highlighting 기능을 켠다
sy enable


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent 설정
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 자동 들여쓰기 사용 안함
set noai

" 똑똑한 들여쓰기 사용 안함
set nosi

" 내장된 indent 파일이 없어서 C indent 를 사용하는 경우
au FileType javascript,jsp setl cin

" 각 언어의 표준 indent 를 사용하는 경우
" 수동 추가하기가 귀찮아져서 결국 자동 인식으로 바꿨다.
"au FileType c,cpp,html,vim,java,sh,python,xml,perl,xf86conf,conf,apache
"\ if expand("<amatch>") != "" |
"\   if exists("b:did_indent") |
"\		unlet b:did_indent |
"\   endif |
"\ runtime! indent/<amatch>.vim |
"\ endif

" 상용구 설정
iab xdate <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
iab xtime <C-R>=strftime("%H:%M:%S")<CR>
"iab xname 인클루드

" BufExplorer 플러그인 (스크립트 번호: 42)
" :ls 와 :b 에 익숙해져서 이젠 필요없다...
"nnoremap <silent> <F5> :BufExplorer<CR>

" Vim 자체 Explore 기능
" :E 라는 게 있었군...
"nnoremap <silent> <F6> :Explore<CR>

" Vim 정규식이 아닌 진짜 정규식 사용을 의무화(?)
" \v 라는 글자가 항상 표시되니까 햇갈린다... -.-
"map / /\v

" Tab 자동 완성시 가능한 목록을 보여줌
set wmnu

" 파일 탐색기 설정
let g:explVertical=1
let g:explSplitRight=1
let g:explStartRight=1
let g:explWinSize=20

" Spell Checking 기능 (영어)
" 기본적으로는 비활성화
"set nospell spelllang=en

" 각종 toggle 기능
fu! ToggleNu()
	let &nu = 1 - &nu
endf
fu! ToggleList()
	let &list = 1 - &list
endf
fu! TogglePaste()
	let &paste = 1 - &paste
endf
fu! ToggleSpell()
	let &l:spell = 1 - &l:spell
endf
map \n :call ToggleNu()<CR>
map \l :call ToggleList()<CR>
map \p :call TogglePaste()<CR>
map \s :call ToggleSpell()<CR>


" 매크로 실행중에 화면을 다시 그리지 않음
set lz

" 프로그램 시작시 플러그인 로드
set lpl

"noeol 설정
"au BufNew * set bin | set noeol
"set bin | set noeol

" ㅂㅌ barosl 은 모든 플랫폼에서 unix 줄 변경자를 쓰겠습니다! ..orz
" 경고: 만일 당신의 vim 이 '정상적으로' 동작하길 원하시면,
" 바로 다음줄은 주석처리 하거나 없애세요. -.-;;
set ff=unix

" unix dos mac 줄 변경자 모두 다 읽을 수 있도록 합니다.
set ffs=unix,dos,mac


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End of File
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nohls
colorscheme desert
"set cursorcolumn
set cursorline

nmap <F5> :wa <CR>:!python %<CR>
nmap <S-tab> zi
"set foldmethod=indent
set tabstop=8 sw=4 softtabstop=4 smarttab expandtab
set showmatch hidden incsearch ignorecase smartcase smartindent hlsearch
set pastetoggle=<Ins>
augroup filetypedetect
    au BufNewFile,BufRead *.moin setf moin
    au BufNewFile,BufRead *.wiki setf moin
augroup END

nmap <F6> :wa <CR>:!perl %<CR>

set fileencodings=utf-8,euc-kr

if v:lang =~ "^ko"
  set encoding=cp949
  set fileencodings=utf-8,cp949
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~ "^ja_JP"
  set fileencodings=euc-jp
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~ "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~ "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set encoding=utf-8
  set fileencodings=utf-8,cp949
endif
