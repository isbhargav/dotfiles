local dap = require('dap')

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
    -- program = '${fileBasenameNoExtension}', -- This assumes that your program is compilbed and ready to debug with gdb/codelldb
    program = function()
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      vim.cmd('make %:r')
      return '${fileBasenameNoExtension}'
    end,
    -- program = '${fileDirname}/${fileBasenameNoExtension}',
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    -- terminal = 'integrated'
  },
}


dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
