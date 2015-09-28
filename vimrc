set nocompatible        " Must be first line

" Leader
let mapleader = ","

" Override shell to always be zsh
set shell=zsh

" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Plugins
Plugin 'mileszs/ack.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'
Plugin 'matchit.zip'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-indent'
Plugin 'bling/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'fatih/vim-go'


call vundle#end()            " required
filetype plugin indent on    " required

" Solarized colorscheme config
syntax enable
set background=dark
colorscheme solarized

" Sessionman options
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
	nmap <leader>sl :SessionList<CR>
	nmap <leader>ss :SessionSave<CR>
	nmap <leader>sc :SessionClose<CR>
endif

" vim-airline options
let g:airline#extensions#tabline#enabled = 1

"Window size
set lines=60
set columns=120
if has("gui_macvim")
    " set macvim specific stuff
    set transparency=2
else
    set mouse=
endif

" General options
set vb t_vb=
set hidden                          " Allow buffer switching without saving

set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line

set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=full  		" Command <Tab> completion, list matches, then longest common part, then all.

" Override shell to always be TCC, quotes don't seem to work so use shortname!
" Back in the Windows days, left here just in case :)
""set shell=c:\progra~1\jpsoft\tccle13x64\tcc.exe


" GUI
" set guifont=Consolas:h9:cANSI
set guioptions-=T
set guioptions-=m

" encoding
set encoding=utf-8

"Plug-in config overrides
" Nerdtree closed on startup & close window on file open
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:NERDTreeQuitOnOpen = 1

" Nerdcommenter Add delimiters for known filetypes"
let g:NERDCustomDelimiters = {
    \ 'config': { 'left': '<!--', 'right': '-->' }
    \}

" Powerline fixes
let g:Powerline_symbols_override = {
            \ 'BRANCH': 'B',
            \ 'LINE': 'L',
            \ }


set virtualedit=all		" Don't like to have my cursor move to end of line when moving up or down
set history=1000                " Store a ton of history (default is 20)
"
" Limit columns used for syntax highlighting, improves performance for long lines in
" XML files for example
set synmaxcol=150

" Set viminfo, store in cloudsync
set viminfo='100,<50,s10,h,rA:,rB:,n$HOME/cloudsync/.settings/vim/.viminfo

" Set additional config options
set number
set nospell "no spell checking
set nolist " Disable listchars processing
"set norelativenumber

" Mappings
" Windows friendly
" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V> "+gP
map <S-Insert> "+gP
inoremap <C-V> +
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

"NERDTree easy access
nmap ,e :NERDTree<CR>

"History search switch from arrows to Ctrl-N/Ctrl-P
cnoremap  <Down>
cnoremap  <Up>
cnoremap <Up> 
cnoremap <Down> 
"snoremap  <Down>
"snoremap  <Up>
"snoremap <Up> 
"snoremap <Down> 

"Repeat substitute with flags always
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" Copy filename to clipboard (xf=file,xp=path+file)
nmap ,xf :let @*=expand("%")<CR>
nmap ,xp :let @*=expand("%:p")<CR>

" ' to backtick so jumping to marks jumps to column
map ' `

" Simplenote (nvalt in Vim)
***REMOVED***
noremap ,nl :Simplenote -l<CR>
noremap ,nn :Simplenote -n<CR>
noremap ,nu :Simplenote -u<CR>
noremap ,nd :Simplenote -d<CR>

" spf13 bundle changes
" Unbundle unused bundles
"UnBundle 'spf13/vim-preview'
"UnBundle 'myusuf3/numbers.vim'
"UnBundle 'nathanaelkane/vim-indent-guides'
"UnBundle 'tsaleh/vim-align'
"UnBundle 'Shougo/neocomplete.vim.git'
"UnBundle 'Shougo/neosnippet'
"UnBundle 'Shougo/neosnippet-snippets'


" spf13 config changes
" Make sure Vim clipboard is not clobbering the Windows clipboard
set clipboard=
" Override autochdir with a version that handles zipfiles properly
" Buggy spf13 autochdir disable in .vimrc.bundles.local
" First one does not work with Clojure jump to source, try less restrictive
" zipfile identification
"autocmd BufEnter * if bufname("") !~? "\\v([A-Za-z0-9]*://)|(^[A-Z]:.*zipfile:.*::)" | lcd %:p:h | endif
autocmd BufEnter * if bufname("") !~? "\\v([A-Za-z0-9]*://)|(.*zipfile:.+::)" | lcd %:p:h | endif

" spf13 mapping changes
" Remove W->w, it interferes with all W typed on the command line
" Remove ;->:, I use the ; for next in combination with f or t
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p').'/' : '%%'
"cunmap W
"unmap ;
"unmap [F
"iunmap [F
"unmap [H
"iunmap [H
"unmap <C-e>

"unmap $
"unmap <End>
"unmap 0
"unmap <Home>
"unmap ^

" CtrlP plugin mapping (why these are not out-of-the-box is beyond me!)"
nmap <Leader>1 :CtrlPBuffer<CR>
nmap <Leader>2 :CtrlPMRUFiles<CR>
nmap <Leader>3 :CtrlP<CR>
nmap <Leader>4 :CtrlP

" Session.vim additional SessionClose mapping
nmap ,sc :SessionClose<CR>

" Buffer next, previous on Alt-left & Right. Can't live without it :)
nmap <A-Right> :bn<CR>
nmap <A-Left> :bp<CR>

" Buffer navigation shortcuts, more friendly than using :
nmap <Leader>bn :bn<CR>
nmap <Leader>bp :bp<CR>
nmap <Leader>bd :bd<CR>
nmap <Leader>bm :bm<CR>

" Tab helpers
nmap <Leader>tn :tabnew<CR>
nmap <Leader>tc :tabclose<CR>

" json formatting through python for visual selection
vmap <Leader>jt :!python -m json.tool<CR>

" Remap ' in clojure files
inoremap jj <ESC>

" Remap ' & ` in clojure files since we don't want them to "autoclose"
autocmd BufEnter *.clj imap <buffer> ' '
autocmd BufEnter *.clj imap <buffer> ` `

" Set filetype to xml for .config files, useful for asp.net configuration
" files
autocmd BufNewFile,BufEnter *.config setfiletype xml

" Redirect output of command to a new buffer in a new tab
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" Maximize/Restore window
let s:WindowMaximized = 0
function! RT_ToggleMaximizedwindow()
  if s:WindowMaximized == 1
    let s:WindowMaximized = 0
    " restore the window
    :simalt ~r
  else
    let s:WindowMaximized = 1
    " maximize the window
    :simalt ~x
  endif
endfunction
nmap <leader>m :call RT_ToggleMaximizedwindow()<CR>

" Private stuff
source ~/dotfiles/private.vim
