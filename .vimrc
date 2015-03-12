syntax on
set ignorecase
set mouse=a
set paste
set expandtab
set autoindent
set shiftwidth=2
set tabstop=2
set hlsearch
au FileType scm call PareditInitBuffer()
filetype plugin indent on
set foldmethod=indent

" comment?
"au BufRead * normal zR
