execute pathogen#infect()
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set nu
set tabstop=4
set shiftwidth=4
set background=dark
set colorcolumn=80
colorscheme solarized
map <C-n> :NERDTreeToggle<CR>
let filetype_m = "mma"
set guifont=Source_Code_Pro_Light:h11:cANSI

"disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"Remap ii to ESC
imap ii <Esc>
