call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'

" upper/lower/mixed/camel/title cra
Plug 'tpope/vim-abolish'

" split and join line depending on programmning language(gJ & gS)
Plug 'AndrewRadev/splitjoin.vim'

" better traget with f & t 
Plug 'unblevable/quick-scope'

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

" provide additional text objects
Plug 'wellle/targets.vim'

" Swap arguments
Plug 'AndrewRadev/sideways.vim'

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

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


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
Plug 'vim-scripts/YankRing.vim'

" neovim lsp plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
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

let g:yankring_history_file = '.vim/yankring_history/yankring_history'
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


" abbreviations 
" Debug function for C++
iabbrev cdebug 
\<cr>void __print(int x) {cerr << x;}
\<cr>void __print(long x) {cerr << x;}
\<cr>void __print(long long x) {cerr << x;}
\<cr>void __print(unsigned x) {cerr << x;}
\<cr>void __print(unsigned long x) {cerr << x;}
\<cr>void __print(unsigned long long x) {cerr << x;}
\<cr>void __print(float x) {cerr << x;}
\<cr>void __print(double x) {cerr << x;}
\<cr>void __print(long double x) {cerr << x;}
\<cr>void __print(char x) {cerr << '\'' << x << '\'';}
\<cr>void __print(const char *x) {cerr << '\"' << x << '\"';}
\<cr>void __print(const string &x) {cerr << '\"' << x << '\"';}
\<cr>void __print(bool x) {cerr << (x ? "true" : "false");}
\<cr>
\<cr>template<typename T, typename V>
\<cr>void __print(const pair<T, V> &x) {cerr << '{'; __print(x.first); cerr << ','; __print(x.second); cerr << '}';}
\<cr>template<typename T>
\<cr>void __print(const T &x) {int f = 0; cerr << '{'; for (auto &i: x) cerr << (f++ ? "," : ""), __print(i); cerr << "}";}
\<cr>void _print() {cerr << "]\n";}
\<cr>template <typename T, typename... V>
\<cr>void _print(T t, V... v) {__print(t); if (sizeof...(v)) cerr << ", "; _print(v...);}
\<cr>#ifndef ONLINE_JUDGE
\<cr>#define debug(x...) cerr << "[" << #x << "] = ["; _print(x)
\<cr>#else
\<cr>#define debug(x...)
\<cr>#endif
\<cr> //


let g:lightline = {
      \ 'colorscheme': 'default',
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

" add icons to dirvish drawer
call dirvish#add_icon_fn({p -> luaeval("require('nvim-web-devicons').get_icon(vim.fn.fnamemodify('" .. p .. "', ':e')) or ' '")})

"" ColorScheme
set termguicolors     " enable true colors support
let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
" colorscheme gruvbox
" colorscheme base16-solarflare
colorscheme base16-tomorrow-night

" map leader key
let mapleader = ' '

" NERDtree like setup for Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" Open automaticaly 
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>



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

noremap j gj
noremap k gk
noremap 0 ^
noremap ^ 0

" Keeps the current visual block selection active after changing indent
vmap > >gv
vmap < <gv

"playback with Q
nnoremap Q @q

" Y similar to C and D in normal mode
nnoremap Y yg_

" reamap of z=
nnoremap <leader>=

" Insert at the beging or end in visual-line selection using I or A
vnoremap I <C-V>0I
vnoremap A <C-V>$A


" Select pasted last pasted similar to gv
nnoremap gp `[v`]

" Fancy Vscode like move lines (this thing messes with V-Line when key repeat is high)
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Right>  xpgvlolo
vnoremap <S-left>   xhPgvhoho
" vnoremap <S-Down>   xjPgvjojo
" vnoremap <S-Up>     xkPgvkoko

" Vim commentry leader+ /
vmap <leader>/ gc
nmap <leader>/ gcc
vmap   //      gc


" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
nmap <leader>e <Plug>(EasyAlign)
vmap <leader>e <Plug>(EasyAlign)

" vim sideways plugin
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

" quick-scope
nmap <leader>q <Plug>(QuickScopeToggle)
vmap <leader>q <Plug>(QuickScopeToggle)

" Copy to clipbord
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p


" Fzf bindings
nnoremap <leader>ff       :Files<CR> 
nnoremap <leader>pf       :GFiles<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>bl       :BLines<CR>
nnoremap <leader>bb       :Buffers<CR>
nnoremap <leader>ww       :Windows<CR>
nnoremap <leader>*        :Rg <C-R><C-W><CR>
nnoremap <leader>rg       :Rg!<CR>
nnoremap <leader>ag       :Ag!<C-R><C-W><CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader>m        :History<CR>

" Telescope bindings
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>

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

vim.o.completeopt = "menuone,noinsert,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

:lua << EOF

local nvim_lsp = require('lspconfig')
local cfg = {
 bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

  hint_enable = true, -- virtual hint enable
  hint_prefix = "??? ", -- Panda for parameter
  hint_scheme = "String",

  handler_opts = {
    border = "shadow"   -- double, single, shadow, none
  },
  decorator = {"`", "`"}  -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help
}
require("lsp_signature").on_attach(cfg)

local servers = { "pyright", "clangd", "tsserver"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup{}
end
EOF
 
" nvim-compe mapping
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

:lua << EOF
local opts = {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = false

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"???", "FloatBorder"},
              {"???", "FloatBorder"},
              {"???", "FloatBorder"},
              {"???", "FloatBorder"},
              {"???", "FloatBorder"},
              {"???", "FloatBorder"},
              {"???", "FloatBorder"},
              {"???", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    -- server = {}, -- rust-analyer options
}

require('rust-tools').setup(opts)

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
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> [d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

" " Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " Set completeopt to have a better completion experience
" set completeopt= menuone,noinsert,noselect

" " Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1
"-------------------- LSP ---------------------------------f
