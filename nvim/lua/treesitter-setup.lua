-- ref: https://github.com/nicknisi/dotfiles/blob/main/config/nvim/lua/plugins/treesitter.lua
require "nvim-treesitter.configs".setup {
  -- Context comment string
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- treesitter highlighting
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  -- TSPlayground config
  playground = {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "maintained",
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    enable = true,
    disable = {""},
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
