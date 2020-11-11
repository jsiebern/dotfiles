" Another kind of section
"
" One that sets a few things I might be able to remember
set relativenumber

" Ignoring a smartcase - weird description but mostly desirable havior
set ignorecase
set smartcase
" ------------------------------------------------------------------------

" Create a few reasonable mappings?
nmap j gj
nmap k gk
nmap 0 ^

" ------------------------------------------------------------------------

" I don't know what to call this
" General leader mappings maybe?
let mapleader = "\<Space>"

" I like the idea of quick splits
" Not sure if it will stay that way for long though
nmap <leader>v :vsplit<CR>
nmap <leader>h :split<CR>

" This is going to be vim(r)ception
map <leader>vrc :tabe ~/.vimrc<CR>
autocmd bufwritepost .vimrc source ~/.vimrc

" ------------------------------------------------------------------------

" ------------------------------------------------------------------------

" I have no idea what I'm doing
" This is supposedly a secion
" Apparently "plugin" is a default folder name for vim
" - Interesting
call plug#begin('~/.vim/plugged')

Plug 'moll/vim-bbye'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'amiorin/vim-project'
Plug 'mhinz/vim-startify'
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'ncm2/ncm2'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
Plug 'phpactor/ncm2-phpactor'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/wincent/ferret'
Plug 'neomake/neomake'

" Initialize plugin system
call plug#end()

" Configure neomake to run in different modes depending on battery power
function! OnBattery()
  return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
endfunction
if OnBattery()
  "call neomake#configure#automake('w')
else
  "call neomake#configure#automake('nw', 1000)
endif

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" ---------------------------------------------------------------------------

" I don't even know what's going on anymore
" This is for the fuzzy finder / fuzzy find & replace
nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>

autocmd VimEnter * command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
