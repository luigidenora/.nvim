local utils = require("utils")

local map = utils.keymap_factory("i")


map("<Tab>", "<C-T>", "indent")
map("<S-Tab>", "<C-D>", "unindent")

map(
  "<C-/>",
  function()
    vim.api.nvim_input("<Esc>gcca")
  end,
  "comment line"
)
