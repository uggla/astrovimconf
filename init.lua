return {
  -- Configure AstroNvim updates
  -- updater = {
  --   remote = "origin", -- remote to use
  --   channel = "stable", -- "stable" or "nightly"
  --   version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
  --   branch = "nightly", -- branch name (NIGHTLY ONLY)
  --   commit = nil, -- commit hash (NIGHTLY ONLY)
  --   pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
  --   skip_prompts = false, -- skip prompts about breaking changes
  --   show_changelog = true, -- show the changelog after performing an update
  --   auto_quit = false, -- automatically quit the current session after a successful update
  --   remotes = { -- easily add new remotes to track
  --     --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
  --     --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
  --     --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
  --   },
  -- },

  -- Set colorscheme to use
  colorscheme = "astrodark",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "python",
          "sumneko_lua",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
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
      require("lsp-inlayhints").on_attach(client, bufnr, false)
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
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
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

    -- vim.defer_fn(
    --   function()
    --       local indent = math.abs(4)
    --       vim.bo.expandtab = (indent > 0)
    --       vim.bo.tabstop = indent
    --       vim.bo.softtabstop = indent
    --       vim.bo.shiftwidth = indent
    --   end, 1500)

    -- Set key bindings
    vim.keymap.set("n", "<C-s>", ":w!<CR>")
    vim.keymap.set("n", "<esc>", ":noh<return>")
    vim.keymap.set("n", "²w", ":lua require'hop'.hint_words({ multi_windows = true })<CR>", { desc = "HopWordMW" })
    vim.keymap.set("n", "²c", ":lua require'hop'.hint_char1({ multi_windows = true })<CR>", { desc = "HopChar1MW" })
    vim.keymap.set("n", "²l", ":lua require'hop'.hint_lines({ multi_windows = true })<CR>", { desc = "HopLineMW" })
    vim.keymap.set("n", "²p", ":lua require'hop'.hint_patterns({ multi_windows = true })<CR>", { desc = "HopPatternMW" })
    vim.keymap.set("v", "²w", "<cmd>lua require'hop'.hint_words()<CR>", { desc = "HopWord" })
    vim.keymap.set("v", "²c", "<cmd>lua require'hop'.hint_char1()<CR>", { desc = "HopChar1" })
    vim.keymap.set("v", "²l", "<cmd>lua require'hop'.hint_lines()<CR>", { desc = "HopLine" })
    vim.keymap.set("v", "²p", "<cmd>lua require'hop'.hint_patterns()<CR>", { desc = "HopPattern" })
    vim.keymap.set("n", "<leader>lt", ":lua require('lsp-inlayhints').toggle()<CR>", { desc = "Toggle inlayhints" })
    vim.api.nvim_set_keymap(
      "v",
      "<leader>r",
      ":lua require('refactoring').select_refactor()<CR>",
      { noremap = true, silent = true, expr = false }
    )
    vim.keymap.set("v", "<leader>lb", ":!black-macchiato<CR><CR>", { desc = "Black macchiato" })
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
