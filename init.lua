local bqf_util = require("utils.bqf")

vim.pack.add {
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/kevinhwang91/nvim-bqf" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/RRethy/vim-illuminate" },
  { src = "https://github.com/smoka7/hop.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/Shatur/neovim-ayu" },
}

require("oil").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "angularls",
    "lua_ls",
    "stylua",
    "tsgo",
  }
})
require("which-key").setup({
  preset = 'helix',
})
require("fzf-lua").setup({
  "border-fused",
  keymap = {
    fzf = {
      ["alt-a"] = "select-all+accept"
    }
  },
  defaults = {
    formatter = { "path.filename_first", 999 }
  },
  winopts = {
    backdrop = 100,
    fullscreen = true,
  },
  fzf_colors = {
    ["gutter"] = "-1",
  }
})
require("bqf").setup({
  preview = {
    win_height = 30,
    winblend = 0,
    show_scroll_bar = false,
  }
})
require("gitsigns").setup({
  current_line_blame = true,
})
require("illuminate").configure()
require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
require("persistence").setup()

-- LSP
vim.lsp.enable({
  "lua_ls",
  "stylua",
  "tsgo",
})

-- OPTIONS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.winborder = "single"
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.signcolumn = "yes"
vim.opt.shiftwidth = 2
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 30
vim.opt.jumpoptions = "view"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.wo.number = true

-- CMDS
vim.cmd.colorscheme "ayu-mirage"
vim.cmd.packadd "nvim.undotree"

-- KEYBINDS
local gitsigns = require("gitsigns")
local lsp_utils = require "utils.lsp"

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#<CR>", { desc = "Delete other buffers" })
vim.keymap.set("n", "<Down>", ":horizontal resize -15<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<Up>", ":horizontal resize +15<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<Left>", ":vertical resize -15<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<Right>", ":vertical resize +15<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-C-j>", "<cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move Down" })
vim.keymap.set("n", "<S-C-k>", "<cmd>execute 'move .-' . (v:count1 + 1<CR>==", { desc = "Move Up" })
vim.keymap.set("i", "<S-C-j>", "<esc><cmd>m .+1<CR>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<S-C-k>", "<esc><cmd>m .-2<CR>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<S-C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<S-C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1<CR>gv=gv", { desc = "Move Up" })
vim.keymap.set("n", "s", "<cmd>HopWord<CR>")
vim.keymap.set("n", "L", "<cmd>HopLine<CR>")
-- search
vim.keymap.set("n", "-", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<CR>")
vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "FzfLua lsp_document_symbols" })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<CR>", { desc = "FzfLua grep_cword" })
vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua lsp_document_diagnostics<CR>", { desc = "FzfLua lsp_document_diagnostics" })
vim.keymap.set("n", "<leader>sr", function() FzfLua.resume() end, { desc = "FzfLua resume" })
vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Undotree" })
vim.keymap.set("n", "<leader>e", bqf_util.toggle_qf, { desc = "Toggle BQF" } )
-- lsp
vim.keymap.set("n", "grr", function() vim.lsp.buf.references(nil, { on_list = lsp_utils.on_list }) end,
  { desc = "vim.lsp.buf.references", nowait = true })
vim.keymap.set("n", "grV","<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "vsplit | lua vim.lsp.buf.definition()" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "vim.lsp.buf.declaration" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition" })
vim.keymap.set("n", "gro", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })
-- git
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>ghi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
vim.keymap.set("n", "<leader>ghb", gitsigns.blame_line, { desc = "Blame line" })
vim.keymap.set("n", "<leader>ght", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_bcommits<CR>", { desc = "Git buffer commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_stash<CR>", { desc = "Git stash" })
vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })

vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load session for current directory" })
-- AUTOCMD
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("my_highlight_yank", { clear = true }),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
 end,
})
