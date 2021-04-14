set relativenumber	       " Use Relative Numbering
set nu			           " Use Simple Numbering
set nowrap                 " disable wrap for long lines
set mouse=a                " Scroll with Mouse pad

set expandtab              " replace <Tab with spaces
set tabstop=2              " number of spaces that a <Tab> in the file counts for
set softtabstop=2          " remove <Tab> symbols as it was spaces
set shiftwidth=2           " indent size for << and >>
set shiftround             " round indent to multiple of 'shiftwidth' (for << and >>)
set smartindent            " Smart indent

set scrolloff=999          " always keep cursor at the middle of screen
set noswapfile             " disable creating of *.swp files
set hidden                 " hide buffers instead of closing
set ignorecase             " Use case insensitive search, except when using capital letters
set smartcase              " Must be used with ignorecase inoreder to work


"This is the node path for Coc (becuse I use fish-nvm it delays the loading of
"node in our environment)
"The work around of this is to execute `nvm_alias_command` command then
"you won't need to use below line.
" let g:coc_node_path = '/Users/bhargavlad/.nvm/versions/node/v14.4.0/bin/node'



"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR><CR>
" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>


call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-sensible' 
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'


" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status line
Plug 'itchyny/lightline.vim'

" Monokai
Plug 'reewr/vim-monokai-phoenix'

" Comment Plugin
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-vividchalk'

" Initialize plugin system
call plug#end()

" ColorScheme
colorscheme monokai-phoenix
" colorscheme vividchalk

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

" Vscode like move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" QuickFix List (open :copen)
nnoremap <C-j>  :cnext<CR>
nnoremap <C-k>  :cprev<CR>

" Vim commentry leader+ /
vmap <leader>/ gc
nmap <leader>/ gcc
vmap   //      gc


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Fzf
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>rg       :Rg! <C-R><C-W><CR>
nnoremap <leader>ag       :Ag! <C-R><C-W><CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader>B        :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>m        :History<CR>

" Vim magic for Regex don't need it if you use ignorecase and smart case
" nnoremap / /\v
" vnoremap / /\v
" cnoremap %s/ %smagic/
" cnoremap \>s/ \>smagic/
" nnoremap :g/ :g/\v
" nnoremap :g// :g//


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


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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


if has('nvim') && !empty($CONDA_PREFIX)
  let s:current_python_path = $CONDA_PREFIX . '/bin/python'
  " let s:anaconda_envs = $CONDA_PREFIX_1 . '/envs'
  call coc#config('python', {'pythonPath': s:current_python_path})
  " call coc#config('python', {'venvPath': s:anaconda_envs})
endif

" if Conda not activated use pyenv else use conda coc-python
" if $CONDA_PREFIX == ""
"   if $VIRTUAL_ENV == ""
"     " let s:current_python_path=$PYENV_ROOT.'/shims/python'
"     let g:python3_host_prog =$PYENV_ROOT.'/shims/python'
"   else
"     " let s:current_python_path=$VIRTUAL_ENV.'/bin/python'
"     let g:python3_host_prog =$VIRTUAL_ENV.'/bin/python'
" endif
" else
"   " let s:current_python_path=$CONDA_PREFIX.'/bin/python'
"   let g:python3_host_prog=$CONDA_PREFIX.'/bin/python'
" endif
" call coc#config('python', {'pythonPath': s:current_python_path})
