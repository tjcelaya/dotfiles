"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/home/tj/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/tj/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'elixir-lang/vim-elixir'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


syntax on
set ignorecase
set mouse=a
set paste
set nowrap
set expandtab
set autoindent
set shiftwidth=2
set tabstop=2
set hlsearch
set foldmethod=indent


" unfold all folds when opening files
au BufRead * normal zR

command! W :w

set number
set numberwidth=5
set cursorline
set cursorcolumn
set backspace=indent,eol,start
let mapleader = ','

" make tab in normal mode go to next file, shfit tab previous

nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" normal mode space scrolls page
noremap <space> <C-f>

" insert mode: Ctrl-Z is undo
imap <C-Z> <Esc>ui
imap <tab> <C-p>

imap jj <Esc>

" make tab in visual mode indent, shift-tab dedent
vmap <tab> >gv
vmap <s-tab> <gv

set wildmenu
set wildmode=longest:list,full

hi CursorLine cterm=NONE ctermbg=grey ctermfg=NONE

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
