return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
 {
   "neovim/nvim-lspconfig",
   config = function()
     require("nvchad.configs.lspconfig").defaults()
     require "configs.lspconfig"
   end,
 },

 {
    'fedepujol/move.nvim',
    opts = {
    },
 },

 {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
},

{
 	"williamboman/mason.nvim",
 	opts = {
 		ensure_installed = {
 			"lua-language-server", "stylua",
 			"html-lsp", "css-lsp" , "prettier",
      "gopls", "yaml", "json",
      "htmldjango", "dockerfile", "bash",
      "sql", "tailwindcss-language-server",
      "terraform-ls", "typescript-language-server",
      "vue-language-server", "pyright", "mypy",
      "ruff", "black",
 		},
 	},
 },

 {
 	"nvim-treesitter/nvim-treesitter",
 	opts = {
 		ensure_installed = {
 			"vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "python",
      "go",
      "rust",
      "sql",
      "tsx",
      "javascript",

 		},
 	},
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
 },
 {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require'nvim-web-devicons'.setup {
      -- your personnal icons can go here (to override)
      -- you can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh"
        }
      },
    }
  end,
 },
 {
    "karb94/neoscroll.nvim",
    config = function(_, opts)
      require("neoscroll").setup(opts)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
    -- opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
  },
  { "nvim-lua/plenary.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
  },
  {
    "fedepujol/bracketpair.nvim",
  },
    {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre", -- Carrega automaticamente ao abrir um arquivo
    dependencies = { "nvim-lua/plenary.nvim" }, -- Certifique-se de que a dependência está instalada
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Formatador Blue
          null_ls.builtins.formatting.blue,
          -- Organizador de imports com isort
          null_ls.builtins.formatting.isort.with({
            extra_args = { "--profile", "blue" },
          }),
          -- Linter Ruff
          null_ls.builtins.diagnostics.ruff,
        },
      })
    end,
  },
    {
    "mattn/emmet-vim", -- Suporte ao Emmet para HTML/CSS
    ft = { "html", "css" },
  },
}

