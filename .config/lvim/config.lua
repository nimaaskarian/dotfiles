-- General
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "pywal"
lvim.builtin.theme.name = "pywal"
lvim.leader = "space"
lvim.transparent_window = true

-- Vim options
vim.opt.timeoutlen = 100
vim.opt.spelllang = "en"
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.cmd([[
  augroup MyColors
  autocmd!
  autocmd ColorScheme * highlight StatusLine guifg=red
  autocmd ColorScheme * highlight VertSplit guibg=#00000000
  augroup end
]])
vim.cmd([[
  augroup calcurse
  autocmd!
  autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
  autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown
  augroup end
]])

-- Lvim builtin options
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Treesitter options
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

-- Telescope options
lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120

-- User files
require "nima.alpha"
require "nima.keybinds"
require "nima.plugins"
require "nima.plugin-configs"
