local utils = require("utils")

local map = utils.keymap_factory("v")
local map = utils.keymap_factory("v")

map("<C-l>", "<Plug>(dial-increment)", "dial inc")
map("<C-k>", "<Plug>(dial-decrement)", "dial dec")

map(
  "<C-/>",
  function()
    vim.api.nvim_input("gc")
  end,
  "comment lines"
)
-- map("<D-S-Down>", ":m'>+<CR>gv=gv", "")
-- map("<D-S-Up>", ":m-2<CR>gv=gv", "")

map(
  "<C-d>",
  function()
    -- vim.api.nvim_input(":s/")
    vim.api.nvim_input("*Ncgn")
  end,
  "find and replace"
)

map(
  "<C-g>",
  function()
    vim.api.nvim_input(":s/")
  end,
  "find and replace"
)

map("<S-Tab>", "<gv", "unindent")
map("<Tab>", ">gv", "indent")
