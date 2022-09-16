# dotfiles
 🔧 .files
 
 To backup run `sh ./backup.sh`
 To restore run `sh ./restore.sh`


 # Vim configurations
 ### `init.vim` and `.vimrc`

 - `init.vim` - Used by neovim (~/.config/nvim/init.vim)
 - `.vimrc` - Used by Vim (~/.vimrc or ~/.vim/.vimrc)

 # Hammerspoon Configuration
 ### `init.lua`

Hammerspoon configurations (place it in `~/.hammerspoon`):

1. Clipboard History 
2. Browser Select 

[User this to configure more browsers](https://github.com/will-stone/browserosaurus/blob/master/src/config/apps.ts)


# neovim

## How to install new lsp server
1. Run :LspInstall tsserver
2. Add the server in file `nvim/lua/completion-setup.lua`.

## How to install new dap adapter

1. Run :MasonInstall codelldb
2. Configure the adapater on `nvim-dap-setup.lua` file.
