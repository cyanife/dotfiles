" Modeline and Notes -{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker=-{,}- foldlevel=0 foldmethod=marker:
"
"    Author: Cyanife
"    Version: 0.2
"    Email: Cyanife@gmail.com
"    Last_modify: 2016-02-25
"    Sections:
"        -> Environment 运行环境
"        -> Bundles 插件列表
"        -> General 通用
"        -> Vim UI 界面
"        -> Formatting 格式
"        -> Key (re)mapping 热键
"        -> Plugins 插件
"        -> Functions 函数
"        -> Others 其他
"
"   Based on spf13-vim(http://spf13.com) , many thanks to Steve Francia!
" }-

" Environment -{

        "定制插件列表
        "Bundle List Customization
        " list only the plugin groups you will use
        if !exists('g:cyanife_bundle_groups')
            let g:cyanife_bundle_groups=['general', 'writing', 'neocomplete', 'programming', 'python', 'html', 'misc']
            "let g:cyanife_bundle_groups=['general', 'writing', 'programming', 'python', 'html', 'misc']
        endif

    " Options -{

        " Disable wrap relative motion for start/end line motions
        "   let g:cyanife_no_wrapRelMotion = 1

        " Disable fast tab navigation
        "   let g:cyanife_no_fastTabs = 1

        " Disable neosnippet expansion
        " This maps over <C-k> and does some Supertab
        " emulation with snippets
        "   let g:cyanife_no_neosnippet_expand = 1

        " Disable whitespace stripping
        "   let g:cyanife_keep_trailing_whitespace = 1

        " Enable powerline symbols
        "   let g:airline_powerline_fonts = 1

        " This makes the completion popup strictly passive.
        " Keypresses acts normally. <ESC> takes you of insert mode, words don't
        " automatically complete, pressing <CR> inserts a newline, etc. Iff the
        " menu is open, tab will cycle through it. If a snippet is selected, <C-k>
        " expands it and jumps between fields.
        "   let g:cyanife_noninvasive_completion = 1

        " Don't turn conceallevel or concealcursor
        "   let g:cyanife_no_conceal = 1

        " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
        " Indent guides will attempt to set your colors smartly. If you
        " want to control them yourself, do it here.
        "   let g:indent_guides_auto_colors = 0
        "   autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=233
        "   autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=234

        " Leave the default font and size in GVim
        " To set your own font, do it from ~/.vimrc.local
        "   let g:cyanife_no_big_font = 1

        " Disable  omni complete
        "   let g:cyanife_no_omni_complete = 1

        " Don't create default mappings for multicursors
        " See :help multiple-cursors-mappings
        "   let g:multi_cursor_use_default_mapping=0
        "   let g:multi_cursor_next_key='<C-n>'
        "   let g:multi_cursor_prev_key='<C-p>'
        "   let g:multi_cursor_skip_key='<C-x>'
        "   let g:multi_cursor_quit_key='<Esc>'
        " Require a special keypress to enter multiple cursors mode
        "   let g:multi_cursor_start_key='+'

    " }-

    " 平台识别函数
    " Identify platform -{
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }-

    " 基础设置
    " Basics -{
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        else
            set diffexpr=MyDiff() "Use windows diff function
        endif
    " }-

    " Windows 兼容性设置
    " Windows Compatible -{

        if has("multi_byte")
            "Windows Simp-Chinese CMD.exe uses cp936(GBK)
            set termencoding=cp936
            " Let Vim use utf-8 internally, because many scripts require this
            set encoding=utf-8
            setglobal fileencoding=utf-8
            " Windows has traditionally used cp1252, so it's probably wise to
            " fallback into cp1252 instead of eg. iso-8859-15.
            " Newer Windows files might contain utf-8 or utf-16 LE so we might
            " want to try them first.
            set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
            set langmenu=en_US.UTF-8
            language message en_US.UTF-8
        endif
    " }-

" }-

" Bundles -{

    " Vundle初始化
    " Vundle Setup -{
        " Install Vundle first plz.
        " git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
        filetype off
        if LINUX()
            set rtp+=~/.vim/bundle/vundle/
            call vundle#rc()
        elseif WINDOWS()
            set rtp+=$VIM/vimfiles/bundle/vundle/
            call vundle#rc('$VIM/vimfiles/bundle/')
        endif
        Plugin 'gmarik/vundle'
    " }-


    " 基础依赖插件
    " Dependences -{
        "Snipmate deps
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'tomtom/tlib_vim'
        "Ag/Ack/Ack-grep deps
        "Ag/Ack/Ack-grep are text search tools instead of grep
        if executable('ag')
            Plugin 'mileszs/ack.vim'
            let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
        elseif executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
            Plugin 'mileszs/ack.vim'
        elseif executable('ack')
            Plugin 'mileszs/ack.vim'
        endif
        "custom textobj deps
        Plugin 'kana/vim-textobj-user'
    " }-

    " 通用插件
    " General -{
        if count(g:cyanife_bundle_groups, 'general')
            Plugin 'scrooloose/nerdtree'
            Plugin 'altercation/vim-colors-solarized'
            "Plugin 'cyanife/my-fav-vim-colors' "自己的配色方案，repo待建立！
            Plugin 'tpope/vim-surround'                      " 格式化两端（eg加括号
            Plugin 'tpope/vim-repeat'                        " 让.重复插件命令
            Plugin 'rhysd/conflict-marker.vim'               " Github 冲突解决插件
            "Plugin 'jiangmiao/auto-pairs'                    " 括号自动配对
            "Plugin 'spf13/vim-autoclose'                     "括号自动配对
            Plugin 'ctrlpvim/ctrlp.vim'                      " 项目查找
            Plugin 'tacahiroy/ctrlp-funky'
            Plugin 'terryma/vim-multiple-cursors'            " 多重光标
            Plugin 'vim-scripts/sessionman.vim'              " 编辑状态快照管理
            Plugin 'matchit.zip'                             " %跳转插件
            if (has("python") || has("python3"))
                Plugin 'Lokaltog/vim-powerline'
            else
                Plugin 'vim-airline/vim-airline'
                Plugin 'vim-airline/vim-airline-themes'
            endif                                            " 状态栏插件
            Plugin 'powerline/fonts'
            Plugin 'bling/vim-bufferline'                    " buffer切换
            Plugin 'easymotion/vim-easymotion'               " 快速移动插件
            Plugin 'jistr/vim-nerdtree-tabs'                 " 切换tab保持nerdtree
            Plugin 'flazz/vim-colorschemes'                  " 配色方案大全
            Plugin 'mbbill/undotree'                         " undotree窗口
            Plugin 'nathanaelkane/vim-indent-guides'         " 缩进竖直对齐线
            Plugin 'vim-scripts/restore_view.vim'            " 打开文件恢复光标位置
            Plugin 'mhinz/vim-signify'                       " 文件修改情况显示
            "Plugin 'tpope/vim-abolish.git'                   " 拼写更正生成
            Plugin 'osyo-manga/vim-over'                     " 命令实时预览
            Plugin 'kana/vim-textobj-indent'                 " 缩进文本对象（vai vii
            Plugin 'gcmt/wildfire.vim'                       " 选取最近一层指定格式
            Plugin 'kshenoy/vim-signature'                   " 左侧栏显示标记
        endif
    " }-

    " Writing -{
        if count(g:cyanife_bundle_groups, 'writing')
            Plugin 'reedes/vim-litecorrect'                  " 空格修正拼写错误
            Plugin 'reedes/vim-textobj-sentence'             " 句子选取(vas vis)
            Plugin 'reedes/vim-textobj-quote'                " 引用选取
            Plugin 'reedes/vim-wordy'                        " 用词建议
        endif
    " }-

    " General Programming -{
        if count(g:cyanife_bundle_groups, 'programming')
            " Pick one of the checksyntax, jslint, or syntastic
            Plugin 'scrooloose/syntastic'                    " 语法检查
            Plugin 'tpope/vim-fugitive'                      " Git wrapper
            Plugin 'mattn/webapi-vim'
            Plugin 'mattn/gist-vim'                          " 发送文件内容至Gist
            Plugin 'scrooloose/nerdcommenter'                " 快速注释
            "Plugin 'tpope/vim-commentary'                    " 快速注释
            "Plugin 'godlygeek/tabular'                       " 对齐
            "Plugin 'vim-scripts/Align'                       " 对齐
            Plugin 'junegunn/vim-easy-align'                 " 对齐
            Plugin 'luochen1990/rainbow'                     " 括号高亮
            if executable('ctags')
                Plugin 'majutsushi/tagbar'                   " tag目录
            endif
        endif
    " }-

    " Snippets & AutoComplete -{
        if count(g:cyanife_bundle_groups, 'snipmate')
            Plugin 'garbas/vim-snipmate'                     " 代码片段补全
            Plugin 'honza/vim-snippets'                      " 代码片段库
            " Source support_function.vim to support vim-snippets.
            if filereadable(expand("$VIM/vimfiles/bundle/vim-snippets/snippets/support_functions.vim"))
                source $VIM/vimfiles/bundle/vim-snippets/snippets/support_functions.vim
            elseif filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
                source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
            endif
        elseif count(g:cyanife_bundle_groups, 'youcompleteme')
            Plugin 'Valloric/YouCompleteMe'                  " 自动补全YCM
            Plugin 'SirVer/ultisnips'                        " 代码片段补全
            Plugin 'honza/vim-snippets'
        elseif count(g:cyanife_bundle_groups, 'neocomplcache')
            Plugin 'Shougo/neocomplcache'                    " 自动补全NCC
            Plugin 'Shougo/neosnippet'
            Plugin 'Shougo/neosnippet-snippets'
            Plugin 'honza/vim-snippets'
        elseif count(g:cyanife_bundle_groups, 'neocomplete')
            Plugin 'Shougo/neocomplete.vim.git'              " 自动补全NCE
            Plugin 'Shougo/neosnippet'
            Plugin 'Shougo/neosnippet-snippets'
            Plugin 'honza/vim-snippets'
        endif
    " }-

    " PHP -{
        if count(g:cyanife_bundle_groups, 'php')
            Plugin 'spf13/PIV'                               " spf13的PHP整合环境
            Plugin 'arnaud-lb/vim-php-namespace'             "
            Plugin 'beyondwords/vim-twig'
        endif
    " }-

    " !!!Notice!!! Gvim 7.4 only support Python 2.7.9, 2.7.11 will cause E887 error.
    " Python -{
        if count(g:cyanife_bundle_groups, 'python')
            " Pick either python-mode or pyflakes & pydoc
            Plugin 'klen/python-mode'                        " python工具整合(pep etc)
            Plugin 'yssource/python.vim'                     " python菜单 
            Plugin 'python_match.vim'                        " python %跳转
            Plugin 'pythoncomplete'                          " python自动完成
        endif
    " }-

    " Javascript -{
        if count(g:cyanife_bundle_groups, 'javascript')
            Plugin 'elzr/vim-json'                           " 高亮json
            Plugin 'groenewege/vim-less'                     " LESS(css扩展语言)高亮
            Plugin 'pangloss/vim-javascript'                 " js语法&缩进
            Plugin 'briancollins/vim-jst'                    " jst/ejs语法缩进
            Plugin 'kchmck/vim-coffee-script'                " coffeescript S&I
        endif
    " }-

    " Scala -{
        if count(g:cyanife_bundle_groups, 'scala')
            Plugin 'derekwyatt/vim-scala'
            Plugin 'derekwyatt/vim-sbt'
            Plugin 'xptemplate'
        endif
    " }-

    " Haskell -{
        if count(g:cyanife_bundle_groups, 'haskell')
            Plugin 'travitch/hasksyn'
            Plugin 'dag/vim2hs'
            Plugin 'Twinside/vim-haskellConceal'
            Plugin 'Twinside/vim-haskellFold'
            Plugin 'lukerandall/haskellmode-vim'
            Plugin 'eagletmt/neco-ghc'
            Plugin 'eagletmt/ghcmod-vim'
            Plugin 'Shougo/vimproc.vim'
            Plugin 'adinapoli/cumino'
            Plugin 'bitc/vim-hdevtools'
        endif
    " }-

    " HTML -{
        if count(g:cyanife_bundle_groups, 'html')
            Plugin 'amirh/HTML-AutoCloseTag'                 " 顾名思义
            Plugin 'hail2u/vim-css3-syntax'                  " 顾名思义
            Plugin 'gorodinskiy/vim-coloresque'              " 显示输入的颜色
            Plugin 'tpope/vim-haml'                          " HAML, HTML like markdown
            Plugin 'mattn/emmet-vim'                         " ZEN CODING!
        endif
    " }-

    " Ruby -{
        if count(g:cyanife_bundle_groups, 'ruby')
            Plugin 'tpope/vim-rails'
            let g:rubycomplete_buffer_loading = 1
            "let g:rubycomplete_classes_in_global = 1
            "let g:rubycomplete_rails = 1
        endif
    " }-

    " Puppet -{
        if count(g:cyanife_bundle_groups, 'puppet')
            Plugin 'rodjek/vim-puppet'
        endif
    " }-

    " Go Lang -{
        if count(g:cyanife_bundle_groups, 'go')
            "Plugin 'Blackrush/vim-gocode'
            Plugin 'fatih/vim-go'
        endif
    " }-

    " Elixir -{
        if count(g:cyanife_bundle_groups, 'elixir')
            Plugin 'elixir-lang/vim-elixir'
            Plugin 'carlosgaldino/elixir-snippets'
            Plugin 'mattreduce/vim-mix'
        endif
    " }-

    " Misc -{
        if count(g:cyanife_bundle_groups, 'misc')
            "Plugin 'rust-lang/rust.vim'                      " RUST语言    
            Plugin 'tpope/vim-markdown'                       " markdown
            Plugin 'spf13/vim-preview'                        " markdown预览
            "Plugin 'tpope/vim-cucumber'                       " 测试工具
            Plugin 'cespare/vim-toml'                         " TOML配置语言
            "Plugin 'quentindecock/vim-cucumber-align-pipes'   " cucumber对齐
            "Plugin 'saltstack/salt-vim'                       " saltstack配置
        endif
    " }-

" }-

" General -{

    set background=dark         " Assume a dark background

    " Allow to trigger background
    "function! ToggleBG()
    "    let s:tbg = &background
    "    " Inversion
    "    if s:tbg == "dark"
    "        set background=light
    "    else
    "        set background=dark
    "    endif
    "endfunction
    "noremap <leader>bg :call ToggleBG()<CR>

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Automatically switch to the current file directory when
    " a new buffer is opened
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set nospell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this:
    "   let g:cyanife_no_restore_cursor = 1
    if !exists('g:cyanife_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories -{
        set writebackup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:cyanife_no_views = 1
        if !exists('g:cyanife_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }-

" }-

" Vim UI -{

    if filereadable(expand("$VIM/vimfiles/bundle/vim-colors-solarized/colors/solarized.vim")) || filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="high"
        let g:solarized_visibility="normal"
        color solarized             " Load a colorscheme
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set cmdheight=2
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set nrformats+=alpha            "let ctrl-a/x can in/decrease single characters

" }-

" Formatting -{

    "set nowrap                      " Do not wrap long lines
    set wrap                        " wrap long lines
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
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    set ffs=unix,dos,mac            " Use unix line feeds format first(<NL>)

    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace:
    "   let g:cyanife_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:cyanife_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    
    " Auto append headline to new script files
    autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
    
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }-

" Key (re)Mappings -{

    " Use ',' as the leader key.
    let mapleader = ','
    let maplocalleader = '_'

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality,
    "   let g:cyanife_no_easyWindows = 1
    if !exists('g:cyanife_no_easyWindows')
        "map <C-J> <C-W>j<C-W>_
        "map <C-K> <C-W>k<C-W>_
        map <C-L> <C-W>l<C-W>_
        map <C-H> <C-W>h<C-W>_
    endif

    " Move a line up or down easily
    nnoremap <C-S-Up> ddP
    nnoremap <C-S-Down> ddp

    " Use spacebar open/off fold.
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

    " Wrapped lines goes down/up to next row, rather than next line in file.
    "noremap j gj
    "noremap k gk

    " 让自动换行的行表现如同原生行
    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour,
    "  let g:cyanife_no_wrapRelMotion = 1
    if !exists('g:cyanife_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, 
    "  let g:cyanife_no_fastTabs = 1
    if !exists('g:cyanife_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:cyanife_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

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
    if LINUX()
        cmap w!! w !sudo tee % >/dev/null
    endif

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    "cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    "map <leader>ew :e %%
    "map <leader>es :sp %%
    "map <leader>ev :vsp %%
    "map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    "map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b "toggle,fullscreen")<CR>

" }-

" Plugins -{

    " GoLang -{
        if count(g:cyanife_bundle_groups, 'go')
            let g:go_highlight_functions = 1
            let g:go_highlight_methods = 1
            let g:go_highlight_structs = 1
            let g:go_highlight_operators = 1
            let g:go_highlight_build_constraints = 1
            let g:go_fmt_command = "goimports"
            let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
            let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
            au FileType go nmap <Leader>s <Plug>(go-implements)
            au FileType go nmap <Leader>i <Plug>(go-info)
            au FileType go nmap <Leader>e <Plug>(go-rename)
            au FileType go nmap <leader>r <Plug>(go-run)
            au FileType go nmap <leader>b <Plug>(go-build)
            au FileType go nmap <leader>t <Plug>(go-test)
            au FileType go nmap <Leader>gd <Plug>(go-doc)
            au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
            au FileType go nmap <leader>co <Plug>(go-coverage)
        endif
        " }-


    " TextObj Sentence -{
        if count(g:cyanife_bundle_groups, 'writing')
            augroup textobj_sentence
              autocmd!
              autocmd FileType markdown call textobj#sentence#init()
              autocmd FileType textile call textobj#sentence#init()
              autocmd FileType text call textobj#sentence#init()
            augroup END
        endif
    " }-

    " TextObj Quote -{
        if count(g:cyanife_bundle_groups, 'writing')
            augroup textobj_quote
                autocmd!
                autocmd FileType markdown call textobj#quote#init()
                autocmd FileType textile call textobj#quote#init()
                autocmd FileType text call textobj#quote#init({'educate': 0})
            augroup END
        endif
    " }-

    " PIV -{
        if isdirectory(expand("$VIM/vimfiles/bundle/PIV")) || isdirectory(expand("~/.vim/bundle/PIV"))
            let g:DisableAutoPHPFolding = 0
            let g:PIVAutoClose = 0
        endif
    " }-

    " Misc -{
        if isdirectory(expand("$VIM/vimfiles/bundle/nerdtree")) || isdirectory(expand("~/.vim/bundle/nerdtree"))
            let g:NERDShutUp=1
        endif
        if isdirectory(expand("$VIM/vimfiles/bundle/matchit.zip")) || isdirectory(expand("~/.vim/bundle/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }-

    " OmniComplete -{
        " To disable omni complete,
        "   let g:cyanife_no_omni_complete = 1
        if !exists('g:cyanife_no_omni_complete')
            if has("autocmd") && exists("+omnifunc")
                autocmd Filetype *
                    \if &omnifunc == "" |
                    \setlocal omnifunc=syntaxcomplete#Complete |
                    \endif
            endif

            hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
            hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
            hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

            " Some convenient mappings
            "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
            if exists('g:cyanife_map_cr_omni_complete')
                inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"
            endif
            inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

            " Automatically open and close the popup menu / preview window
            au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
            set completeopt=menu,preview,longest
        endif
    " }-

    " Ctags -{
        set tags=./tags;/,~/.vimtags,$VIM/tags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }-

    " AutoCloseTag -{
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }-

    " SnipMate -{
        " Setting the author var
        let g:snips_author = 'Yifeng CHU <cyanife@gmail.com>'
    " }-

    " NerdTree -{
        if isdirectory(expand("$VIM/vimfiles/bundle/nerdtree")) || isdirectory(expand("~/.vim/bundle/nerdtree"))
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }-

    " Tabularize -{
        if isdirectory(expand("$VIM/vimfiles/bundle/tabular")) || isdirectory(expand("~/.vim/bundle/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }-

    " Tabularize -{
        if isdirectory(expand("$VIM/vimfiles/bundle/vim-easy-align")) || isdirectory(expand("~/.vim/bundle/vim-easy-align"))
            nmap ga <Plug>(EasyAlign)
            xmap ga <Plug>(EasyAlign)
        endif
    " }-

    " Session List -{
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand("$VIM/vimfiles/bundle/sessionman.vim/")) || isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }-

    " JSON -{
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }-

    " PyMode -{
        " Disable if python support not present
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("$VIM/vimfiles/bundle/python-mode")) || isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0

            let g:pymode_folding = 0
        endif
    " }-

    " ctrlp -{
        if isdirectory(expand("$VIM/vimfiles/bundle/ctrlp.vim/")) || isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            " On Windows use "dir" as fallback command.
            elseif WINDOWS()
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            if isdirectory(expand("$VIM/vimfiles/bundle/ctrlp-funky/")) || isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    " }-

    " TagBar -{
        if isdirectory(expand("$VIM/vimfiles/bundle/tagbar/")) || isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
        endif
    " }-

    " Rainbow -{
        if isdirectory(expand("$VIM/vimfiles/bundle/rainbow/")) || isdirectory(expand("~/.vim/bundle/rainbow/"))
            let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
        endif
    " }-

    " Fugitive -{
        if isdirectory(expand("$VIM/vimfiles/bundle/vim-fugitive/")) || isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    " }-

    " YouCompleteMe -{
        if count(g:cyanife_bundle_groups, 'youcompleteme')
            let g:acp_enableAtStartup = 0

            " enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files = 1

            " remap Ultisnips for compatibility for YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Haskell post write lint and check with ghcmod
            " $ `cabal install ghcmod` if missing and ensure
            " $VIM/.cabal/bin is in your $PATH.
            if !executable("ghcmod")
                autocmd BufWritePost *.hs GhcModCheckAndLintAsync
            endif

            " For snippet_complete marker.
            if !exists("g:cyanife_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif
    " }-

    " neocomplete -{
        if count(g:cyanife_bundle_groups, 'neocomplete')
            " Disable AutoComplPop.
            let g:acp_enableAtStartup = 0
            " Use neocomplete.
            let g:neocomplete#enable_at_startup = 1
            " Use smartcase.
            let g:neocomplete#enable_smart_case = 1
            " Set minimum syntax keyword length.
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15
            let g:neocomplete#force_overwrite_completefunc = 1


            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings -{
                " These two lines conflict with the default digraph mapping of <C-K>
                if !exists('g:cyanife_no_neosnippet_expand')
                    imap <C-k> <Plug>(neosnippet_expand_or_jump)
                    smap <C-k> <Plug>(neosnippet_expand_or_jump)
                endif
                if exists('g:cyanife_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <ESC> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    " <C-k> Complete Snippet
                    " <C-k> Jump to next snippet point
                    imap <silent><expr><C-k> neosnippet#expandable() ?
                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                \ "neocomplete#smart_close_popup()" : "\<Plug>(neosnippet_expand_or_jump)")
                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    inoremap <expr><C-g> neocomplete#undo_completion()
                    inoremap <expr><C-l> neocomplete#complete_common_string()
                    "inoremap <expr><CR> neocomplete#complete_common_string()

                    " <CR>: close popup
                    " <s-CR>: close popup and save indent.
                    inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

                    function! CleverCr()
                        if pumvisible()
                            if neosnippet#expandable()
                                let exp = "\<Plug>(neosnippet_expand)"
                                return exp . neocomplete#smart_close_popup()
                            else
                                return neocomplete#smart_close_popup()
                            endif
                        else
                            return "\<CR>"
                        endif
                    endfunction

                    " <CR> close popup and save indent or expand snippet
                    imap <expr> <CR> CleverCr()
                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                    inoremap <expr><C-y> neocomplete#smart_close_popup()
                endif
                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

                " Courtesy of Matteo Cavalleri

                function! CleverTab()
                    if pumvisible()
                        return "\<C-n>"
                    endif
                    let substr = strpart(getline('.'), 0, col('.') - 1)
                    let substr = matchstr(substr, '[^ \t]*$')
                    if strlen(substr) == 0
                        " nothing to match on empty string
                        return "\<Tab>"
                    else
                        " existing text matching
                        if neosnippet#expandable_or_jumpable()
                            return "\<Plug>(neosnippet_expand_or_jump)"
                        else
                            return neocomplete#start_manual_complete()
                        endif
                    endif
                endfunction

                imap <expr> <Tab> CleverTab()
            " }-

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    " }-
    " neocomplcache -{
        elseif count(g:cyanife_bundle_groups, 'neocomplcache')
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_max_list = 15
            let g:neocomplcache_force_overwrite_completefunc = 1

            " Define dictionary.
            let g:neocomplcache_dictionary_filetype_lists = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplcache_keyword_patterns')
                let g:neocomplcache_keyword_patterns = {}
            endif
            let g:neocomplcache_keyword_patterns._ = '\h\w*'

            " Plugin key-mappings -{
                " These two lines conflict with the default digraph mapping of <C-K>
                imap <C-k> <Plug>(neosnippet_expand_or_jump)
                smap <C-k> <Plug>(neosnippet_expand_or_jump)
                if exists('g:cyanife_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <ESC> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    imap <silent><expr><C-k> neosnippet#expandable() ?
                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    inoremap <expr><C-g> neocomplcache#undo_completion()
                    inoremap <expr><C-l> neocomplcache#complete_common_string()
                    "inoremap <expr><CR> neocomplcache#complete_common_string()

                    function! CleverCr()
                        if pumvisible()
                            if neosnippet#expandable()
                                let exp = "\<Plug>(neosnippet_expand)"
                                return exp . neocomplcache#close_popup()
                            else
                                return neocomplcache#close_popup()
                            endif
                        else
                            return "\<CR>"
                        endif
                    endfunction

                    " <CR> close popup and save indent or expand snippet
                    imap <expr> <CR> CleverCr()

                    " <CR>: close popup
                    " <s-CR>: close popup and save indent.
                    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
                    "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
                    inoremap <expr><C-y> neocomplcache#close_popup()
                endif
                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
            " }-

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Enable heavy omni completion.
            if !exists('g:neocomplcache_omni_patterns')
                let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
    " }-
    " Normal Vim omni-completion -{
    " To disable omni complete,
    "   let g:cyanife_no_omni_complete = 1
        elseif !exists('g:cyanife_no_omni_complete')
            " Enable omni-completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

        endif
    " }-

    " Snippets -{
        if count(g:cyanife_bundle_groups, 'neocomplcache') ||
                    \ count(g:cyanife_bundle_groups, 'neocomplete')

            " Use honza's snippets.
            if WINDOWS()
                let g:neosnippet#snippets_directory='$VIM/vimfiles/bundle/vim-snippets/snippets'
            elseif LINUX()
                let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
            endif

            " Enable neosnippet snipmate compatibility mode
            let g:neosnippet#enable_snipmate_compatibility = 1

            " For snippet_complete marker.
            if !exists("g:cyanife_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            " Enable neosnippets when using go
            let g:go_snippet_engine = "neosnippet"

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif

    " FIXME: Isn't this for Syntastic to handle?
    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " $VIM/.cabal/bin is in your $PATH.
    if !executable("ghcmod")
        autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    endif
    " }-

    " UndoTree -{
        if isdirectory(expand("$VIM/vimfiles/bundle/undotree/")) || isdirectory(expand("~/.vim/bundle/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }-

    " indent_guides -{
        if isdirectory(expand("$VIM/vimfiles/bundle/vim-indent-guides/")) || isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }-

    " Wildfire -{
    let g:wildfire_objects = {
                \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
                \ "html,xml" : ["at"],
                \ }
    " }-

    " vim-airline -{
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand("$VIM/vimfiles/bundle/vim-airline-themes/")) || isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'solarized'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }-
" }-

" GUI Settings -{

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if !exists("g:cyanife_no_big_font")
            if LINUX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
            elseif OSX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            elseif WINDOWS() && has("gui_running")
                set guifont=DejaVu_Sans_Mono:h12,YaHei_Consolas_Hybird:h12
                set gfw=Microsoft\ Yahei:h12:cGB2312
            endif
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }-

" Functions -{
    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }-

    " Initialize NERDTree as needed -{
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }-

    " Strip whitespace -{
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }-

    " Shell command -{
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }-

    " Diff function under Windows -{
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
    " }-
    
    " Auto append headline to new script files -{
    function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
    endfunction
    " }-
    
" }-
