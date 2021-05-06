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
set inccommand=nosplit     " Live feedback for s/pat/replace(Only for Neovim)
set path+=~/.config/nvim/init.vim
set path+=**               " Search all the subdirectories recursively

set dictionary+=/usr/share/dict/words  " dictionary completion
" Correct typos
aug FixTypos
    :command! WQ wq
    :command! Wq wq
    :command! QA qa
    :command! Qa qa
    :command! W w
    :command! Q q
aug end

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
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired' 
Plug 'jiangmiao/auto-pairs'
Plug 'michaeljsmith/vim-indent-object'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-vinegar'


" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status line
Plug 'itchyny/lightline.vim'

" Monokai
" Plug 'reewr/vim-monokai-phoenix'
" Plug 'ayu-theme/ayu-vim'
Plug 'lifepillar/vim-gruvbox8'

" Comment Plugin
Plug 'tpope/vim-commentary'

" neovim lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'

" Initialize plugin system
call plug#end()

" ColorScheme
set termguicolors     " enable true colors support
set background=dark
colorscheme gruvbox8_hard

" map leader key
let mapleader = ' '


" Zoom a split window in a tab/ close it
nnoremap <leader>,zo :tabnew %<cr>
nnoremap <leader>,zc :tabclose<cr>

" Switch Windows with leader+ hjkl
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>


" Switch between tabs 
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


" Vim commentry leader+ /
vmap <leader>/ gc
nmap <leader>/ gcc
vmap   //      gc


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Fzf
nnoremap <leader>p        :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>rg       :Rg! <C-R><C-W><CR>
nnoremap <leader>ag       :Ag! <C-R><C-W><CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader>B        :Buffers<CR>
nnoremap <leader>W        :Windows<CR>
nnoremap <leader>m        :History<CR>

" -------------------- LSP ---------------------------------

:lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF

:lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)

  require('completion').on_attach(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')


  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end
local servers = { "pyright", "clangd", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup{ on_attach = on_attach }
end

EOF


" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1
" -------------------- LSP ---------------------------------f
