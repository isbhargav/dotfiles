call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug '/tpope/vim-characterize'
" Sensible vim plugins by tpope
Plug 'tpope/vim-sensible' 

" Surround text-objects with quotes or brackets
Plug 'tpope/vim-surround'

" Vim's defacto git integration
Plug 'tpope/vim-fugitive'

" Navigate buffers,quicklist,arglist,locationlist with [,] keys
Plug 'tpope/vim-unimpaired' 

" Pair opening and closing quotes and brackets
Plug 'jiangmiao/auto-pairs'

" Indentation as text-object for languages like python
Plug 'michaeljsmith/vim-indent-object'

" Hilight text on yank
Plug 'machakann/vim-highlightedyank'

" clear last search hightlight
Plug 'isbhargav/vim-clear-highlight'

" Folder drawer based on vim principals
Plug 'justinmk/vim-dirvish'

" Sennsibly set project root
Plug 'airblade/vim-rooter'

" Gist(  make ~/.gist-vim and define g:github_user and g:gist_token varibales
" in it)
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'

" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status line
Plug 'itchyny/lightline.vim'

" ColorScheme
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Comment Plugin
Plug 'tpope/vim-commentary'

" icons
Plug 'kyazdani42/nvim-web-devicons'

" Seamless tmux and vim navigation
Plug 'christoomey/vim-tmux-navigator'

" neovim lsp plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'

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
set cursorline                        " hilight currentline


" Let's save undo info!
" m h  dom mon dow   command
" 43 00 *   *   3     find ~/.vim/undo-dir -type f -mtime +90 -delete
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" Correct typos
aug FixTypos
    :command! WQ wq
    :command! Wq wq
    :command! QA qa
    :command! Qa qa
    :command! W w
    :command! Q q
aug end

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Show diff from last saved changes(:DiffOrign works great with ]c and [c to
" jump to changes)
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
  \ | diffthis | wincmd p | diffthis
endif 


"This unsets the "last search pattern" register by hitting return
" nnoremap <silent> <CR> :noh<CR><CR>
" Disable search highlighting
" nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" add icons to dirvish drawer
call dirvish#add_icon_fn({p -> luaeval("require('nvim-web-devicons').get_icon(vim.fn.fnamemodify('" .. p .. "', ':e')) or ' '")})

"" ColorScheme
set termguicolors     " enable true colors support
" let base16colorspace=256  " Access colors present in 256 colorspace
" set background=dark
" colorscheme gruvbox
colorscheme base16-tomorrow-night-eighties  

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
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>pv :wincmd v<bar> :Dirvish % <bar> :vertical resize 30 <bar> <CR>
" nnoremap <leader>pv :wincmd v<bar> :Dirvish :sil! /expand("%:t")<CR> :vertical resize 30<CR>
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

" Fancy Vscode like move lines (this thing messes with V-Line when key repeat is high)
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" Vim commentry leader+ /
vmap <leader>/ gc
nmap <leader>/ gcc
vmap   //      gc


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)


" Copy to clipbord
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Fzf bindings
nnoremap <leader>fi       :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>rg       :Rg!<C-R><C-W><CR>
nnoremap <leader>ag       :Ag!<C-R><C-W><CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader>B        :Buffers<CR>
nnoremap <leader>W        :Windows<CR>
nnoremap <leader>m        :History<CR>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" -------------------- LSP ---------------------------------
" Treesitter Hiighlighting
:lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

:lua << EOF
local nvim_lsp = require('lspconfig')
local cfg = {
 bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

  hint_enable = true, -- virtual hint enable
  hint_prefix = " ", -- Panda for parameter
  hint_scheme = "String",

  handler_opts = {
    border = "shadow"   -- double, single, shadow, none
  },
  decorator = {"`", "`"}  -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help
}
local on_attach = function(client, bufnr)

  require('completion').on_attach(client)
  require("lsp_signature").on_attach(cfg)

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
      hi LspReferenceRead cterm=bold gui=bold
      hi LspReferenceText cterm=bold gui=bold
      hi LspReferenceWrite cterm=bold gui=bold
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end
local servers = { "pyls", "clangd", "tsserver", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  if lsp == "rust_analyzer" then
        local settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
          }
        }
  nvim_lsp[lsp].setup{ on_attach = on_attach, settings=settings}
  else
  nvim_lsp[lsp].setup{ on_attach = on_attach }
  end
end
EOF


" LSP Saga config
:lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga { }

--  vim.lsp.handlers["textDocument/signatureHelp"] = require('lspsaga.signaturehelp').signature_help
--  vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').render_hover_doc
--  vim.lsp.handlers["textDocument/definition"] = require('lspsaga.provider').preview_definition
--  vim.lsp.handlers['textDocument/codeAction'] = require('lspsaga.codeaction').code_action
EOF

" Lspsaga mappings
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

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
