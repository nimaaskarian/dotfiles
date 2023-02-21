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
lvim.builtin.which_key.mappings["r"] = {
  "<cmd>RnvimrToggle<cr>", "Ranger"
}
lvim.builtin.which_key.mappings["o"] = {
  '<cmd>call append(line("."),   repeat([""], v:count1))<CR>', "Newline below"
}
lvim.builtin.which_key.mappings["O"] = {
  '<cmd>call append(line(".")-1,   repeat([""], v:count1))<CR>', "Newline above"
}
lvim.builtin.which_key.mappings["n"] = {
  '<cmd>ene!<CR>', "New file"
}
lvim.builtin.which_key.mappings["S"] = {
  name = "Split/Sudo",
  w = { "<cmd>SudaWrite<CR>", "Write" },
  r = { "<cmd>SudaRead<CR>", "Read" },
  h = { "<cmd>split<CR>", "Horizontal" },
  v = { "<cmd>vsplit<CR>", "Vertical" }
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
