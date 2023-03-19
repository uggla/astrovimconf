return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  { "tpope/vim-surround" },
  { "rhysd/conflict-marker.vim" },
  { "bronson/vim-trailing-whitespace" },
  { "AndrewRadev/splitjoin.vim" },
  { "Vimjas/vim-python-pep8-indent" },
  { "lvimuser/lsp-inlayhints.nvim" },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup {
        multi_windows = true,
      }
    end,
  },
  { "dpelle/vim-Grammalecte" },
}
