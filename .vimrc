set nocompatible
set ruler           " Always show current position
set number          " Enable line numbering
set mouse=a
set title

syntax on

set history=700     " Sets how many lines of history VIM has to remember
set autoread        " Set to auto read when a file is changed from the outside

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set listchars=trail:.,tab:>-,eol:$
set splitright      " Default split on right pane

" Searching
set ignorecase      " Ignore case when searching
set smartcase       " When searching try to be smart about cases
set hlsearch        " Highlight search results
set incsearch       " Makes search act like search in modern browsers

set showcmd         " Show (partial) command in status line
set lazyredraw      " Don't redraw while executing macros (good performance config)
set magic           " For regular expressions turn magic on

set showmatch       " Show matching brackets when text indicator is over them
set mat=2           " How many tenths of a second to blink when matching brackets

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=lightgreen guibg=lightgreen
colorscheme elflord
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8       " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac    " Use Unix as the standard file type

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab, indent and folding related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab           " Use spaces instead of tabs
set smarttab            " Be smart when using tabs ;)

" Linebreak on 500 characters
set lbr
set tw=500

set ai                  "Auto indent
set si                  "Smart indent
set wrap                "Wrap lines
set invpaste
set invpaste
set invpaste

" Folding
set foldenable
set foldmarker={,}
set foldmethod=syntax
set foldlevel=100
set foldopen=block,hor,mark,percent,quickfix,tag

set wildmode=longest:full
filetype on             " Enable filetype detection

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding function
let s:fold_comments = 0
function! FoldComments()
  set foldmethod=syntax
  if (s:fold_comments == 0)
    let s:fold_comments = 1
    set foldlevel=0
    echo "Folding syntax"
  else
    let s:fold_comments = 0
    set foldlevel=100
    echo "Unfolding syntax"
  endif
  set foldmethod=manual
endfunction

" Header/Source
" Split the buffer horizontally and load the include file from Include dir
function! OpenHeaderInclude()
  if match(expand("%"),'\.cpp') > 0
    let s:flipname = substitute(expand("%"),'\.cpp\(.*\)','\.hpp\1',"")
    let s:flipname = substitute(expand(s:flipname),'Source\/','Include\/',"")
    exe ":vsplit " . s:flipname
    return
  endif
  if match(expand("%"),'\.hpp') > 0
    let s:flipname = substitute(expand("%"),'\.hpp\(.*\)','\.cpp\1',"")
    let s:flipname = substitute(expand(s:flipname),'Include\/','Source\/',"")
    exe ":vsplit " . s:flipname
    return
  endif
endfun

" Split the buffer horizontally and load the include file from current dir
function! OpenHeader()
  if match(expand("%"),'\.cpp') > 0
    let s:flipname = substitute(expand("%"),'\.cpp\(.*\)','\.hpp\1',"")
    exe ":vsplit " . s:flipname
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remaping keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""map - mapuje wszystkie tryby
"imap - tylko tryb insert
"nmap - tylko tryb normalny
"cmap - tylko tryb command line

" open .hpp file for .cpp
"nmap <S-F12> :call OpenHeader()<CR>
nmap <F10> :call OpenHeaderInclude()<CR>
" Line numbers
nmap <F9> :set number! number?<cr>
" Printing unprintable characters
nmap <F8> :set list! list?<cr>
" Wrapping lines
nmap <F7> :set wrap! wrap?<cr>

" For some reason home and end keys are not mapping properly.
" Home key
imap <esc>OH <esc>0i
cmap <esc>OH <home>
nmap <esc>OH 0
" End key
nmap <esc>OF $
imap <esc>OF <esc>$a
cmap <esc>OF <end>


" TTCN-3 coloring syntax
au BufRead,BufNewFile *.ttcn* set filetype=ttcn
au! Syntax ttcn source /home/ziobron/.vim/syntax/ttcn.vim

highlight ExtraWhitespace ctermbg=lightgreen guibg=lightgreen
match ExtraWhitespace /\s\+$/

