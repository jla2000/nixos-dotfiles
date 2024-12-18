local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.keymap.set("n", "<esc>", "<cmd>nohl<cr><esc>")
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")

require("lazy").setup({
  spec = {
    { "echasnovski/mini.icons", opts = {} },
    {
      "stevearc/oil.nvim",
      opts = { default_file_explorer = true },
      keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    },
    {
      "folke/tokyonight.nvim",
      event = "VeryLazy",
      config = function()
        vim.cmd.colorscheme("tokyonight")
      end,
    },
    {
      "folke/flash.nvim",
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      main = "nvim-treesitter.configs",
      opts = {
        auto_install = true,
        highlight = {
          enable = true,
        },
      },
    },
    {
      "christoomey/vim-tmux-navigator",
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },
    {
      "saghen/blink.cmp",
      lazy = false,
      version = "v0.*",
      opts = {},
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {},
    },
    {
      "neovim/nvim-lspconfig",
      event = "BufEnter",
      config = function()
        require("lspconfig").lua_ls.setup({})
      end,
    },
    {
      "stevearc/conform.nvim",
      event = "BufEnter",
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          nix = { "nixpkgs_fmt" },
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      },
    },
    {
      "mrcjkb/rustaceanvim",
      version = "^5",
      lazy = false,
    },
    {
      "ibhagwan/fzf-lua",
      event = "VeryLazy",
      keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Open files" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Recent files" },
        { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Search files" },
      },
      config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { buffer = args.bufnr })
            -- vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { buffer = args.bufnr })
            -- vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_workspace_symbols<cr>", { buffer = args.bufnr })
            -- vim.keymap.set("n", "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { buffer = args.bufnr })
          end,
        })
      end,
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},
    },
  },

  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  defaults = { lazy = true },
})
