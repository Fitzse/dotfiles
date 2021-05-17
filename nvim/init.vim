set nocompatible
set autowrite
set hidden
filetype off

" Load Plugins
source $HOME/repositories/dotfiles/nvim/plugins.vim

" Map Leader
let mapleader=" "

" Disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Indents
set smartindent
set smarttab
set smartcase
set autoindent
set expandtab
set tabstop=4

" Line Numbers
set number

" Syntax
syntax on
filetype plugin indent on
set showmatch

" Colours
set termguicolors

set background=dark
colorscheme one
let g:one_allow_italics = 1

" Default to 2 spaces per tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <Leader>e :NERDTreeFind<CR>
let NERDTreeIgnore=['\.class', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.o']
let NERDTreeQuitOnOpen=1

" fzf
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>g :Rg<CR>

" Airline
set laststatus=2
let g:airline_theme='one'

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1

" Status line types/signatures
let g:go_auto_type_info = 1

" Quickfix lists for Build/Test errors
let g:go_list_type = "quickfix"

" Go Commands
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')

autocmd FileType go nmap <Leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>t  <Plug>(go-test)

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
