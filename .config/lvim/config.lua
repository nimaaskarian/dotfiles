-- vim:fileencoding=utf-8:foldmethod=marker
-- Lvim builtin options {{{
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.builtin.lualine.options.theme = "pywal16-nvim"
lvim.colorscheme = "pywal16"
lvim.builtin.theme.name = "pywal16"

lvim.leader = "space"
-- lvim.transparent_window = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- Treesitter options{{{
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
}-- }}}
-- Telescope options{{{
-- lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
-- lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
-- lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120}}}
-- }}}
-- Vim options{{{
vim.opt.timeoutlen = 100
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.spelllang = "en"
vim.opt.ignorecase = true
vim.opt.wildignorecase = true-- }}}
-- Highlight groups{{{
-- vim.cmd([[
--   augroup MyColors
--   autocmd!
--   autocmd ColorScheme * highlight StatusLine guifg=none
--   autocmd ColorScheme * highlight VertSplit guibg=none
--   augroup end
-- ]])
-- vim.cmd "au ColorScheme * hi StatusLine ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi StatusLineNC ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi NvimTreeStatusLineNC ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi LineNr ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi IndentBlankLineChar ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi TelescopeNormal ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi Folded ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi LspFloatWinNormal ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi CursorLine ctermfg=none ctermbg=none guibg=none guifg=none"
-- vim.cmd "au ColorScheme * hi CursorLineNr ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi WhichKeyFLoat ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi WhichKeyBorder ctermbg=none guibg=none"
-- }}}
-- Manual Filetypes{{{
vim.cmd "autocmd BufRead,BufNewFile ~/.nnn_variables set filetype=bash"
vim.cmd "autocmd BufRead,BufNewFile */.nitabrc set filetype=bash"
vim.cmd 'autocmd BufFilePost *.kbd :lua vim.api.nvim_buf_set_option(0, "commentstring", ";; %s")'
vim.cmd 'autocmd BufRead,BufNewFile *.kbd :lua vim.api.nvim_buf_set_option(0, "commentstring", ";; %s")'
vim.cmd([[
  augroup set-commentstring-ag
  autocmd!
  autocmd BufRead,BufNewFile */waybar/config set filetype=json
  autocmd BufRead,BufNewFile */waybar/config :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  autocmd BufEnter */waybar/config :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  " when you've changed the name of a file opened in a buffer, the file type may have changed
  autocmd BufFilePost */waybar/config :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  augroup END
]])

vim.cmd([[
  augroup calcurse
  autocmd!
  autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
  autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown
  augroup end
]])
-- }}}
-- Alpha{{{
local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
    return
end

local dashboard = require "alpha.themes.dashboard"
local user_config_path = require("lvim.config"):get_user_config_path()
local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local function get_extension(fn)
    local match = fn:match "^.+(%..+)$"
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

local function icon(fn)
    local nwd = require "nvim-web-devicons"
    local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn)
    short_fn = short_fn or fn
    local ico_txt
    local fb_hl = {}

    if lvim.use_icons then
        local ico, hl = icon(fn)
        table.insert(fb_hl, { hl, 0, 3 })
        ico_txt = ico .. "  "
    else
        ico_txt = ""
    end
    local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <CR>")
    local fn_start = short_fn:match ".*[/\\]"
    if fn_start ~= nil then
        table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
    ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
    end,
}

--- @param start number
--- @param cwd string optional
--- @param items_number number optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
    opts = opts or mru_opts
    items_number = if_nil(items_number, 5)

    local oldfiles = {}
    for _, v in pairs(vim.v.oldfiles) do
        if #oldfiles == items_number then
            break
        end
        local cwd_cond
        if not cwd then
            cwd_cond = true
        else
            cwd_cond = vim.startswith(v, cwd)
        end
        local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
        if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
        end
    end
    local target_width = 35

    local tbl = {}
    for i, fn in ipairs(oldfiles) do
        local short_fn
        if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
        else
            short_fn = vim.fn.fnamemodify(fn, ":~")
        end

        if #short_fn > target_width then
            short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
            if #short_fn > target_width then
                short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
            end
        end

        local shortcut = tostring(i + start - 1)

        local file_button_el = file_button(fn, shortcut, short_fn)
        tbl[i] = file_button_el
    end
    return {
        type = "group",
        val = tbl,
        opts = {},
    }
end

local default_header = {
    type = "text",
    -- val = {
    --     [[    __                          _    ___         ]],
    --     [[   / /   __  ______  ____ _____| |  / (_)___ ___ ]],
    --     [[  / /   / / / / __ \/ __ `/ ___/ | / / / __ `__ \]],
    --     [[ / /___/ /_/ / / / / /_/ / /   | |/ / / / / / / /]],
    --     [[/_____/\__,_/_/ /_/\__,_/_/    |___/_/_/ /_/ /_/ ]],
    -- },
--     val = {
-- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣶⣦⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡿⠛⠉⠙⠛⠛⠛⠛⠻⢿⣿⣷⣤⡀⠀⠀⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠋⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠈⢻⣿⣿⡄⠀⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⣸⣿⡏⠀⠀⠀⣠⣶⣾⣿⣿⣿⠿⠿⠿⢿⣿⣿⣿⣄⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⣿⣿⠁⠀⠀⢰⣿⣿⣯⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣷⡄⠀ ",
-- "⠀⠀⣀⣤⣴⣶⣶⣿⡟⠀⠀⠀⢸⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⠀ ",
-- "⠀⢰⣿⡟⠋⠉⣹⣿⡇⠀⠀⠀⠘⣿⣿⣿⣿⣷⣦⣤⣤⣤⣶⣶⣶⣶⣿⣿⣿⠀ ",
-- "⠀⢸⣿⡇⠀⠀⣿⣿⡇⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀ ",
-- "⠀⣸⣿⡇⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠉⠻⠿⣿⣿⣿⣿⡿⠿⠿⠛⢻⣿⡇⠀⠀ ",
-- "⠀⣿⣿⠁⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣧⠀⠀ ",
-- "⠀⣿⣿⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀ ",
-- "⠀⣿⣿⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀ ",
-- "⠀⢿⣿⡆⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀ ",
-- "⠀⠸⣿⣧⡀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠃⠀⠀ ",
-- "⠀⠀⠛⢿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⣰⣿⣿⣷⣶⣶⣶⣶⠶⠀⢠⣿⣿⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⣿⣿⡇⠀⣽⣿⡏⠁⠀⠀⢸⣿⡇⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⣿⣿⡇⠀⢹⣿⡆⠀⠀⠀⣸⣿⠇⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⢿⣿⣦⣄⣀⣠⣴⣿⣿⠁⠀⠈⠻⣿⣿⣿⣿⡿⠏⠀⠀⠀⠀ ",
-- "⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⠿⠿⠿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
--     },
    val ={
[[      _________       ]],
[[     / ======= \      ]],
[[    / __________\        ___       ___       ___       ___    ]],
[[   | ___________ |      /\__\     /\__\     /\  \     /\__\   ]],
[[   | | ~       | |     /:/  /    /:/ _/_   _\:\  \   /::L_L_  ]],
[[   | |         | |    /:/__/    |::L/\__\ /\/::\__\ /:/L:\__\ ]],
[[   | |_________| |    \:\  \    |::::/  / \::/\/__/ \/_/:/  / ]],
[[   \=____________/     \:\__\    L;;/__/   \:\__\     /:/  /  ]],
[[   / """"""""""" \      \/__/               \/__/     \/__/   ]],
[[  / ::::::::::::: \  ]],
[[ (_________________) ]],
    },
    opts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
    },
}

local section_mru = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Recent files",
            opts = {
                hl = "SpecialComment",
                shrink_margin = false,
                position = "center",
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return { mru(0, cdir) }
            end,
            opts = { shrink_margin = false },
        },
    },
}

local buttons = {
    type = "group",
    val = {
        dashboard.button("f", "󰱽  Find File", ":Telescope find_files<CR>"),
        dashboard.button("n", "  New File", ":ene!<CR>"),
        dashboard.button("o", "  New Obsidian", ":ObsidianNew<CR>"),
        dashboard.button("d", "  Today Obsidian", ":ObsidianToday<CR>"),
        dashboard.button("p", "  Recent Projects ", ":Telescope projects<CR>"),
        dashboard.button("r", "  Recently Used Files", ":Telescope oldfiles<CR>"),
        dashboard.button("w", "󰊄  Find Word", ":Telescope live_grep<CR>"),
        dashboard.button("c", "󰒓  Configuration", ":edit " .. user_config_path .. "<CR>"),
    },

}

lvim.builtin.alpha.dashboard.config = {
    layout = {
         { type = "padding", val = 3 },
         default_header,
         { type = "padding", val = 1 },
         section_mru,
         { type = "padding", val = 1 },
         buttons,
    },
    opts = {
        margin = 5,
        setup = function()
            vim.cmd [[autocmd alpha_temp DirChanged * lua require('alpha').redraw()]]
        end,
    },
}
-- }}}
-- Keybinds{{{
lvim.keys.normal_mode["<C-o>"] = 'i<CR><ESC>'
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<A-e>"] = ":e "
lvim.keys.normal_mode["<A-c>"] = ":cd "
lvim.keys.normal_mode["<C-c>"] = ":PickColor<cr>"
lvim.keys.insert_mode["<C-c>"] = ":PickColorInsert<cr>"
-- lvim.keys.normal_mode["<leader>G"] = ":GuessIndent<cr>"
lvim.keys.normal_mode["<F11>"] = ":set spell!<cr>"
lvim.keys.insert_mode["<F11>"] = ":<C-O>set spell!<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
-- lvim.builtin.which_key.mappings["r"] = {
--   "<cmd>NnnPicker %:p:h<cr>", "Nnn"
-- }
lvim.builtin.which_key.mappings["r"] = {
  "<cmd>RnvimrToggle<cr>", "Ranger"
}
lvim.builtin.which_key.mappings["t"] = {
  "<cmd>TroubleToggle<cr>", "Troubles"
}
lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon",
  m = {"<cmd>lua require('harpoon.mark').add_file()<CR>", "Mark"},
  o = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Open"},
  N = {":lua require('harpoon.ui').nav_file()<left>","Navigate"},
  n = {"<cmd>lua require('harpoon.ui').nav_next()<cr>","Next"},
  p = {"<cmd>lua require('harpoon.ui').nav_prev()<cr>","Previous"},
  s = {"<cmd>Telescope harpoon marks<CR>", "Search"},
}
lvim.builtin.which_key.mappings["o"] = {
  '<cmd>call append(line("."),   repeat([""], v:count1))<CR>', "Newline below"
}
lvim.builtin.which_key.mappings["O"] = {
  '<cmd>call append(line(".")-1,   repeat([""], v:count1))<CR>', "Newline above"
}
lvim.builtin.which_key.mappings["n"] = {
   '<cmd>ene!<CR>', "New File"
}
lvim.builtin.which_key.mappings["S"] = {
  name = "Split/Sudo",
  w = { "<cmd>SudaWrite<CR>", "Write" },
  r = { "<cmd>SudaRead<CR>", "Read" },
  h = { "<cmd>split<CR>", "Horizontal" },
  v = { "<cmd>vsplit<CR>", "Vertical" }
}
lvim.builtin.which_key.mappings["m"] = {
  name = "Markdown",
  c = {
    '<cmd>. luado if string.find(line,"%[x%]") then return line:gsub("%[x%]", "[ ]") else return line:gsub("%[ %]", "[x]") end<CR>',
    "Toggle checkbox"
  },
  l = {
    '<cmd>norm i[](https://)<CR><esc>^ci[',
    "Link"
  },
  n = { "<cmd>ObsidianNew<CR>", "Obsidian note"},
  d = { "<cmd>ObsidianToday<CR>", "Obsidian today"},
  o = { "<cmd>ObsidianOpen<CR>", "Obsidian open"},
  s = { "<cmd>ObsidianSearch<CR>", "Obsidian search"},
  t = { "<cmd>ObsidianTemplate<CR>", "Obsidian template"},
}
lvim.builtin.which_key.mappings["R"] = {
  name = "Resize",
  v = { "<cmd>vertical resize -10<CR>", "Vertical -" },
  V = { "<cmd>vertical resize +10<CR>", "Vertical +" },
  h = { "<cmd>resize -10<CR>", "Horizontal -" },
  H = { "<cmd>resize +10<CR>", "Horizontal +" }
}
lvim.builtin.which_key.mappings["i"] = {
  "<cmd>SymbolsOutline<CR>", "Outline"
}
lvim.keys.normal_mode["<C-u>"] = ":-5<cr>"
lvim.keys.normal_mode["<C-d>"] = ":+5<cr>"
lvim.builtin.which_key.mappings["Lp"] = {
  "<cmd>colorscheme pywal<cr>", "Reload Pywal",
}
-- }}}
-- Plugins{{{
lvim.plugins = {
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require"lsp_signature".on_attach() end,
  },
  {
    "bkad/CamelCaseMotion"
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
    "phaazon/hop.nvim",
    branch = 'v2',
    config = function()
      require('hop').setup({keys='fhgitroepvxqdyblzcksuan'})
    end
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      {"nvim-lua/plenary.nvim"}
    }
  },
  {
    "simrat39/rust-tools.nvim"
  },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   lazy = false,
  --   -- event = { "BufReadPre */Obsidian Notes/**.md" },
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  --   -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",

  --     -- Optional, for completion.
  --     "hrsh7th/nvim-cmp",

  --     -- Optional, for search and quick-switch functionality.
  --     "nvim-telescope/telescope.nvim",

  --     -- Optional, an alternative to telescope for search and quick-switch functionality.
  --     -- "ibhagwan/fzf-lua"

  --     -- Optional, another alternative to telescope for search and quick-switch functionality.
  --     -- "junegunn/fzf",
  --     -- "junegunn/fzf.vim"

  --     -- Optional, alternative to nvim-treesitter for syntax highlighting.
  --     "godlygeek/tabular",
  --     "preservim/vim-markdown",
  --   },
  --   opts = {
  --     dir = "~/Documents/Obsidian Notes/main",  -- no need to call 'vim.fn.expand' here

  --     -- Optional, if you keep notes in a specific subdirectory of your vault.
  --     notes_subdir = "notes",

  --     daily_notes = {
  --       -- Optional, if you keep daily notes in a separate directory.
  --       folder = "notes/dailies",
  --       -- Optional, if you want to change the date format for daily notes.
  --       date_format = "%Y-%m-%d"
  --     },

  --     -- Optional, completion.
  --     completion = {
  --       nvim_cmp = true,  -- if using nvim-cmp, otherwise set to false
  --     },

  --     -- Optional, customize how names/IDs for new notes are created.
  --     note_id_func = function(title)
  --       -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
  --       -- In this case a note with the title 'My new note' will given an ID that looks
  --       -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
  --       local suffix = ""
  --       if title ~= nil then
  --         -- If title is given, transform it into valid file name.
  --         suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  --       else
  --         -- If title is nil, just add 4 random uppercase letters to the suffix.
  --         for _ = 1, 4 do
  --           suffix = suffix .. string.char(math.random(65, 90))
  --         end
  --       end
  --       return tostring(os.time()) .. "-" .. suffix
  --     end,

  --     -- Optional, set to true if you don't want Obsidian to manage frontmatter.
  --     disable_frontmatter = false,

  --     -- Optional, alternatively you can customize the frontmatter data.
  --     note_frontmatter_func = function(note)
  --       -- This is equivalent to the default frontmatter function.
  --       local out = { id = note.id, aliases = note.aliases, tags = note.tags }
  --       -- `note.metadata` contains any manually added fields in the frontmatter.
  --       -- So here we just make sure those fields are kept in the frontmatter.
  --       if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
  --         for k, v in pairs(note.metadata) do
  --           out[k] = v
  --         end
  --       end
  --       return out
  --     end,

  --     -- Optional, for templates (see below).
  --     templates = {
  --       subdir = "templates",
  --       date_format = "%Y-%m-%d-%a",
  --       time_format = "%H:%M",
  --     },

  --     -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  --     -- URL it will be ignored but you can customize this behavior here.
  --     follow_url_func = function(url)
  --       -- Open the URL in the default web browser.
  --       vim.fn.jobstart({"open", url})  -- Mac OS
  --       -- vim.fn.jobstart({"xdg-open", url})  -- linux
  --     end,

  --     -- Optional, set to true if you use the Obsidian Advanced URI plugin.
  --     -- https://github.com/Vinzent03/obsidian-advanced-uri
  --     use_advanced_uri = true,

  --     -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  --     open_app_foreground = false,

  --     -- Optional, by default commands like `:ObsidianSearch` will attempt to use
  --     -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
  --     -- first one they find. By setting this option to your preferred
  --     -- finder you can attempt it first. Note that if the specified finder
  --     -- is not installed, or if it the command does not support it, the
  --     -- remaining finders will be attempted in the original order.
  --     finder = "telescope.nvim",
  --   },
  --   config = function(_, opts)
  --     require("obsidian").setup(opts)

  --     -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
  --     -- see also: 'follow_url_func' config option above.
  --     vim.keymap.set("n", "gf", function()
  --       if require("obsidian").util.cursor_on_markdown_link() then
  --         return "<cmd>ObsidianFollowLink<CR>"
  --       else
  --         return "gf"
  --       end
  --     end, { noremap = false, expr = true })
  --   end,
  -- },
  {"ellisonleao/gruvbox.nvim"},
  -- {'dylanaraps/wal.vim'},
  {'lervag/vimtex'},
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end
  },
  {
    "lambdalisue/suda.vim"
  },
  {
    'rktjmp/fwatch.nvim',
    config = function()
      local fwatch = require('fwatch')
      fwatch.watch("/home/nima/.cache/wal/colors", "colorscheme pywal16")
    end
  },
  {
    "terrortylor/nvim-comment",
    config = function() require('nvim_comment').setup() end,
  },
  -- {
  --   'nmac427/guess-indent.nvim',
  --   config = function() require('guess-indent').setup {} end,
  -- },
  {
    "luukvbaal/nnn.nvim",
    config = function()
    require("nnn").setup({
      picker = {
        cmd = "~/Scripts/nnn-w",
        style = { border = "rounded" },
        session = "shared",
      },
      explorer = {
        cmd = "~/Scripts/nnn-w",
      }
    })
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  },
  { "mg979/vim-visual-multi" },
  { "Galooshi/vim-import-js" },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "ziontee113/color-picker.nvim",
    config = function()
      require("color-picker").setup()
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { 'mattn/emmet-vim' },
  { 'andweeb/presence.nvim',
    config = function()
      require("presence"):setup({
        -- General options
        auto_update        = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text  = "Lunarvim based", -- Text displayed when hovered over the Neovim image
        main_image         = "file", -- Main image display (either "neovim" or "file")
        client_id          = "793271441293967371", -- Use your own Discord application client id (not recommended)
        log_level          = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout   = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number = false, -- Displays the current line number instead of the current project
        blacklist          = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons            = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets        = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time          = true, -- Show the timer

        -- Rich Presence text options
        editing_text        = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text  = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text        = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text      = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      })
    end
  },
  { 'tpope/vim-surround' },
  {"tpope/vim-repeat"},
  {
    'nimaaskarian/pywal16.nvim',
    name = "pywal16",
    config = function ()
      require("pywal16").setup()
    end,
  },
  {
    "AlphaTechnolog/pywal.nvim",
    name = "pywal",
    config = function ()
      require("pywal").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
}
-- }}}
-- Plugin Configs{{{
-- Neovide options (GUI)
vim.g.neovide_transparency = 0.8
vim.g.neovide_refresh_rate = 60
vim.g.neovide_profiler = false
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.opt.guifont = "Jetbrains Mono:h12"
-- LSP options
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.emmet_ls.setup({
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
})



-- Dap options 
local dap = require('dap')

-- C++ and C 
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/nima/.local/share/nvim/mason/bin/OpenDebugAD7',
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp

vim.api.nvim_set_keymap("n", "<A-s>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-s>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true })

-- Hop.nvim
-- local hop = require('hop')
-- vim.keymap.set('n', '<C-f>', function()
--   hop.hint_char1({ current_line_only = true })
-- end, {remap=true})
-- }}}
