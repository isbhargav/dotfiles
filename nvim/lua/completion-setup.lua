-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require("luasnip")

vim.o.completeopt = "menu,menuone,noselect"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
      snippet = {
         -- REQUIRED - you must specify a snippet engine
         expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
         end,
      },
      window = {
         -- completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<C-j>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<C-k>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
         }),
            ["<C-l>"] = cmp.mapping(function()
              if luasnip.choice_active() then
                luasnip.change_choice(1)
              end
            end, { "i" }),
      sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
         }, {
            { name = 'buffer' },
         })
   })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
         }, {
            { name = 'buffer' },
         })
   })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
         { name = 'buffer' }
      }
   })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
            { name = 'path' }
         }, {
            { name = 'cmdline' }
         })
   })


-- list of lsp servers to setup (make sure they are installed id not then do :LspInstall <server_name>)
local servers = {
    "pyright",
    "clangd",
    "tsserver",
    "sumneko_lua"
}

-- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
   require('lspconfig')[lsp].setup{
      capabilities = capabilities,
   }
end


-- +---------------------------------------------------------------+
-- |   _                 _                   _                     |
-- |  | |___ _ __    ___(_) __ _ _ __   __ _| |_ _   _ _ __ ___    |
-- |  | / __| '_ \  / __| |/ _` | '_ \ / _` | __| | | | '__/ _ \   |
-- |  | \__ \ |_) | \__ \ | (_| | | | | (_| | |_| |_| | | |  __/   |
-- |  |_|___/ .__/  |___/_|\__, |_| |_|\__,_|\__|\__,_|_|  \___|   |
-- |        |_|            |___/                                   |
-- +---------------------------------------------------------------+

require('lsp_signature').setup({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
         border = "rounded"
      }
   })


-- Luasnip config
local types = require 'luasnip.util.types'

luasnip.config.set_config{
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
  ext_opts={
    [types.choiceNode] = {
      virt_text = {{ "<-", "Error" }}
    }
  }
}


-- c-k expansion key
vim.keymap.set({'i', 's'}, '<c-k>', function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent=true })

-- c-j jump backward
vim.keymap.set({'i', 's'}, '<c-j>', function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent=true })

-- c-l selecting within list of options
vim.keymap.set({'i'}, '<c-l>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

