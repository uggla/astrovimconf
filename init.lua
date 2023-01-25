--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  -- updater = {
  --   remote = "origin", -- remote to use
  --   channel = "stable", -- "stable" or "nightly"
  --   version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
  --   branch = "main", -- branch name (NIGHTLY ONLY)
  --   commit = nil, -- commit hash (NIGHTLY ONLY)
  --   pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
  --   skip_prompts = false, -- skip prompts about breaking changes
  --   show_changelog = true, -- show the changelog after performing an update
  --   auto_reload = false, -- automatically reload and sync packer after a successful update
  --   auto_quit = false, -- automatically quit the current session after a successful update
  --   -- remotes = { -- easily add new remotes to track
  --   --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
  --   --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
  --   --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
  --   -- },
  -- },

  -- Set colorscheme to use
  colorscheme = "default_theme",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = true,
      spelllang = { "en_us", "fr" },
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    "",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },

    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        "sumneko_lua",
      },
      timeout_ms = 10000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,
    on_attach = function(client, bufnr)
      require("lsp-inlayhints").setup()
      require("lsp-inlayhints").on_attach(client, bufnr)
    end,


    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
      sumneko_lua = {
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
          },
        },
      },
      pyright = {
          settings = {
              python = {
                  analysis = {
                      typeCheckingMode = "off",
                  }
              }
          }
      }
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
      { "tpope/vim-surround" },
      { "rhysd/conflict-marker.vim" },
      { "bronson/vim-trailing-whitespace" },
      { "Vimjas/vim-python-pep8-indent" },
      { "lvimuser/lsp-inlayhints.nvim" },
      {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
          require 'hop'.setup {}
        end,
      },
      { "dpelle/vim-Grammalecte" },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      -- ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      -- ensure_installed = { "sumneko_lua" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    },
    ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
      -- ensure_installed = { "python" },
    },
    aerial = {
      -- attach_mode = "global",
      -- backends = { "lsp", "treesitter", "markdown" },
      disable_max_lines = 30000,
      -- layout = {
      --   min_width = 28,
      -- },
      -- show_guides = true,
      -- filter_kind = false,
      -- guides = {
      --   mid_item = "├ ",
      --   last_item = "└ ",
      --   nested_top = "│ ",
      --   whitespace = "  ",
      -- },
      -- keymaps = {
      --   ["[y"] = "actions.prev",
      --   ["]y"] = "actions.next",
      --   ["[Y"] = "actions.prev_up",
      --   ["]Y"] = "actions.next_up",
      --   ["{"] = false,
      --   ["}"] = false,
      --   ["[["] = false,
      --   ["]]"] = false,
      -- },
    }
  },

  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {},
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Customize Heirline options
  heirline = {
    -- -- Customize different separators between sections
    -- separators = {
    --   tab = { "", "" },
    -- },
    -- -- Customize colors for each element each element has a `_fg` and a `_bg`
    -- colors = function(colors)
    --   colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
    --   return colors
    -- end,
    -- -- Customize attributes of highlighting in Heirline components
    -- attributes = {
    --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
    --   git_branch = { bold = true }, -- bold the git branch statusline component
    -- },
    -- -- Customize if icons should be highlighted
    -- icon_highlights = {
    --   breadcrumbs = false, -- LSP symbols in the breadcrumbs
    --   file_icon = {
    --     winbar = false, -- Filetype icon in the winbar inactive windows
    --     statusline = true, -- Filetype icon in the statusline
    --   },
    -- },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set key bindings
    vim.keymap.set("n", "<C-s>", ":w!<CR>")
    vim.keymap.set("n", "<esc>", ":noh<return>")
    vim.keymap.set("n", "²w", ":lua require'hop'.hint_words()<CR>", { desc = "HopWord" })
    vim.keymap.set("n", "²c", ":lua require'hop'.hint_char1()<CR>", { desc = "HopChar1" })
    vim.keymap.set("n", "²l", ":lua require'hop'.hint_lines()<CR>", { desc = "HopLine" })
    vim.keymap.set("n", "²p", ":lua require'hop'.hint_patterns()<CR>", { desc = "HopPattern" })
    vim.keymap.set("v", "²w", "<cmd>lua require'hop'.hint_words()<CR>", { desc = "HopWord" })
    vim.keymap.set("v", "²c", "<cmd>lua require'hop'.hint_char1()<CR>", { desc = "HopChar1" })
    vim.keymap.set("v", "²l", "<cmd>lua require'hop'.hint_lines()<CR>", { desc = "HopLine" })
    vim.keymap.set("v", "²p", "<cmd>lua require'hop'.hint_patterns()<CR>", { desc = "HopPattern" })
    vim.keymap.set("n", "<leader>lt", ":lua require('lsp-inlayhints').toggle()<CR>", { desc = "Toggle inlayhints" })
    -- vim.defer_fn(
    --   function()
    --     -- print(vim.api.nvim_win_get_option(0, "diff"))
    --     if vim.opt.diff:get() then
    --       vim.keymap.set("n", "<leader>1", ":diffget LOCAL<CR>", { desc = "Diffget local" })
    --       vim.keymap.set("n", "<leader>2", ":diffget BASE<CR>", { desc = "Diffget base" })
    --       vim.keymap.set("n", "<leader>3", ":diffget REMOTE<CR>", { desc = "Diffget remote" })
    --     end
    --   end, 500)

    vim.api.nvim_create_augroup("columns-python", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Add colorcolums at 79",
      group = "columns-python",
      pattern = { "python", "rst" },
      command = "setlocal colorcolumn=79",
    })

    vim.api.nvim_create_augroup("remember-cursor-position", { clear = true })
    vim.api.nvim_create_autocmd("BufReadPost", {
      desc = "Remember cursor position",
      group = "remember-cursor-position",
      pattern = "*",
      command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    vim.g["grammalecte_cli_py"] = "/usr/bin/grammalecte-cli.py"

    -- Remap terminal <esc>
    vim.cmd(":tnoremap <Esc> <C-\\><C-n>")

    P = function(v)
      print(vim.inspect(v))
      return v
    end

    -- Disable auto_hlsearch
    vim.on_key(function()
    end, vim.api.nvim_create_namespace "auto_hlsearch")

  end,
}

return config
