--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- use trash cli
if vim.fn.executable('trash-put --help') == 1 then
  vim.g.netrw_localrmdir = 'trash-put -d'
end
-- Fix Typos
vim.cmd([[
aug FixTypos
:command! WQ wq
:command! Wq wq
:command! QA qa
:command! Qa qa
:command! W  w
:command! Q  q
:cmap     Q! q!
aug end
]])

--        _             _
--  _ __ | |_   _  __ _(_)_ __  ___
-- | '_ \| | | | |/ _` | | '_ \/ __|
-- | |_) | | |_| | (_| | | | | \__ \
-- | .__/|_|\__,_|\__, |_|_| |_|___/
-- |_|            |___/
--
--
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Common utils that most plugins rely on
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "rcarriga/nvim-notify",
  {
    'rcarriga/nvim-notify',
    opts= {
      minimum_width = 25,
      render = 'minimal',
      timeout = 2000,
    },
    config= function()
      vim.notify = require("notify")
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
  },
  --  -- Unlist hidden buffers that are git ignored.
  -- {
  --   'sQVe/bufignore.nvim',
  --   config = true,
  --   event = { 'BufRead', 'BufWrite' },
  -- },

  -- Root
  'airblade/vim-rooter',
  {
    "klen/nvim-config-local",
    opts = {
      -- Default configuration (optional)
      config_files = { "init.lua","vimrc.lua", ".vimrc" },            -- Config file patterns to load (lua supported)
      hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
      autocommands_create = true,                           -- Create autocommands (VimEnter, DirectoryChanged)
      commands_create = true,                               -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
      silent = false,                                       -- Disable plugin messages (Config loaded/ignored)
      lookup_parents = false,                               -- Lookup config files in parent directories
    }
  },

  -- Git related plugins
  'tpope/vim-rhubarb',
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = { { "<leader>gs", "<cmd>Git<cr>", desc = "[G]it [S]tatus" } },
  },
  {
    "junegunn/gv.vim",
    dependencies = { "tpope/vim-fugitive" },
    cmd = { "Git", "GV" },
    keys = { { "<leader>gv", "<cmd>GV<cr>", desc = "[G]it [V]ertical Graph" } },
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- from tpope's vault
  'tpope/vim-unimpaired',
  "tpope/vim-dispatch",
  'tpope/vim-eunuch',
  'tpope/vim-abolish',
  -- 'tpope/vim-vinegar',
  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- align text
  {
    'junegunn/vim-easy-align',
    init = function()
      -- nmap <leader>a <Plug>(LiveEasyAlign)
      -- vmap <leader>a <Plug>(LiveEasyAlign)
      vim.keymap.set({ 'n', 'v' }, '<leader>e', '<Plug>(LiveEasyAlign)')
    end
  },

  -- netrw upgrade
  { 'prichrd/netrw.nvim',
    config = true,
    dependencies = {
    'tpope/vim-vinegar',
    "nvim-tree/nvim-web-devicons",
    },
  },
  -- persistance undo
  {
    'mbbill/undotree',
    config=function()
      vim.cmd('let g:undotree_WindowLayout = 2')
    end,
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" } },
  },
  -- tmux naigator
  'christoomey/vim-tmux-navigator',
  -- execute selection in tmux pane
  {
    "jpalardy/vim-slime",
    config = function()
      vim.cmd([[ let g:slime_target = "tmux" ]])
      vim.cmd([[ let g:slime_default_config = {"socket_name": "default", "target_pane": ".2"} ]])
      vim.cmd([[ let g:slime_dont_ask_default = 1 ]])
    end
  },
  -- OSCYank
  {
    'ojroques/nvim-osc52',
    branch = 'main',
    config = function()
      require('osc52').setup {
        max_length = 0,      -- Maximum length of selection (0 for no limit)
        silent     = false,  -- Disable message on successful copy
        trim       = false,  -- Trim surrounding whitespaces before copy
      }

      vim.g.oscyank_term = 'default' -- or 'screen', 'kitty', 'tmux'
      -- vim.keymap.set({ 'n', 'v' }, '<leader>c', '<cmd>OSCYank<cr>', { noremap=true})
      -- vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, { expr = true })
      -- vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
      -- vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

      vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
      vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
      vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
    end
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true
  },

  -- auto pair
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = true,
  },

  -- harpoon files
  {
    'ThePrimeagen/harpoon',
    dependencies = 'nvim-lua/plenary.nvim',
    lazy=false,
    config=true,
    keys={
      {'<leader>p', ':lua require("harpoon.ui").toggle_quick_menu()<cr>', desc ='Toggle Harpoon UI'},
      {'<leader>o', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<cr>', desc ='Toggle Harpoon UI'},
      {'<C-p>', ':lua require("harpoon.mark").add_file()<cr>', desc = 'Mark File for Harpoon'}
    }
  },

  -- vim test
  {
    'vim-test/vim-test',
    config = function()
      --  Brazil compatiible VIM Test for python packages
      vim.cmd([[
              let test#python#runner = 'pytest'
              let test#python#pytest#executable = 'brazil-test-exec pytest -v -s '
              " let test#python#pytest#executable = 'brazil-test-exec pytest -v -s --pdbcls=IPython.terminal.debugger:TerminalPdb'
              ]])

      -- change command
      vim.cmd([[
              let test#javascript#reactscripts#executable = "TZ=UTC npx react-scripts test --verbose --transformIgnorePatterns \"node_modules/(?!(@amzn/awsui-)).+\\.js$\" --timers modern --watchAll=false"
              ]])
      --
      -- " let test#javascript#runner = 'jest'
      -- " let test#javascript#pytest#executable = 'brazil-build react-scripts test'


      -- for neovim
      vim.cmd([[
              let test#strategy = "neovim"
              let test#neovim#term_position = "vert botright"
              ]])

      --Vim-test mappings
      vim.keymap.set('n', '<leader>t', ':TestNearest<CR>')
      vim.keymap.set('n', '<leader>T', ':TestFile<CR>')
      vim.keymap.set('n', '<leader>l', ':TestLast<CR>')
      vim.keymap.set('n', '<leader>g', ':TestVisit<CR>')
      vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')
    end
  },
  -- diffview
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        group    = vim.api.nvim_create_augroup('bufcheck_gv', { clear = true }),
        pattern  = 'GV',
        callback = function()
          vim.keymap.set('n', ',', function()
            local curr_line = vim.api.nvim_get_current_line()
            local _, sha, _ = string.match(curr_line, '(^*%d%d%d%d--%d%d--%d%d%s)(%x+)(%s.*)')
            if sha ~= nil then
              vim.api.nvim_input(':DiffviewOpen ' .. sha .. '^!')
              -- vim.api.nvim_command(':DiffviewOpen '.. sha .. '^!' )
              -- return '<Cmd>DiffviewOpen '.. sha .. '^!'
            end
          end)
        end
      })
    end
  },

  -- hex colors
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },


  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {'williamboman/mason.nvim',  config=true},
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {},
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    event = "BufReadPre",
    opts = {
      autocmd = { enabled = true },
    },
  },
  -- {
  --   'weilbith/nvim-code-action-menu',
  --   cmd = 'CodeActionMenu',
  --   keys = { { "<leader>C", "<cmd>CodeActionMenu<cr>", desc = "[C]ode Action Menu" } }
  -- },

  -- -- Navigate file symbols
  -- {
  --   "SmiteshP/nvim-navbuddy",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "SmiteshP/nvim-navic",
  --     "MunifTanjim/nui.nvim"
  --   },
  --   cmd = "SymbolsOutline",
  --   keys = { { "<leader>nb", "<cmd>Navbuddy<cr>", desc = "Nav buddy" } }
  -- },
  {
    'Maan2003/lsp_lines.nvim',
    enabled=false,
    config=true,
    event = "VeryLazy",
    init= function()
      -- require 'lsp_lines'.setup()
      local DEFAULT_CONFIG = {
        virtual_text = true,
        virtual_lines = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
        },
      }

      local Mode = {
        "Default",
        "Lines",
      }

      local current_mode = 1

      vim.keymap.set("n", "<M-d>", function()
        current_mode = (current_mode % #Mode) + 1
        if Mode[current_mode] == "Default" then
          vim.diagnostic.config(DEFAULT_CONFIG)
        elseif Mode[current_mode] == "Lines" then
          vim.diagnostic.config {
            virtual_lines = true,
            virtual_text = false,
            warden = {
              line_highlight = true,
            },
            underline = true,
            signs = false,
            severity_sort = true,
            float = {
              header = false,
              source = "always",
            },
          }
        end
      end, { desc = "Toggle lsp_lines" })
    end
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      -- manage_folds = true,
      width = 40,
      default_direction = "right",
      placement = "edge",
    },
    event = "VeryLazy",
    keys = { { "<leader>nb", "<cmd>AerialToggle!<CR>", desc = "Nav" } },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  -- hilight word under cursor
  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('illuminate').configure({
        delay = 250,
        modes_allowlist = { 'n' },
        providers = { 'treesitter' },
      })
    end
  },

  -- null-ls basic
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        debug = true, -- This will slow down Nivm
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- Spell Checker
          nls.builtins.diagnostics.cspell.with({
            -- Force the severity to be HINT
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
          }),
          nls.builtins.code_actions.cspell,

          -- Typescript
          nls.builtins.diagnostics.eslint_d,
          nls.builtins.code_actions.eslint_d,
          nls.builtins.formatting.eslint_d, -- use prettier
          nls.builtins.formatting.prettierd,

          -- Python
          -- nls.builtins.formatting.black.with({
          --   extra_args = { "--fast", "-config","pyproject.toml" }
          -- }),
          nls.builtins.formatting.black,
          nls.builtins.formatting.isort,
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.flake8,

          -- bash
          nls.builtins.diagnostics.shellcheck ,
          nls.builtins.code_actions.shellcheck,
        },
      }
    end,
  },
 {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { },
    keys = {
      -- { "<leader>xx", function() require("trouble").open() end, "Workspace Diagnostics (Trouble" },
      { "<leader>xw", function() require("trouble").open("workspace_diagnostics") end, desc="Workspace Diagnostics (Trouble" },
      { "<leader>xd", function() require("trouble").open("document_diagnostics") end , desc="Document Diagnostics (Trouble"},
      { "<leader>xq", function() require("trouble").open("quickfix") end, desc="QuickFix List (Trouble)" },
      { "<leader>xl", function() require("trouble").open("loclist") end , desc="Location List (Trouble)"},
      -- { "gR", function() require("trouble").open("lsp_references") end },
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- Addition completion sources
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
  },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]c", gs.next_hunk, "Next Hunk")
        map("n", "[c", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map('n', '<leader>td', gs.toggle_deleted, "Toggle Deleted")

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    }
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufRead',
    opts ={
      disable_diagnostics = true,
      highlights = {
        incoming = 'DiffChange',
        current = 'DiffAdd',
      },
    }
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    "shaunsingh/oxocarbon.nvim",
  },
  {
    "ellisonleao/gruvbox.nvim",
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'gruvbox'
    -- end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = true
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_end_of_line = true,
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',   opts = {} },
  -- doc gen
  {
    'kkoomen/vim-doge',
    build = ':call doge#install()',
    config = function()
      vim.cmd([[let g:doge_mapping='<Leader>dc']])
    end
  },
  -- swap places of siblings
  {
    'Wansmer/sibling-swap.nvim',
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('sibling-swap').setup({ --[[ your config ]] })
    end,
  },
  -- targets vim alternative
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function() require('mini.ai').setup() end,
  },
  --
  -- split/join lines
  {
    "Wansmer/treesj",
    keys = {
      { "gJ", "<cmd>TSJJoin<cr>",  desc = "Join Line" },
      { "gS", "<cmd>TSJSplit<cr>", desc = "SPlit Line" },
    },
    opts = { use_default_keymaps = false, max_join_length = 300 },
  },

  -- Structural Search and Replace
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  -- sort lines
  {
    'sQVe/sort.nvim',
    keys = {
     -- Sort current line or selection.
    { 'go', '<Esc><Cmd>Sort<CR>', mode = { 'v' } },

    -- Sort motions.
    { 'go"', 'vi"<Esc><Cmd>Sort<CR>', desc = 'Sort inside "' },
    { "go'", "vi'<Esc><Cmd>Sort<CR>", desc = "Sort inside '" },
    { 'go(', 'vi(<Esc><Cmd>Sort<CR>', desc = 'Sort inside (' },
    { 'go{', 'vi{<Esc><Cmd>Sort<CR>', desc = 'Sort inside {}' },
    { 'go[', 'vi[<Esc><Cmd>Sort<CR>', desc = 'Sort inside [' },
    { 'gop', 'vip<Esc><Cmd>Sort<CR>', desc = 'Sort inside paragraph' },
    },
    cmd = 'Sort',
    config=true,
    -- config = function()
    --   require("sort").setup({})
    --
    --   vim.cmd([[
    --     nnoremap <silent> <leader>s <Cmd>Sort<CR>
    --     vnoremap <silent> <leader>s <Esc><Cmd>Sort<CR>
    --   ]])
    -- end

  },

  -- Extend vim %
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  -- beautify vim tabs
  {
    "nanozuki/tabby.nvim",
    config = function()
      require('tabby.tabline').use_preset('active_wins_at_tail', {
        theme = {
          fill = 'TabLineFill',       -- tabline background
          head = 'TabLine',           -- head element highlight
          current_tab = 'TabLineSel', -- current tab label highlight
          tab = 'TabLine',            -- other tab label highlight
          win = 'TabLine',            -- window highlight
          tail = 'TabLine',           -- tail element highlight
        },
        nerdfont = true,              -- whether use nerdfont
        tab_name = {
          name_fallback = function() return "No Name" end
        },
        buf_name = {
          mode = "tail",
        },
      })
    end
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
      -- Code ation telescope UI
  {
    'nvim-telescope/telescope-ui-select.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  -- Live grep args
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    -- config = function()
    --   require("telescope").load_extension("live_grep_args")
    -- end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate'
    -- config = function()
    --   pcall(require('nvim-treesitter.install').update { with_sync = true })
    -- end,
  },

  {
    '/apollo/env/envImprovement/vim/amazon/brazil-config/',
    url = "ladbh@git.amazon.com:pkg/NinjaHooks",
    branch = 'mainline',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/configuration/vim/amazon/brazil-config')
      local bufcheck = vim.api.nvim_create_augroup('bufcheck', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        group    = bufcheck,
        pattern  = 'Config',
        callback = function()
          vim.cmd('setf brazilconfig')
          vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>")
          vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
        end
      })
      --------------------------------
      -- Barium
      --------------------------------
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'

      -- Check if the config is already defined (useful when reloading this file)
      if not configs.barium then
        configs.barium = {
          default_config = {
            cmd = { 'barium' },
            filetypes = { 'brazilconfig' },
            root_dir = function(fname)
              return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {},
          },
        }
      end

      lspconfig.barium.setup {}
    end
  },
  {
    url = 'ssh://git.amazon.com:2222/pkg/Vim-code-browse',
    branch = 'mainline',
    -- cmd = {"G", "Git", "GBrowse"},
    keys = { { "<leader>gb", "<cmd>GBrowse<cr>", desc = "[G]it [B]rowse" } },
    lazy = false
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  -- { import = 'plugins' },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = "VeryLazy",
    opts = {
      enable = true,         -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,         -- How many lines the window should span. Values <= 0 mean no limit.
      trim_scope = 'outer',  -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      patterns = {
        -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
          'class',
          'function',
          'method',
          'for',
          'while',
          'if',
          'switch',
          'case',
        },
        typescript = {
          'arrow_function',
          'enum',
        },
        rust = {
          'impl_item',
          'struct',
          'enum',
        },
        markdown = {
          'section',
        },
        json = {
          'pair',
        },
        yaml = {
          'block_mapping_pair',
        },
      },
      exact_patterns = {},
      -- [!] The options below are exposed but shouldn't require your attention,
      --     you can safely ignore them.
      zindex = 20,     -- The Z-index of the context window
      mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
    }
  },
}, {})

-- end of plugins

-- [[ Setting options ]]
-- See `:help vim.o`

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.opt.wrap = false           -- replace <Tab> with spaces
vim.opt.showmode = false       -- replace <Tab> with spaces
vim.opt.inccommand = 'nosplit' -- Live feedback for s/pat/replace(Only for Neovim)
vim.opt.scrolloff = 999        -- always keep cursor at the middle of screen

vim.opt.expandtab = true       -- replace <Tab> with spaces
vim.opt.tabstop = 2            -- number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2        -- remove <Tab> symbols as it was spaces
vim.opt.shiftwidth = 2         -- indent size for << and >>
vim.opt.shiftround = true      -- round indent to multiple of 'shiftwidth' (for << and >>)
vim.opt.smartindent = true     -- Smart indent

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 5000

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Persistant undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')

-- Always open split on right
vim.o.splitright = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keeps the current visual block selection active after changing indent
vim.keymap.set('v', '>', "v:count == 0 ? '>gv' : '>'", { expr = true, silent = true })
vim.keymap.set('v', '<', "v:count == 0 ? '<gv' : '<'", { expr = true, silent = true })

-- highlight last paste
vim.keymap.set('n', 'gp', '`[v`]', { silent = true, noremap = true })

-- Switch termial
vim.cmd([[
tnoremap <c-h> <C-\><C-n><C-w>h
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-l> <C-\><C-n><C-w>l
]])

-- Switch between buffers and tabs
vim.keymap.set('n', '<leader><tab>', '<C-^>')
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')
vim.keymap.set('n', '<leader>6', '6gt')
vim.keymap.set('n', '<leader>7', '7gt')
vim.keymap.set('n', '<leader>8', '8gt')
vim.keymap.set('n', '<leader>9', '9gt')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc><esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<esc><esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-b>"] = require("telescope-live-grep-args.actions").quote_prompt(),
          ["<C-i>"] = require('telescope-live-grep-args.actions').quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'live_grep_args')
pcall(require('telescope').load_extension, 'harpoon')
pcall(require('telescope').load_extension, 'notify')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fl', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[S]earch [L]ines' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>rg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>bb', require('telescope.builtin').buffers, { desc = '[S]earch open [B]uffers' })
vim.keymap.set('n', '<leader>to', require('telescope.builtin').builtin, { desc = '[S]earch [T]elescope' })
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,
  --
  -- Context comment string
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  highlight = { enable = true },
  indent = {
    enable = true,
    -- disable = { 'python' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    -- swap = { enable = true, swap_next = { ['>a'] = '@parameter.inner' }, swap_previous = { ['<A'] = '@parameter.inner' } },
  },
}

-- LSP setup ---
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- border hover window
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

-- border signature window
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

-- border diagnostic floating window
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.

  -- temporary until fixed
  if client.name == 'barium' then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gs', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- attach navbuddy
  require('nvim-navbuddy').attach(client, bufnr)
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  jsonls = {},
  jdtls = {},
  -- gopls = {},
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  rust_analyzer = {
   [ "rust_analyzer" ]  = {
    cargo ={
        allFeatures = true,
      }
    }
  },
  tsserver = {},
  yamlls = {},
  bashls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  -- default handler will be called for each installed server that doesn't have a dedicated handler
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
  -- ['eslint'] = function()
  --   vim.notify("Eslint On Attach")
  --   require('lspconfig')['eslint'].setup {
  --     capabilities = capabilities,
  --     on_attach = function(_, bufnr)
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       buffer = bufnr,
  --       command = "EslintFixAll",
  --     })
  --   end,
  --   }
  -- end
}

--
-- -- nvim-cmp setup --------------------------------------------------------------------
--
local cmp = require 'cmp'
local luasnip = require 'luasnip'

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Add borders around the popup window
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
   mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ["<C-e>"] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer',  keyword_length = 3 },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

