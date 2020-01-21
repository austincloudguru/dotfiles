"# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
"#*********************************************************************#

set t_Co=256
set background=light
colorscheme PaperColor

set nobackup
set noswapfile
if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

" tabs and indenting
set expandtab
set tabstop=2
set shiftwidth=2

set noerrorbells
set visualbell
set hlsearch
set showmatch
