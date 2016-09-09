" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================
set cmdheight=2
set shortmess=a
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

"
" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

" Disable the macvim toolbar
set guioptions-=T

" Disable the YADR solairzed enhancements, re-enable if you want
" to use solarized as the color scheme
let g:yadr_using_unsolarized_terminal = 1
let g:yadr_disable_solarized_enhancements = 1

" Make it beautiful - colors and fonts
if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set lines=60
  set columns=190

  " if has("gui_gtk2")
  "   set guifont=Inconsolata\ XL\ 12,Inconsolata\ 15,Monaco\ 12
  " else
  "   set guifont=Inconsolata\ XL:h12,Inconsolata:h12,Monaco:h12
  " end
  set guifont=Menlo\ Regular:h12
else
  let g:CSApprox_loaded = 1

  " For people using a terminal that is not Solarized
  if exists("g:yadr_using_unsolarized_terminal")
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
  end
endif


" colorscheme smyck

"turn on syntax highlighting
syntax on

" Prevent vim-session from asking us to load the session.
" If you want to load the session, use :SaveSession and :OpenSession
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" Tell showmarks to not include the various brace marks (),{}, etc
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

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
Plug 'joshdick/onedark.vim'
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

Plug 'zerowidth/vim-copy-as-rtf'
Plug 'dharanasoft/rtf-highlight'
let g:rtfh_theme = 'solarized-dark'
nmap <Leader>r :RTFHighlight js<cr>
" -------------------------------------
" Fugitive settings
" -------------------------------------
Plug 'tpope/vim-fugitive'
" The tree buffer makes it easy to drill down through the directories of your
" git repository, but it’s not obvious how you could go up a level to the
" parent directory. Here’s a mapping of .. to the above command, but
" only for buffers containing a git blob or tree
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Every time you open a git object using fugitive it creates a new buffer. 
" This means that your buffer listing can quickly become swamped with 
" fugitive buffers. This prevents this from becomming an issue:

autocmd BufReadPost fugitive://* set bufhidden=delete
Plug 'tpope/vim-git'


" -------------------------------------
" Git Gutter settings
" -------------------------------------
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0


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
Plug 'elzr/vim-json'
" Plug 'gabesoft/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'othree/yajs.vim'

" For mocha test runner
" Plug 'geekjuice/vim-mocha'

" Plug 'mattn/emmet-vim'

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
Plug 'vim-scripts/IndexedSearch'
Plug 'nelstrom/vim-visual-star-search'
"Plug 'skwp/greplace.vim'

Plug 'amiorin/ctrlp-z'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'rking/ag.vim'

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
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/camelcasemotion'
" Plug 'christoomey/vim-tmux-navigator'
"Plug 'vim-scripts/matchit.zip'
"Plug 'kristijanhusak/vim-multiple-cursors'
"Plug 'Keithbsmiley/investigate.vim'
Plug 'chrisbra/NrrwRgn'
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
Plug 'metakirby5/codi.vim'
call plug#end()

" Default interpreters
let g:codi#interpreters = {
   \ 'javascript': {
   \     'bin': 'babel-node',
   \  },
\ }

" ================ Custom Settings ========================
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
"if executable('zsh')
    set shell=zsh
"endif

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

" Previous/Next tab
nmap <leader>tn :tabn<CR>
nmap <leader>tp :tabp<CR>

" Save
nmap <leader>w :w<CR>
nmap <leader>y :norm "*y

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
let g:used_javascript_libs = 'jquery,react,underscore,angularjs,chai,requirejs'
"
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = ['eslint']
if $PATH !~ "\.nvm"
    let $PATH="/Users/henry/.nvm/versions/node/v4.3.0/bin/:" . $PATH
endif

" Use quicker option for showing indentation guides
let g:indentLine_faster = 1

" for use with startify plugin
set viminfo='100,n$HOME/.vim/files/info/viminfo'

let g:mocha_js_command = "!mocha --timeout 800000 --recursive --reporter spec"
nmap <Leader>tc :call RunCurrentSpecFile()<CR>
nmap <Leader>ts :call RunNearestSpec()<CR>
nmap <Leader>tl :call RunLastSpec()<CR>
nmap <Leader>ta :call RunAllSpecs()<CR>

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

" Make FASDF path available for VIM
let $PATH='~/.yadr/bin/:/usr/local/bin:' . $PATH

let g:vim_json_syntax_conceal = 0


" -----------------------------------------------------
" AG Settings
" -----------------------------------------------------
" Open the Ag command and place the cursor into the quotes
nmap <leader>ag :Ag ""<Left>
nmap <leader>af :AgFile ""<Left>

" ========================================
" Mac specific General vim sanity improvements
" ========================================
"
" ========================================
" RSI Prevention - keyboard remaps
" ========================================
" Certain things we do every day as programmers stress
" out our hands. For example, typing underscores and
" dashes are very common, and in position that require
" a lot of hand movement. Vim to the rescue
"
" Now using the middle finger of either hand you can type
" underscores with apple-k or apple-d, and add Shift
" to type dashes
imap <silent> <D-k> _
imap <silent> <D-d> _
imap <silent> <D-K> -
imap <silent> <D-D> -

" Change inside various enclosures with Cmd-" and Cmd-'
" The f makes it find the enclosure so you don't have
" to be standing inside it
nnoremap <D-'> f'ci'
nnoremap <D-"> f"ci"
nnoremap <D-(> f(ci(
nnoremap <D-)> f)ci)
nnoremap <D-[> f[ci[
nnoremap <D-]> f]ci]

" ==== NERD tree
" Cmd-Shift-N for nerd tree
" nmap <D-N> :NERDTreeToggle<CR>

" move up/down quickly by using Cmd-j, Cmd-k
" which will move us around by functions
nnoremap <silent> <D-j> }
nnoremap <silent> <D-k> {
autocmd FileType javascript map <buffer> <D-k> }
autocmd FileType javascript map <buffer> <D-j> {

" Command-/ to toggle comments
map <D-/> :Commentary<CR>
imap <D-/> <Esc>:Commentary<CR>i

" Use numbers to pick the tab you want (like iTerm)
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>

" Resize windows with arrow keys
nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>

" ============================
" Tabularize - alignment
" ============================
" Hit Cmd-Shift-A then type a character you want to align by
nmap <D-A> :Tabularize /
vmap <D-A> :Tabularize /

" Source current file Cmd-% (good for vim development)
map <D-%> :so %<CR>






" -----------------------------------------------------
" Ctrl-P settings
" -----------------------------------------------------
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s -l -g "" --nocolor --hidden'

  " Henry - 2016-01-26 - Testing to see if this is true...
  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0

  " Don't clear cache on exit
  " let g:ctrlp_clear_cache_on_exit=0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 1

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0

" We don't want to use Ctrl-p as the mapping because
" it interferes with YankRing (paste, then hit ctrl-p)
"let g:ctrlp_map = '<leader>p'
let g:crtlp_map='<F11>'
nnoremap <silent> <leader>pp :CtrlP<CR>

" Additional mapping for buffer search
nnoremap <silent> <leader>pb :CtrlPBuffer<cr>

" Additional mapping for most recently used files
nnoremap <silent> <leader>pm :CtrlPMRUFiles<cr>

" Cmd-Shift-P to clear the cache
nnoremap <silent> <leader>pd :ClearCtrlPCache<cr>

" Idea from : http://www.charlietanksley.net/blog/blog/2011/10/18/vim-navigation-with-lustyexplorer-and-lustyjuggler/
" Open CtrlP starting from a particular path, making it much
" more likely to find the correct thing first. mnemonic 'jump to [something]'
" map ,ja :CtrlP app/assets<CR>
" map ,jm :CtrlP app/models<CR>
" map ,jc :CtrlP app/controllers<CR>
" map ,jv :CtrlP app/views<CR>
" map ,jh :CtrlP app/helpers<CR>
" map ,jl :CtrlP lib<CR>
" map ,jp :CtrlP public<CR>
" map ,js :CtrlP spec<CR>
" map ,jf :CtrlP fast_spec<CR>
" map ,jd :CtrlP db<CR>
" map ,jC :CtrlP config<CR>
" map ,jV :CtrlP vendor<CR>
" map ,jF :CtrlP factories<CR>
" map ,jT :CtrlP test<CR>

"Cmd-Shift-(M)ethod - jump to a method (tag in current file)
"Ctrl-m is not good - it overrides behavior of Enter
" nnoremap <silent> <D-M> :CtrlPBufTag<CR>




" -----------------------------------------------------
" fugitive.git
" -----------------------------------------------------
" For fugitive.git, dp means :diffput. Define dg to mean :diffget
nnoremap <silent> <leader>dg :diffget<CR>
nnoremap <silent> <leader>dp :diffput<CR>









" -----------------------------------------------------
" Support for github flavored markdown
" -----------------------------------------------------
" via https://github.com/jtratner/vim-flavored-markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END


" -----------------------------------------------------
" Gundo settings
" -----------------------------------------------------
nmap <leader>u :GundoToggle<CR>

" open on the right so as not to compete with the nerdtree
let g:gundo_right = 1 

" a little wider for wider screens
let g:gundo_width = 60







" -----------------------------------------------------
" NERDTree settings
" -----------------------------------------------------
" Make nerdtree look nice
let NERDTreeMinimalUI  = 1
let NERDTreeDirArrows  = 1
let g:NERDTreeWinSize  = 30
let NERDTreeShowHidden = 1










" -----------------------------------------------------
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
"
" Shamelessly stolen from Gary Bernhardt: https://github.com/garybernhardt/dotfiles
" -----------------------------------------------------
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  if len(filenames) > 0
    exec "edit " . filenames[0]
    for filename in filenames[1:]
      exec "sp " . filename
    endfor
  end
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

nnoremap <leader>ocf :OpenChangedFiles<CR>










" -----------------------------------------------------
" Stolen from Steve Losh vimrc: https://bitbucket.org/sjl/dotfiles/src/tip/vim/.vimrc
" -----------------------------------------------------
" Open a Quickfix window for the last search.
nnoremap <silent> <leader>q/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Ag for the last search.
nnoremap <silent> <leader>qa/ :execute "Ag! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>









" -----------------------------------------------------
" Syntastic settings
" -----------------------------------------------------
" mark syntax errors with :signs
let g:syntastic_enable_signs=1
" automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
" don't care about warnings
let g:syntastic_quiet_messages = {'level': 'warnings'}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" always stick any detected errors into the |location-list|
let g:syntastic_always_populate_loc_list = 1
" error window will be automatically closed when no errors are detected, but not opened automatically
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
" don't run the syntax check on save+quit
let g:syntastic_check_on_wq = 0
" runs all checkers that apply to the current filetype,
" then aggregates errors found by all checkers and displays them.
let g:syntastic_aggregate_errors = 1




" -----------------------------------------------------
" Bubble lines
" -----------------------------------------------------
" https://github.com/carlhuda/janus/blob/master/vimrc

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv








" -----------------------------------------------------
" Tmux navigation
" -----------------------------------------------------
" Don't allow any default key-mappings.
let g:tmux_navigator_no_mappings = 1

" Re-enable tmux_navigator.vim default bindings, minus <c-\>.
" <c-\> conflicts with NERDTree "current file".
" nnoremap <silent> <c-h> <c-w>h<cr>
" nnoremap <silent> <c-j> <c-w>j<cr>
" nnoremap <silent> <c-k> <c-w>k<cr>
" nnoremap <silent> <c-l> <c-w>l<cr>

" nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <c-l> :TmuxNavigateRight<cr>


" ========================================
" General vim sanity improvements
" ========================================
" http://vimcasts.org/episodes/soft-wrapping-text/
function! SetupWrapping()
  set wrap linebreak nolist
  set showbreak=…
endfunction

" TODO: this should happen automatically for certain file types (e.g. markdown)
command! -nargs=* Wrap :call SetupWrapping()<CR>

vmap <D-j> gj
vmap <D-k> gk
vmap <D-$> g$
vmap <D-^> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-$> g$
nmap <D-^> g^
nmap <D-0> g^

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap <leader>W :StripTrailingWhitespaces<CR>
" w!! to write a file as sudo
" stolen from Steve Losh
cmap w!! w !sudo tee % >/dev/null
"
" alias yw to yank the entire word 'yank inner word'
" even if the cursor is halfway inside the word
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>yw yiww

" ,ow = 'overwrite word', replace a word with what's in the yank buffer
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>ow "_diwhp

"make Y consistent with C and D
nnoremap Y y$
function! YRRunAfterMaps()
  nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" ,# Surround a word with #{ruby interpolation}
" map ,# ysiw#
" vmap ,# c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>
imap <silent> <C-s>" <Esc>ysiw"f"a

" ,' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>
imap <silent> <C-s>' <Esc>ysiw'f'a

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`

" gary bernhardt's hashrocket
" imap <c-l> <space>=><space>

"Go to last edit location with ,.
nnoremap <leader>. '.

"When typing a string, your quotes auto complete. Move past the quote
"while still in insert mode by hitting Ctrl-o. Example:
"
" type 'foo<c-o>
"
" the first quote will autoclose so you'll get 'foo' and hitting <c-o> will
" put the cursor right after the quote
imap <D-o> <esc>wa

" ==== NERD tree
" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>:vertical res 30<CR>
nmap <silent> <leader>nt :NERDTreeToggle<CR>
nmap <silent> <leader>nf :NERDTreeFind<CR>
nmap <silent> <leader>nd :NERDTree ~/git/elements/elements-dockerized/lib/src/<CR>


" ,q to toggle quickfix window (where you have stuff like Ag)
" ,oq to open it back up (rare)
nmap <silent> <leader>qc :cclose<CR>
nmap <silent> <leader>qo :copen<CR>

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>

" ==============================
" Window/Tab/Split Manipulation
" ==============================
" Move between split windows by using the four directions H, L, K, J
" NOTE: This has moved to vim/settings/vim-tmux-navigator.vim.
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Make gf (go to file) create the file, if not existent
" nnoremap gf :e<cfile><CR>
" nnoremap <C-w>f :sp +e<cfile><CR>
" nnoremap <C-w>gf :tabe<cfile><CR>

" Zoom in
" map <silent> ,gz <C-w>o

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
" nnoremap <silent> vv <C-w>v
" nnoremap <silent> ss <C-w>s

" ============================
" Shortcuts for everyday tasks
" ============================

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
" nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
" nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

"(v)im (c)ommand - execute current line as a vim command
" nmap <silent> ,vc yy:<C-f>p<C-c><CR>

"(v)im (r)eload
nmap <silent> <leader>vr :so %<CR>

" Type ,hl to toggle highlighting on/off, and show current value.
" noremap ,hl :set hlsearch! hlsearch?<CR>

" These are very similar keys. Typing 'a will jump to the line in the current
" file marked with ma. However, `a will jump to the line and column marked
" with ma.  It’s more useful in any case I can imagine, but it’s located way
" off in the corner of the keyboard. The best way to handle this is just to
" swap them: http://items.sjbach.com/319/configuring-vim-right
" nnoremap ' `
" nnoremap ` '

" ============================
" SplitJoin plugin
" ============================
nmap <leader>sj :SplitjoinSplit<cr>
nmap <leader>sk :SplitjoinJoin<cr>

" Get the current highlight group. Useful for then remapping the color
map <space>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" ,hp = html preview
" map <silent> ,hp :!open -a Safari %<CR><CR>



" -------------------------------------
"  Multiple Cursors settings
" -------------------------------------
" Turn off default key mappings
let g:multi_cursor_use_default_mapping=0

" Switch to multicursor mode with ,mc
let g:multi_cursor_start_key=',mc'

" Ctrl-n, Ctrl-p, Ctrl-x, and <Esc> are mapped in the special multicursor
" mode once you've added at least one virtual cursor to the buffer
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'








" -------------------------------------
" Lightline settings
" -------------------------------------
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" let g:lightline = {
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
"       \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
"       \ },
"       \ 'component_function': {
"       \   'fugitive': 'MyFugitive',
"       \   'readonly': 'MyReadonly',
"       \   'filename': 'MyFilename',
"       \ },
"       \ 'separator': { 'left': '⮀', 'right': '⮂' },
"       \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
"       \ }
"
" function! MyReadonly()
"   if &filetype == "help"
"     return ""
"   elseif &readonly
"     return "⭤ "
"   else
"     return ""
"   endif
" endfunction
"
" function! MyFugitive()
"   if exists("*fugitive#head")
"     let _ = fugitive#head()
"     return strlen(_) ? '⭠ '._ : ''
"   endif
"   return ''
" endfunction
"
" function! MyFilename()
"   return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
"        \ ('' != expand('%') ? expand('%') : '[NoName]')
" endfunction

" Use status bar even with single buffer
set laststatus=2






" Disable solarized, enable custom color scheme
set background=dark
colorscheme onedark



" let g:javascript_conceal_function       = "ƒ"
" let g:javascript_conceal_null           = "ø"
" let g:javascript_conceal_this           = "@"
" let g:javascript_conceal_return         = "⇚"
" let g:javascript_conceal_undefined      = "¿"
" let g:javascript_conceal_NaN            = "ℕ"
" let g:javascript_conceal_prototype      = "¶"
" let g:javascript_conceal_static         = "•"
" let g:javascript_conceal_super          = "Ω"
" let g:javascript_conceal_arrow_function = "⇒"
