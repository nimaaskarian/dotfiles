-- General
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "pywal"
-- lvim.builtin.theme.name = "pywal"
lvim.leader = "space"
lvim.transparent_window = true
local colors = {
  color2 = "none",
}

lvim.builtin.lualine.options.theme = {
  normal = {
    c = { fg = colors.color9, bg = colors.color2 },
    a = { fg = colors.color2, bg = colors.color10, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  insert = {
    a = { fg = colors.color2, bg = colors.color13, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  visual = {
    a = { fg = colors.color2, bg = colors.color3, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  replace = {
    a = { fg = colors.color2, bg = colors.color8, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  inactive = {
    c = { fg = colors.color4, bg = colors.color2 },
    a = { fg = colors.color4, bg = colors.color5, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
}
-- Vim options
vim.opt.timeoutlen = 100
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.cmd "au ColorScheme * hi StatusLine ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi StatusLineNC ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NvimTreeStatusLineNC ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi LineNr ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi IndentBlankLineChar ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi TelescopeNormal ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi Folded ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi LspFloatWinNormal ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi CursorLine ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi CursorLineNr ctermbg=none guibg=none"
vim.cmd([[
  augroup calcurse
  autocmd!
  autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
  autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown
  augroup end
]])
vim.cmd "autocmd BufRead,BufNewFile ~/.nnn_variables set filetype=bash"
vim.cmd "autocmd BufRead,BufNewFile ~/.config/waybar/config set filetype=json"
vim.cmd([[
  augroup set-commentstring-ag
  autocmd!
  autocmd BufEnter ~/.config/waybar/config :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  " when you've changed the name of a file opened in a buffer, the file type may have changed
  autocmd BufFilePost ~/.config/waybar/config :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  augroup END
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
-- lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
-- lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
-- lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120

-- User files
require "nima.alpha"
require "nima.keybinds"
require "nima.plugins"
require "nima.plugin-configs"
vim.cmd "au ColorScheme * hi WhichKeyFLoat ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi WhichKeyBorder ctermbg=none guibg=none"
