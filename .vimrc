set relativenumber	   " Use Relative Numbering
set nu			   " Use Simple Numbering
set nowrap		   " Set nowrap

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.


"This is the node path for Coc
let g:coc_node_path = '/Users/bhargavlad/.nvm/versions/node/v14.4.0/bin/node'

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR><CR>


call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sensible' 
Plug 'tpope/vim-surround'
Plug  'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Status line
Plug 'itchyny/lightline.vim'

" Monokai
Plug 'reewr/vim-monokai-phoenix'

" Comment Plugin
Plug 'tpope/vim-commentary'

" Initialize plugin system
call plug#end()

" ColorScheme
colorscheme monokai-phoenix

" map leader key
let mapleader = ' '

" Switch Windows with leader+ hjkl
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" :NERDTreeToggle on ctrl+n
nmap <C-n> :NERDTreeToggle<CR>

" Switch between tabs for NERDTree
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt


" Select pasted last pasted similar to gv
nnoremap gp `[v`]

" Vim commentry leader+ /
vmap <leader>/ gc
nmap <leader>/ gcc
vmap // gc


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Vim magic for Regex
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//


" ======= Minimal coc settings
filetype plugin indent on
set updatetime=300
set shortmess+=c

" Use leader T to show documentation in preview window
nnoremap <leader>t :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" instead of having ~/.vim/coc-settings.json
let s:LSP_CONFIG = {
      \  'flow': {
      \    'command': exepath('flow'),
      \    'args': ['lsp'],
      \    'filetypes': ['javascript', 'javascriptreact'],
      \    'initializationOptions': {},
      \    'requireRootPattern': 1,
      \    'settings': {},
      \    'rootPatterns': ['.flowconfig']
      \  }
      \}

let s:languageservers = {}
for [lsp, config] in items(s:LSP_CONFIG)
  let s:not_empty_cmd = !empty(get(config, 'command'))
  if s:not_empty_cmd | let s:languageservers[lsp] = config | endif
endfor

if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif

