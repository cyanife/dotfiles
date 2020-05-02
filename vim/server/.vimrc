" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
"    Title: Cyanife's vimrc for server
"    Author: Cyanife
"    Version: 0.2
"    Email: Cyanife@gmail.com
"    Last_modify: 2016-02-25
"    Sections:
"        -> Environment 运行环境
"        -> General 通用
"        -> Vim UI 界面
"        -> Formatting 格式
"        -> Key (re)mapping 热键
"
"   Based on spf13-vim(http://spf13.com) , many thanks to Steve Francia!
" }

" Environment {
    " 基础设置
    " Basics {
        set nocompatible        " Must be first line
        set shell=/bin/sh
        " encoding
        set encoding=utf-8
        set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
        set termencoding=utf-8
        set formatoptions+=m
        set formatoptions+=B

    " }
" }

" General {

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    scriptencoding utf-8


    " Automatically switch to the current file directory when
    " a new buffer is opened
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess=atI                   " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                           " Spell checking on
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    set writebackup                  " Backups are nice ...
    " base
    set autoread                    " reload files when changed on disk, i.e. via `git checkout`

    set magic                       " For regular expressions turn magic on
    set title                       " change the terminal's title

    set novisualbell                " turn off visual bell
    set noerrorbells                " don't beep
    set visualbell t_vb=            " turn off error beep/flash
    set t_vb=

" }

" Vim UI {

    if (has("termguicolors"))
          set termguicolors         " 24bit true color support
    endif

    set background=dark             " Assume a dark background
    colorscheme desert

    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line
    "set cursorcolumn

    " set mark column color
    hi! link SignColumn   LineNr
    hi! link ShowMarksHLl DiffAdd
    hi! link ShowMarksHLu DiffChange

    set ruler                   " Show the ruler
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode

    set laststatus=2
    set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P

    set cmdheight=2
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set matchtime=2                 " tenths of a second to show the matching parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore=*.o,*~,*.pyc,*.class
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

    " select & complete
    set selection=inclusive
    set selectmode=mouse,key
    set completeopt=longest,menu

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set smartindent                 " Automatically fit indent level
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set shiftround
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set ffs=unix,dos,mac            " Use unix line feeds format first(<NL>)

    autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
    autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
    autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

    autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
    function! AutoSetFileHead()
        " .sh
        if &filetype == 'sh'
            call setline(1, "\#!/bin/bash")
        endif

        " python
        if &filetype == 'python'
            call setline(1, "\#!/usr/bin/env python")
            call append(1, "\# encoding: utf-8")
        endif

        normal G
        normal o
        normal o
    endfunc

    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    fun! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun

" }

" Key (re)Mappings {

    " Use ',' as the leader key.
    let mapleader = ','
    let g:mapleader = ','
    let maplocalleader = '_'

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Use spacebar open/off fold.
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


    " select all
    map <Leader>sa ggVG"

    "Keep search pattern at the center of the screen."
    nnoremap <silent> n nzz
    nnoremap <silent> N Nzz
    nnoremap <silent> * *zz
    nnoremap <silent> # #zz
    nnoremap <silent> g* g*zz

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Change search highlighting status(ON/OFF)
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Locate git's merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

  " command mode, ctrl-a to head， ctrl-e to tail
    cnoremap <C-j> <t_kd>
    cnoremap <C-k> <t_ku>
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>

" }
