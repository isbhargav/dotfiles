local dap = require('dap')
local dapui = require("dapui")

-- setup dapui
dapui.setup()

-- Setup dap virtual text
require("nvim-dap-virtual-text").setup()

-- dapui open windows automenticaly
dap.listeners.after.event_initialized["dapui_config"] = function()
  -- open dap ui
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


-- Set keymaps
vim.keymap.set("n", "<leader>DR" ,":lua require'dap'.run_to_cursor()<cr>")
vim.keymap.set("n", "<leader>DE" ,":lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>")
vim.keymap.set("n", "<leader>DC" ,":lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>")
vim.keymap.set("n", "<leader>DU" ,":lua require'dapui'.toggle()<cr>")
vim.keymap.set("n", "<leader>Db" ,":lua require'dap'.step_back()<cr>")
vim.keymap.set("n", "<leader>Dc" ,":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>Dd" ,":lua require'dap'.disconnect()<cr>")
vim.keymap.set("n", "<leader>De" ,":lua require'dapui'.eval()<cr>")
vim.keymap.set("n", "<leader>Dg" ,":lua require'dap'.session()<cr>")
vim.keymap.set("n", "<leader>Dh" ,":lua require'dap.ui.widgets'.hover()<cr>")
vim.keymap.set("n", "<leader>DS" ,":lua require'dap.ui.widgets'.scopes()<cr>")
vim.keymap.set("n", "<leader>Di" ,":lua require'dap'.step_into()<cr>")
vim.keymap.set("n", "<leader>Do" ,":lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<leader>Dp" ,":lua require'dap'.pause.toggle()<cr>")
vim.keymap.set("n", "<leader>Dq" ,":lua require'dap'.close()<cr>")
vim.keymap.set("n", "<leader>Dr" ,":lua require'dap'.repl.toggle()<cr>")
vim.keymap.set("n", "<leader>Ds" ,":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>Dt" ,":lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>Dx" ,":lua require'dap'.terminate()<cr>")
vim.keymap.set("n", "<leader>Du" ,":lua require'dap'.step_out()<cr>")


vim.keymap.set("n", "<F5>" ,":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<F10>" ,":lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<F11>" ,":lua require'dap'.step_into()<cr>")
vim.keymap.set("n", "<F12>" ,":lua require'dap'.step_out()<cr>")


-- C/C++/Rust (via codelldb)
-- Refrence: https://github-wiki-see.page/m/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
-- Refrence: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

dap.adapters.codelldb = {
    type = 'server',
    port = "1234",
    executable = {
      -- CHANGE THIS to your path! (make sure its Absolute path)
      command = vim.fn.getenv('HOME') .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
      args = { "--port", "1234" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = '${fileBasenameNoExtension}', -- This assumes that your program is compilbed and ready to debug with gdb/codelldb
    -- program = function()
    --   -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --   vim.cmd('make %:r')
    --   return '${fileBasenameNoExtension}'
    -- end,
    -- program = '${fileDirname}/${fileBasenameNoExtension}',
    cwd = '${workspaceFolder}',
    -- stopOnEntry = true,
    terminal = 'integrated'
  },
}


dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
