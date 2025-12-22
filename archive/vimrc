set nocompatible " Must be first line

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
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edsono/vim-matchit'
Plugin 'fatih/vim-go'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'junegunn/fzf.vim'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-lastpat'
Plugin 'kana/vim-textobj-user'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mbbill/undotree'
Plugin 'mileszs/ack.vim'
Plugin 'moll/vim-bbye'
Plugin 'mrtazz/simplenote.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
"Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/sessionman.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" fzf
set rtp+=~/.fzf
let g:fzf_launcher = "in_a_new_term_function %s"

" Solarized colorscheme config
syntax enable
set background=dark
colorscheme solarized
"call togglebg#map(",st") " Initialize ToggleBG mapping

" Sessionman options
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
  nnoremap <leader>sl :SessionList<CR>
  nnoremap <leader>ss :SessionSave<CR>
  nnoremap <leader>sc :SessionClose<CR>
  nnoremap <leader>sw :SessionShowLast<CR>
endif

" vim-airline options
let g:airline#extensions#tabline#enabled = 1

" ack.vim options
" use ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

"Window size
if has("gui_macvim")
    " set macvim specific stuff
    set transparency=2
    set lines=60
    set columns=120
else
    set mouse=
endif

" General options
set vb t_vb=
set hidden                      " Allow buffer switching without saving

set laststatus=2                " Always display status line
set nocursorline                " Highlight current line
set nowrap                      " Disable wrapping
set showmode                    " Display the current mode
set tabpagemax=15               " Only show 15 tabs

set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set incsearch                   " Find as you type search
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=full               " Command <Tab> completion, list matches, then longest common part, then all.
set winminheight=0              " Windows can be 0 line high

set expandtab
set shiftwidth=4
set tabstop=4

set timeout timeoutlen=3000 ttimeoutlen=100

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
if has('nvim')
    set viminfo='100,<50,s10,h,rA:,rB
else
    set viminfo='100,<50,s10,h,rA:,rB:,n$HOME/cloudsync/.settings/vim/.viminfo
endif

" Set additional config options
set number
set nospell "no spell checking
set nolist " Disable listchars processing
"set norelativenumber

" Mappings
" Windows friendly
" Use CTRL-S for saving, also in Insert mode
noremap  <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" Easy copy to / from clipboard
noremap  <Leader>y "+y
noremap  <Leader>ya :%y+<CR>
noremap  <Leader>p "+p
noremap  <Leader>P "+P

" Cmd-V is Paste
map <D-V> "+gP
inoremap <D-V> +
cnoremap <D-V> <C-R>+

" CTRL-A is Select all
"inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-A> <C-C>gggH<C-O>G
"onoremap <C-A> <C-C>gggH<C-O>G
"snoremap <C-A> <C-C>gggH<C-O>G
"xnoremap <C-A> <C-C>ggVG

"NERDTree easy access
nnoremap ,e :NERDTree<CR>

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
nnoremap ,xf :let @*=expand("%")<CR>
nnoremap ,xp :let @*=expand("%:p")<CR>

" ' to backtick so jumping to marks jumps to column
map ' `

" Window movement
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k

" Simplenote (nvalt in Vim)
"let g:SimplenoteFiletype="markdown"
"let g:SimplenoteVertical=1
"noremap ,nl :Simplenote -l<CR>
"noremap ,nn :Simplenote -n<CR>
"noremap ,nu :Simplenote -u<CR>
"noremap ,nd :Simplenote -d<CR>
"noremap ,nt :Simplenote -o a0fcb908a3304f7d8563e22dcd21f6a4<CR>

" Quickfix navigation
noremap ,nn :silent cn<CR>
noremap ,np :silent cp<CR>
noremap ,no :silent copen<CR>
noremap ,nc :silent cclose<CR>

set backup                  " Backups are nice ...
set undofile                " So is persistent undo ...
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

set backupdir=$HOME/.vimbackup//
set viewdir=$HOME/.vimviews//
set directory=$HOME/.vimswap//
set undodir=$HOME/.vimundo//

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
"cunnoremap W
"unnoremap ;
"unnoremap [F
"iunnoremap [F
"unnoremap [H
"iunnoremap [H
"unnoremap <C-e>

"unnoremap $
"unnoremap <End>
"unnoremap 0
"unnoremap <Home>
"unnoremap ^

" Toggle hlsearch
nnoremap <Leader>/ :set hlsearch! hlsearch?<CR>

" CtrlP plugin mapping (why these are not out-of-the-box is beyond me!)"
"nnoremap <Leader>1 :CtrlPBuffer<CR>
"nnoremap <Leader>2 :CtrlPMRUFiles<CR>
"nnoremap <Leader>3 :CtrlP<CR>
"nnoremap <Leader>4 :CtrlP

" Session.vim additional SessionClose mapping
nnoremap ,sc :SessionClose<CR>

" Buffer navigation shortcuts, more friendly than using :
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bw :bwipeout<CR>
nnoremap <Leader>bm :bm<CR>

" fzf based-mappings (buffers, maps, history, ...)
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>fc :History:<CR>
nnoremap <Leader>fs :History/<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>ff :Files<CR>

" Tab helpers
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>

" Quickfix / error window helpers
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent><Leader>co :call ToggleList("Quickfix List", 'c')<CR>

" json formatting through python for visual selection
vnoremap <Leader>jt :!python -m json.tool<CR>

inoremap jj <ESC>

" Remap ' in clojure files
" Remap ' & ` in clojure files since we don't want them to "autoclose"
autocmd BufEnter *.clj inoremap <buffer> ' '
autocmd BufEnter *.clj inoremap <buffer> ` `

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
" Disable mapping since it only applies ot Windows version
"nnoremap <leader>m :call RT_ToggleMaximizedwindow()<CR>

" Private stuff
"source ~/dotfiles/private.vim
