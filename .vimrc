" .vimrc
"
" HINT: Type zR/zM/zo/zc if you don't know how to use folds
"let g:vimsyn_noerror = 1

" {{{ general setting
set nocompatible "Get out of VI's compatible mode..
silent! call pathogen#infect()
set history=300  " Number of things to remember in history.
"filetype plugin on "Enable filetype plugin

set shortmess+=I

set cf  " Enable error files & error jumping.
set autowrite  " Writes on make/shell commands
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
"set clipboard+=unnamed  " Yanks go on clipboard instead.

" Highlight search terms...
set hlsearch
set incsearch
set smartcase

" be careful: tabs may look different on other systems
" width of a tab character in spaces
set tabstop=4
" defines number of spaces for when adding/remving tabs
set softtabstop=4
" number of spaces to use for autoindent
set shiftwidth=4
set textwidth=78
set wrap
set linebreak
set noexpandtab
set autoindent

" recognize lines as you can see at the bottom
set modeline
set modelines=3

set laststatus=2
set cmdheight=2
" show the command being typed
set showcmd
set title

set scrolloff=2

if has("statusline")
    set statusline=\ %F%m%r%h\ [%Y]\ [%{&ff}]\ %w\ \ \ \ \ Encoding:\ %{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\"[BOM]\":\"\")}\ \ \ \ \ Line:\ %l\|%L:%c\ [%p%%-%P]
endif

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim_backup " Where backup will go.
set directory=~/.vim_tmp     " Where temporary files will go.

" recognize  files
"set textauto

" always show current position
set ruler
" display also the hexcode of the char under the cursor
set rulerformat=0x%02B\ %3p%%\ %l,%c%V

if has('mouse')
    set mouse-=a
endif

"Set mapleader
"let mapleader = ","
"let mapleader = "\ "
"let g:mapleader = ","
"nnoremap <Leader>a :echo "Hey there ,"<CR>

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

" Files to ignore
set wildignore=*.o,*.lo,*.la,#*#,.*.rej,*.rej,.*~,*~,.#*,*.class
set tag+=/usr/include/tags
" }}}
" {{{ color setting
if &t_Co > 2 || has("gui_running")
    " ...then use highlighting
    syntax on "Enable syntax hl
endif

if $TERM =~ '^xterm' || $TERM =~ '^screen'
    set t_Co=256
    " xterm backspace settings
    "set t_kb=
    "fixdel
else
    "colorscheme tango
endif

"try
"    colorscheme DevC++
"catch
"    silent! colorscheme tango
"endtry


"if has("gui_running")
"    colorscheme inkpot
"else
"    colorscheme dark-ruby
"end

"hi StatusLine ctermfg=black ctermbg=white

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

"map <silent><F3> :NEXTCOLOR<cr>
"map <silent><F2> :PREVCOLOR<cr>

if exists('+colorcolumn')
"    set cc=+1,+2,+3
else
    " Emulate
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif
" }}}
" {{{ encoding settings
" 配置多语言环境
if has("multi_byte")
    " Set fileencoding priority
    if getfsize(expand("%")) > 0
        set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    else
        set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    endif

    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

if has('multi_byte') && v:version > 601
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
" }}}
" {{{ map: date,dict
"My information
iab xdate <C-R>=strftime("%Y-%m-%d %T %Z")<cr>
iab xname Percy Lau
iab logdate <C-R>=strftime("%Y-%m-%d  Percy Lau <percy.lau@gmail.com>")<CR>

"let g:winManagerWindowLayout = "FileExplorer" 
"nmap <C-\> :!clear;dict.py <C-R>=expand("<cword>")<CR><CR>

"command! Q  quit
"command! W  write
"command! Wq wq
"command! WQ wq

" \tt insert date
nmap <Leader>tt :execute "normal i" . strftime("%Y-%m-%d")<Esc>
"nmap <Leader>tt :execute "normal i" . strftime("%Y-%m-%d-%H-%M")<Esc>
"nmap <Leader>tt :execute "normal i" . strftime("%a, %d %b %Y %H:%M:%S %Z")<Esc>

nnoremap <Leader>u :setlocal nobomb<Return>:setlocal fileencoding=utf-8<Return>

nmap <F8> :TagbarToggle<CR>         " mapping f8 to TagbarToggle
nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
" }}}

"autocmd vimenter * if argc() | NERDTree | endif
" vim:ft=vim:fdm=marker:
