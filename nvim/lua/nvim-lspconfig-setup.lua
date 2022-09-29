-- Keymap for lsp
local lsp_keymaps = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  -- Keymaps
  vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
  vim.keymap.set("n", "gy", ":lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.keymap.set("n", "gs", ":lua vim.lsp.buf.signature_help()<CR>", opts)
  -- Telescope
  vim.keymap.set("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  vim.keymap.set("n", "<leader>ls", "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
  vim.keymap.set("n", "<leader>lS", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>", opts)

  vim.keymap.set("n", "<leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.keymap.set("n", "<leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.keymap.set("n", "<leader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "<leader>e", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  vim.keymap.set("n", "[d", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  vim.keymap.set("n", "]d", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.keymap.set("n", "<leader>dl", ":lua vim.diagnostic.setloclist()<CR>", opts)
  vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set("n", "<leader>cd", ":vim.diagnostic.open_float()<CR>", opts)


	-- Refrence : https://github.com/meck/dotmeck/blob/nixos/.config/nvim/lua/lsp.lua
	-- Explicit LSP formatting
	if client.server_capabilities.documentFormattingProvider  then
    vim.keymap.set("n", "<leader>gq", "<cmd>lua vim.lsp.buf.formatting()<CR>",opts)
	end

	-- Use `gq` for range formating
	-- https://github.com/neovim/neovim/issues/12528
	if client.server_capabilities.documentRangeFormattingProvider then
		vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	end
end

-- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
require("mason").setup()

-- Setup lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local updated_capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local capabilitiesWithoutFomatting = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilitiesWithoutFomatting.textDocument.formatting = false
capabilitiesWithoutFomatting.textDocument.rangeFormatting = false
capabilitiesWithoutFomatting.textDocument.range_formatting = false

local custom_on_attach = function(client, bufnr)
  lsp_keymaps(client, bufnr)
end

---------------
--  Servers  --
---------------

-- list of lsp servers to setup (make sure they are installed id not then do :LspInstall <server_name>)
local servers = {
  ["pyright"]     = {
    capabilities = updated_capabilities,
    on_attach = custom_on_attach,
  },
  ["clangd"]      = {
    capabilities = updated_capabilities,
    on_attach = custom_on_attach,
  },
  ["tsserver"]    = {
    capabilities = updated_capabilities,
    on_attach = custom_on_attach,
  },
  ["sumneko_lua"] = {
    capabilities = updated_capabilities,
    on_attach = custom_on_attach,
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          -- Do not send telemetry data containing a randomized but unique identifier
          enable = false,
        },
      }
    }
  },
  ["rust_analyzer"] = {
    on_attach = custom_on_attach,
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
      }
    }
  },
}

-- ensure the lsp servers listed above are installed 
require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- Setup Servers finally
for lsp, cfg in pairs(servers) do
	require("lspconfig")[lsp].setup(cfg)
end
