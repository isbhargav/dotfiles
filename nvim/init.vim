call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'

" upper/lower/mixed/camel/title cra
Plug 'tpope/vim-abolish'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'

" split and join line depending on programmning language(gJ & gS)
Plug 'AndrewRadev/splitjoin.vim'

" better traget with f & t 
Plug 'unblevable/quick-scope'

" Better moving accoss the file
Plug 'easymotion/vim-easymotion'

" Multi Cursor support in vim
Plug 'terryma/vim-multiple-cursors'

" Sensible vim plugins by tpope
Plug 'tpope/vim-sensible' 

" Surround text-objects with quotes or brackets
Plug 'tpope/vim-surround'

" Vim's defacto git integration
Plug 'tpope/vim-fugitive'

"Shows a git diff in the sign column (<leader>hp - preview change)
" Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

" Navigate buffers,quicklist,arglist,locationlist with [,] keys
Plug 'tpope/vim-unimpaired' 

" Pair opening and closing quotes and brackets
Plug 'jiangmiao/auto-pairs'

" Swap arguments
Plug 'AndrewRadev/sideways.vim'
Plug 'tommcdo/vim-exchange'

" Indentation as text-object for languages like python
Plug 'michaeljsmith/vim-indent-object'

" Hilight text on yank
Plug 'machakann/vim-highlightedyank'

" clear last search hightlight
Plug 'isbhargav/vim-clear-highlight'

" color css hex code
Plug 'norcalli/nvim-colorizer.lua'

" Folder drawer based on vim principals
Plug 'tpope/vim-vinegar'
" Plug 'justinmk/vim-dirvish'

" Sennsibly set project root
Plug 'airblade/vim-rooter'

" Gist(  make ~/.gist-vim and define g:github_user and g:gist_token varibales
" in it)
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'
Plug 'vim-scripts/DrawIt'
Plug 'dhruvasagar/vim-table-mode'

" fuzzy search
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }


" Status line
Plug 'itchyny/lightline.vim'

" Undo tree <leader>ut
Plug 'simnalamburt/vim-mundo'

" ColorScheme
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'ciaranm/inkpot'
Plug 'folke/tokyonight.nvim', { 'branch': 'main'  }
Plug 'sainnhe/sonokai'


" TreeSitter plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Context
Plug 'nvim-treesitter/nvim-treesitter-context'

" provide additional text objects
" Plug 'wellle/targets.vim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Comment Plugin
" Plug 'tpope/vim-commentary'
Plug 'numToStr/Comment.nvim'
" comment for embedded languages in certain types of files.
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" icons
Plug 'kyazdani42/nvim-web-devicons'

" Debugging with VIM
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" neovim lsp plugins
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" REPL-like environment for developing lua plugins in Nvim
Plug 'bfredl/nvim-luadev'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'

" Lsp install (order here matter mason, mason-lspconfig, nvim-lspconfig)
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'

Plug 'simrat39/rust-tools.nvim'
" Initialize plugin system
call plug#end()

set enc=utf-8
set emo
set relativenumber                    " Use Relative Numbering
set nu                                " Use Simple Numbering
set nowrap                            " disable wrap for long lines
set mouse=a                           " Scroll with Mouse pad

set expandtab                         " replace <Tab> with spaces
set tabstop=2                         " number of spaces that a <Tab> in the file counts for
set softtabstop=2                     " remove <Tab> symbols as it was spaces
set shiftwidth=2                      " indent size for << and >>
set shiftround                        " round indent to multiple of 'shiftwidth' (for << and >>)
set smartindent                       " Smart indent

set scrolloff=999                     " always keep cursor at the middle of screen
set noswapfile                        " disable creating of *.swp files
set hidden                            " hide buffers instead of closing
set ignorecase                        " Use case insensitive search, except when using capital letters
set smartcase                         " Must be used with ignorecase inoreder to work
set inccommand=nosplit                " Live feedback for s/pat/replace(Only for Neovim)
set path+=**                          " Search all the subdirectories recursively
set path+=~/.config/nvim/init.vim     " Add init.vim to path
set dictionary+=/usr/share/dict/words " dictionary completion
set noshowmode                        " status bar displays mode so no need for vim
" set cursorline                        " hilight currentline
packadd cfilter

" Let's save undo info!
" m h  dom mon dow   command
" 43 00 *   *   3     find ~/.vim/undo-nvim -type f -mtime +90 -delete
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-nvim")
    call mkdir($HOME."/.vim/undo-nvim", "", 0700)
endif

" delete undo dir on every 15 of month
" Delete files inside undo dir after 90 days (Cleanup)
if system("date +%d") == 15
    call system("find ".$HOME."/.vim/undo-nvim"." -type f -mtime +90 -delete")
endif

set undodir=~/.vim/undo-nvim
set undofile

" Correct typos
aug FixTypos
    :command! WQ wq
    :command! Wq wq
    :command! QA qa
    :command! Qa qa
    :command! W  w
    :command! Q  q
    :cmap     Q! q!
aug end



let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
      \ ,
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '<%b> 0x%B'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Show diff from last saved changes(:DiffOrign works great with ]c and [c to jump to changes)
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
  \ | diffthis | wincmd p | diffthis
endif 


"This unsets the "last search pattern" register by hitting return
" nnoremap <silent> <CR> :noh<CR><CR>
" Disable search highlighting
" nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

"" ColorScheme
set termguicolors     " enable true colors support
" let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme tokyonight
" colorscheme base16-solarflare
" colorscheme base16-tomorrow-night

" map leader key
let mapleader = ' '

 " ----------------------- Git status keymap
 nnoremap <silent> <leader>gs    :G<cr>

" Zoom a split window in a tab/ close it
nnoremap <leader>,zo :tabnew %<cr>
nnoremap <leader>,zc :tabclose<cr>

" Switch Windows with leader+ hjkl
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vert split<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>


" Switch between buffers and tabs 
nmap <leader><tab> <C-^>
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" Short mappings for common tasks
" Ctrl-j/k works as Ctrl-d/u
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
" nnoremap <C-j> <C-n>
" nnoremap <C-k> <C-p>

noremap j gj
noremap k gk
noremap 0 ^
noremap ^ 0

" Keeps the current visual block selection active after changing indent
vmap > >gv
vmap < <gv

"playback with Q
nnoremap Q @q

" Select pasted last pasted similar to gv
nnoremap gp `[v`]

" Mundo keymap
nnoremap <leader>ut :MundoToggle<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
nmap <leader>a <Plug>(LiveEasyAlign)
vmap <leader>a <Plug>(LiveEasyAlign)

" vim sideways plugin
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

" quick-scope
nmap <leader>q <Plug>(QuickScopeToggle)
vmap <leader>q <Plug>(QuickScopeToggle)

" Table Mode
nnoremap <leader>ti :TableModeEnable<cr>
nnoremap <leader>ts :TableModeDisable<cr>

" Easy Motion
" s{char}{char} to move to {char}{char}
nmap <leader><leader>s <Plug>(easymotion-overwin-f2)

" Copy to clipbord
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Telescope bindings
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <expr> <leader>ff (len(system('git rev-parse')) ? '<cmd>Telescope find_files' : '<cmd>Telescope git_files')."\<cr>"
nnoremap <leader>fd <cmd>Telescope find_files<cr>
nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>rg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>ht <cmd>Telescope help_tags<cr>
nnoremap <leader>C <cmd>Telescope colorscheme<cr>


"           _                   ____             __ _       
"          | |   _   _  __ _   / ___|___  _ __  / _(_) __ _ 
"          | |  | | | |/ _` | | |   / _ \| '_ \| |_| |/ _` |
"          | |__| |_| | (_| | | |__| (_) | | | |  _| | (_| |
"          |_____\__,_|\__,_|  \____\___/|_| |_|_| |_|\__, |
"                                                     |___/ 
"          
           
" -------------------------------- comment.nvim setup
lua require('comment-setup')
" -------------------------------- comment.nvim setup
lua require('gitsigns-setup')
"-------------------------------- Telsscope Config ---------------------------------------------------------------------
lua require('telescope-setup')
" ----------------------- Configurations for Rust tools ------------------------------------------------------------------
" lua require('rustools-setup')
" ------------------------- Colorizer setup     ---------------
lua require('colorizer-setup')
" -------------------- tree-sitter config :h nvim ---------------------------------------------------------------------
lua require('treesitter-setup')
" -------------------- tree-sitter text objects ---------------------------------------------------------------------
lua require('text-objects-treesitter')
" -------------------- tree-sitter context ---------------------------------------------------------------------
lua require('treesitter-context-setup')
" ------------------------ configuration for lsp + nvim-cmp + lspkind ------------------------------------------------
lua require('completion-setup')
" ----------------------- Configurations for Rust tools ------------------------------------------------------------------
lua require('utils')
"-------------------- LSP dap ---------------------------------------------------------------------------------------
lua require('nvim-dap-setup')

" REPL live env
nnoremap <silent><leader>x :source % <cr>

