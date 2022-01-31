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
Plug 'vim-scripts/DrawIt'
Plug 'dhruvasagar/vim-table-mode'

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
Plug 'ciaranm/inkpot'
Plug 'folke/tokyonight.nvim', { 'branch': 'main'  }


Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" Comment Plugin
Plug 'tpope/vim-commentary'

" icons
Plug 'kyazdani42/nvim-web-devicons'

" Debugging with VIM
Plug 'mfussenegger/nvim-dap'

" neovim lsp plugins
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'ray-x/lsp_signature.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
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
" set termguicolors     " enable true colors support
" let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme tokyonight
" colorscheme base16-solarflare
" colorscheme base16-tomorrow-night

" map leader key
let mapleader = ' '


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
" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <expr> <leader>ff (len(system('git rev-parse')) ? '<cmd>Telescope find_files' : '<cmd>Telescope git_files')."\<cr>"
nnoremap <leader>rg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>t <cmd>Telescope help_tags<cr>
nnoremap <leader>C <cmd>Telescope colorscheme<cr>

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

" Vsnip
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50

" nmap        s   <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']



"-------------------------------- Telsscope Config ------------------------
:lua << EOF
local actions = require("telescope.actions")


require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc><esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
})
EOF
" -------------------- tree-sitter config :h nvim ---------------------------------
lua << EOF
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

EOF

" ------------------------ configuration for nvim-cmp ---------------------------------------
:lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  --  attach lsp-signature
  local on_attach = function(client, bufnr)
  end

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- Setup lspconfig.
  local nvim_lsp = require('lspconfig')
  local servers = { "pyright", "clangd", "tsserver"}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup{
      capabilities = capabilities
    }
  end

  require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  })

EOF


" ----------------------- Configurations for Rust tools ---------------------
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
            other_hints_prefix  = "» ",

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
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
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


" " Completion

" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" " Avoid showing message extra message when using completion
" set shortmess+=c
" let g:completion_enable_auto_hover = 1
" let g:completion_enable_auto_signature = 1
"-------------------- LSP ---------------------------------

 nnoremap <silent> gd        :lua vim.lsp.buf.definition()<CR>
 nnoremap <silent> gD        :lua vim.lsp.buf.declaration()<CR>
 nnoremap <silent> K         :lua vim.lsp.buf.hover()<CR>
 nnoremap <silent> gi        :lua vim.lsp.buf.implementation()<CR>
 nnoremap <silent> gs     :lua vim.lsp.buf.signature_help()<CR>
 nnoremap <silent> <space>wa :lua vim.lsp.buf.add_workspace_folder()<CR>
 nnoremap <silent> <space>wr :lua vim.lsp.buf.remove_workspace_folder()<CR>
 nnoremap <silent> <space>wl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
 nnoremap <silent> <space>D  :lua vim.lsp.buf.type_definition()<CR>
 nnoremap <silent> <space>rn :lua vim.lsp.buf.rename()<CR>
 nnoremap <silent> gr        :lua vim.lsp.buf.references()<CR>
 nnoremap <silent> <space>e  :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
 nnoremap <silent> [d        :lua vim.lsp.diagnostic.goto_prev()<CR>
 nnoremap <silent> ]d        :lua vim.lsp.diagnostic.goto_next()<CR>
 nnoremap <silent> <space>q  :lua vim.lsp.diagnostic.set_loclist()<CR>
 nnoremap <silent> gs        :G<cr>
