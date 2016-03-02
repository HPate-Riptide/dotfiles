" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Disable the YADR solairzed enhancements, re-enable if you want
" to use solarized as the color scheme
let g:yadr_using_unsolarized_terminal = 1
let g:yadr_disable_solarized_enhancements = 1

" Change leader to a space because the backslash is too far away
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader="\<Space>"

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
"if filereadable(expand("~/.vim/vundles.vim"))
""  source ~/.vim/vundles.vim
"endif

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest,full
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=node_modules/**
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.git/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Plugins =========================
call plug#begin('~/.vim/plugged')
" Color schemes
Plug 'AlessandroYorba/Alduin'
Plug 'jedverity/feral-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'goatslacker/mango.vim'
Plug 'hukl/Smyck-Color-Scheme'
Plug 'chrisbra/color_highlight'
Plug 'skwp/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
"Plug 'jby/tmux.vim'
Plug 'xsunsmile/showmarks'

" Required for Gblame in terminal vim
Plug 'godlygeek/csapprox'

" ------------------- Source Control -------------------
Plug 'gregsexton/gitv'
"Plug 'mattn/gist-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'


" ------------------- Javascript ----------------------
" Nice stuff for working with angular
"Plug 'burnettk/vim-angular'

" JSON mappings - provides an 'j' text object for JSON
Plug 'tpope/vim-jdaddy'

" NodeJS bindings
Plug 'moll/vim-node'

" Both required for formatting JS
Plug 'maksimr/vim-jsbeautify'
Plug 'einars/js-beautify'

" Smart plugging
Plug 'marijnh/tern_for_vim'

" Semicolon insertion
Plug 'lfilho/cosco.vim'

" JS Syntax files
"Plug 'elzr/vim-json'
" Plug 'gabesoft/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'othree/yajs.vim'

" For mocha test runner
Plug 'geekjuice/vim-mocha'

Plug 'mattn/emmet-vim'

Plug 'vim-scripts/gitignore'

" --------------- Languages -----------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'jtratner/vim-flavored-markdown'
Plug 'scrooloose/syntastic'
" Plug 'nelstrom/vim-markdown-preview'
" Plug 'skwp/vim-html-escape'
Plug 'groenewege/vim-less'


" ---------------- Project ----------------------
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'xolox/vim-misc'
" Plug 'xolox/vim-session'

" ------------------ Search ------------------------
Plug 'justinmk/vim-sneak'
Plug 'rking/ag.vim'
Plug 'vim-scripts/IndexedSearch'
Plug 'nelstrom/vim-visual-star-search'
"Plug 'skwp/greplace.vim'

Plug 'amiorin/ctrlp-z'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ----------------------- Text Objects ---------------
Plug 'austintaylor/vim-indentobject'
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-datetime'
"Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'vim-scripts/argtextobj.vim'

" -------------------------- General Improvements ---------------
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'briandoll/change-inside-surroundings.vim'
Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/camelcasemotion'
"Plug 'vim-scripts/matchit.zip'
"Plug 'kristijanhusak/vim-multiple-cursors'
"Plug 'Keithbsmiley/investigate.vim'
Plug 'chrisbra/NrrwRgn'
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'bogado/file-line'
"Plug 'mattn/webapi-vim'
Plug 'sjl/gundo.vim'
Plug 'skwp/YankRing.vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
"Plug 'vim-scripts/AnsiEsc.vim'
"Plug 'vim-scripts/AutoTag'
"Plug 'vim-scripts/lastpos.vim'
"Plug 'vim-scripts/sudo.vim'
Plug 'goldfeld/ctrlr.vim'
""#Plug 'junegunn/seoul256.vim'
""#Plug 'junegunn/goyo.vim'
""#Plug 'junegunn/limelight.vim'

" ---------------------- Misc Stuff ------------------------
" Plug 'luochen1990/rainbow'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'airblade/vim-rooter'
"Plug 'Valloric/YouCompleteMe'
" Plug 'ervandew/supertab'
Plug 'Yggdroot/indentLine'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'mhinz/vim-startify'
"Plug 'trusktr/seti.vim'
call plug#end()

" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim

if filereadable(expand("~/.yadr/vim/after/.vimrc.after"))
  source ~/.yadr/vim/after/.vimrc.after
endif

if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif
" au BufRead,BufNewFile Vagrantfile set ft=ruby

imap <C-f> <plug>(fzf-complete-line)

" brace expansion on the cheap
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O

" Set shell to zsh
if executable('zsh')
    if has("gui_running")
        set shell=zsh\ -i
    else
        set shell=zsh\ -l
    endif
endif

" Disabling this for now as it has a large performance impact it seems
" set relativenumber

" Plugin 
autocmd FileType javascript,css nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
autocmd FileType javascript,css inoremap <silent> <C-e> <c-o>:call cosco#commaOrSemiColon()<CR>

" Mappings for vim-jsbeautify - formats JS, CSS, and HTML
autocmd FileType javascript,json noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Visual mode mappings for beautifing a range of lines
autocmd FileType javascript,json vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" Make NERDTree reveal the current file
nmap <leader>nf :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeToggle<CR>

" Save
nmap <leader>w :w<CR>

" Turn on rainbow brackets
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup rainbow_lisp
    autocmd!
    autocmd FileType javascript,json,clojure,scheme RainbowParentheses
augroup END
" let g:rainbow_active = 1

" Turn on tern keyboard shortcuts
" <Leader> td  :TernDoc         Documentation under cursor
" <Leader> tb  :TernDocBrowse   Browse documentation
" <Leader> tt  :TernType        Type hints
" <Leader> td  :TernDef         Jump to definition (yes, 'td' is duplicated)
" <Leader> tpd :TernDefPreview  Jump to definition inside preview
" <Leader> tsd :TernDefSplit    Definition in new split
" <Leader> ttd :TernDefTab      Definition in new tab
" <Leader> tr  :TernRefs        All references under cursor
" <Leader> tR  :TernRename      Rename variable
"let maplocalleader = "\\"
let g:tern_map_keys=1
let g:tern_request_timeout = 3
" Enable tern autocomplete for Javascript
autocmd FileType javascript setlocal omnifunc=tern#Complete
"let g:tern_show_argument_hints='on_hold'

" Better mapping for <tab> for emmet
"let g:user_emmet_mode='a'
"let g:user_emmet_install_global = 0
"let g:use_emmet_complete_tag = 1
"augroup emmet
  "autocmd!
  "autocmd FileType html,css,scss,less imap <expr> <Leader> emmet#expandAbbrIntelligent("\<tab>")
"augroup END

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=256

" Allow <toggleSwitch> elements in angular code
let g:syntastic_html_tidy_blocklevel_tags = ['toggle-switch']

" keep blocks selected when indenting
vnoremap < <gv
vnoremap > >gv

" set ctrlp to show hidden files
let g:ctrlp_show_hidden = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips/'

" Set up libraries for https://github.com/othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'jquery,underscore,angularjs,chai,requirejs'

let g:syntastic_javascript_checkers = ['eslint']
if $PATH !~ "\.nvm"
    let $PATH="/Users/henry/.nvm/versions/node/v0.12.2/bin/:" . $PATH
endif

" Disable solarized, enable custom color scheme
"set background=dark
colorscheme alduin

" for use with startify plugin
set viminfo='100,n$HOME/.vim/files/info/viminfo'

let g:mocha_js_command = "!mocha --timeout 800000 --recursive --reporter spec"
nmap <Leader>tc :call RunCurrentSpecFile()<CR>
nmap <Leader>ts :call RunNearestSpec()<CR>
nmap <Leader>tl :call RunLastSpec()<CR>
nmap <Leader>ta :call RunAllSpecs()<CR>

" Easier split navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Clear HL search
nmap <leader><leader> :nohlsearch<CR>

" Open the .vimrc.after in a split for quick editing
nnoremap <leader>ve <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <leader>vs :so $MYVIMRC<CR>

" Create new vsplit with <leader>w and switch to it
" nnoremap <leader>w <C-w>v<C-w>l

" Make <C-n> work the way it normally does, but when the popup
" completion menu shows simulate the <Down> key so that
" a menu item is always selected
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  ""\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  ""\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Mocha add/del top of file 'only' keyword
nmap <leader>mdgo ggs.odt(<C-o><C-o>
nmap <leader>mago ggse(a.only<Esc><C-o><C-o>

nmap <leader>mdo ?\.only(<CR>dt(<C-o>
nmap <leader>mao ?it(<CR>ea.only<Esc><C-o>

" ES6/JSX Settings
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Z - cd to recent / frequent directories
" https://github.com/clvv/fasd/wiki/Vim-Integration
" command! -nargs=* Z :call Z(<f-args>)
" function! Z(...)
"   let cmd = 'fasd -d -e printf'
"   for arg in a:000
"     let cmd = cmd . ' ' . arg
"   endfor
"   let path = system(cmd)
"   if isdirectory(path)
"     echo path
"     exec 'cd ' . path
"   endif
" endfunction
let g:ctrlp_z_nerdtree = 1
"let g:ctrlp_extensions = ['Z', 'F']
nnoremap <leader>pz :CtrlPZ<Cr>
nnoremap <leader>pf :CtrlPF<Cr>



" -----------------------------------------------------
" YankRing Settings
" -----------------------------------------------------
let g:yankring_history_file = '.yankring-history'
nnoremap <leader>yr :YRShow<CR>

" -----------------------------------------------------
" YankRing Settings
" -----------------------------------------------------












set runtimepath+=~/.yadr/bin/fasd

set guifont=Menlo\ Regular:h12
