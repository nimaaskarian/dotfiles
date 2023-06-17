lvim.plugins = {
  -- {
  --   "phaazon/hop.nvim",
  --   branch = 'v2',
  --   config = function()
  --     require('hop').setup({keys='fhgitroepvxqdyblzcksuan'})
  --   end
  -- },
  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    -- event = { "BufReadPre */Obsidian Notes/**.md" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Optional, for completion.
      "hrsh7th/nvim-cmp",

      -- Optional, for search and quick-switch functionality.
      "nvim-telescope/telescope.nvim",

      -- Optional, an alternative to telescope for search and quick-switch functionality.
      -- "ibhagwan/fzf-lua"

      -- Optional, another alternative to telescope for search and quick-switch functionality.
      -- "junegunn/fzf",
      -- "junegunn/fzf.vim"

      -- Optional, alternative to nvim-treesitter for syntax highlighting.
      "godlygeek/tabular",
      "preservim/vim-markdown",
    },
    opts = {
      dir = "~/Documents/Obsidian Notes/main",  -- no need to call 'vim.fn.expand' here

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "notes",

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "notes/dailies",
        -- Optional, if you want to change the date format for daily notes.
        date_format = "%Y-%m-%d"
      },

      -- Optional, completion.
      completion = {
        nvim_cmp = true,  -- if using nvim-cmp, otherwise set to false
      },

      -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,

      -- Optional, set to true if you don't want Obsidian to manage frontmatter.
      disable_frontmatter = false,

      -- Optional, alternatively you can customize the frontmatter data.
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- Optional, for templates (see below).
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({"open", url})  -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      -- Optional, by default commands like `:ObsidianSearch` will attempt to use
      -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
      -- first one they find. By setting this option to your preferred
      -- finder you can attempt it first. Note that if the specified finder
      -- is not installed, or if it the command does not support it, the
      -- remaining finders will be attempted in the original order.
      finder = "telescope.nvim",
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
      -- see also: 'follow_url_func' config option above.
      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true })
    end,
  },
  {"ellisonleao/gruvbox.nvim"},
  -- {'dylanaraps/wal.vim'},
  {'lervag/vimtex'},
{ "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" }, },
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
  {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  },
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
    'uZer/pywal16.nvim',
    name = "pywal16",
    config = function ()
      require("pywal16").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
}
