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
  {
    "tpope/vim-surround",
    lazy = false
  },
  {
    "rhysd/conflict-marker.vim",
    lazy = false
  },
  {
    "bronson/vim-trailing-whitespace",
    lazy = false
  },
  {
    "AndrewRadev/splitjoin.vim",
    lazy = false
  },
  {
    "Vimjas/vim-python-pep8-indent",
    lazy = false
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup {
        multi_windows = true,
      }
    end,
  },
  {
    "dpelle/vim-Grammalecte",
    lazy = false
  },
  {
    "mbbill/undotree",
    lazy = false
  },
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = false,
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('refactoring').setup({
        prompt_func_return_type = {
          go = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
        },
      })
    end,
  },
  {
    "Exafunction/codeium.vim",
    lazy = false,
    config = function()
      vim.keymap.set('i', '<M-a>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<M-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<M-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<M-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
}
