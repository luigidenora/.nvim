local utils = require("utils")
local buffers = require("utils.buffers")
local fn = require("utils.fn")
local harpoon = require("harpoon")

local map = utils.keymap_factory("n")
local map_with_visual = utils.keymap_factory({"n", "v"})

local cmd = utils.cmd

local hop = require("hop")
local telescope_ui = require("ui.telescope")

local is_default_buffer = function()
  return buffers.is_not_focused_buffer("NvimTree_1", "mind", "spectre", "gen.nvim")
end

map("s", hop.hint_patterns, "hop patterns")
map("f", hop.hint_char2, "hop char")
map("<leader>w", hop.hint_words, "hop words")
map("<leader>q", hop.hint_lines, "hop lines")

map("<ESC>", cmd "noh", "no highlight")
map(
 "<F11>",
 function() 
   if vim.g.neovide then
     vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen 
   end
 end,
   "neovide fullscreen"
)

map("<C-b>", cmd "NvimTreeToggle", "toggle nvimtree")

map("<leader>t", cmd "ToggleTerm", "toggle terminal")
map("<leader>1", cmd "ToggleTerm 1", "toggle terminal #1")
map("<leader>2", cmd "ToggleTerm 2 dir=horizontal", "toggle terminal #2")
map("<leader>3", cmd "ToggleTerm 3 dir=horizontal", "toggle terminal #3")
map("<leader>a", cmd "ToggleTermToggleAll", "toggle all terminals")

map("<leader>s", cmd "SwapSplit", "swap split")
map("<leader>v", cmd "vsplit", "vertical split")
map("<leader>h", cmd "split", "horizontal split")
map("<leader>c", cmd "close", "close split")

map_with_visual(
  "<C-F>",
  function()
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" then
      require("spectre").open_visual({select_word = true})
    else
      require("spectre").toggle()
    end
  end,
  "find & replace"
)
map("<C-a>", "ggVG", "select whole file")

map("<C-n>", cmd "enew", "new buffer")

map("<C-S-f>", cmd "Telescope live_grep", "grep files")
map(
  "<C-f>",
  function()
    require("telescope.builtin").current_buffer_fuzzy_find {
      entry_maker = telescope_ui.gen_from_buffer_lines()
    }
  end
)
map("<C-p>", cmd "Telescope find_files", "find file by name")

map("<D-C-Right>", cmd "vertical resize +5", "resize split vertically")
map("<D-C-Left>", cmd "vertical resize -5", "resize split vertically")
map("<D-C-Down>", cmd "resize +5", "resize split horizontally")
map("<D-C-Up>", cmd "resize -5", "resize split horizontally")

map("<D-S-Left>", "<C-w>h", "window left")
map("<D-S-Right>", "<C-w>l", "window right")
map("<D-S-Down>", "<C-w>j", "window down")
map("<D-S-Up>", "<C-w>k", "window up")

map(
  "<C-/>",
  function()
    vim.api.nvim_input("gcc")
  end,
  "comment line"
)
-- map("<D-S-Down>", "<Plug>GoNMLineDown", "move line down")
-- map("<D-S-Up>", "<Plug>GoNMLineUp", "move line up")
map(
  "<C-d>",
  function()
    vim.api.nvim_input("*``cgn")
  end,
  "find and replace"
)

map(
  "<C-k>",
  function()
    vim.lsp.buf.hover()
  end,
  "display lsp type"
)

map(
  "<C-k>",
  function()
    vim.diagnostic.open_float(
      {
        border = "rounded"
      }
    )
  end,
  "display diagnostics"
)

map(
  "<C-.>",
  function()
    if is_default_buffer() then
      local menu = require("pickers.code-action")
      require("ui.picker").make(menu)
    end
    -- vim.lsp.buf.code_action()
  end,
  "code action"
)

map(
  "<C-m>",
  function()
    if is_default_buffer() then
      local menu = require("pickers.marks")
      require("ui.picker").make(menu)
    end
  end,
  "marks"
)
map_with_visual(
  "<C-S-p>",
  function()
    local bufname = vim.fn.expand "%"

    local menu =
      fn.switch(
      bufname,
      {
        ["NvimTree_1"] = function()
          -- return require("pickers.nvim-tree")
          return require("pickers.command-palette")
        end,
        ["mind"] = function()
          return require("pickers.mind")
        end,
        ["default"] = function()
          return require("pickers.command-palette")
        end
      }
    )

    require("ui.picker").make(menu)
  end
)

map(
  "<PageUp>",
  function()
    if is_default_buffer() then
      local menu = require("pickers.timetracker")
      require("ui.picker").make(menu)
    end
  end
)

map(
  "<PageDown>",
  function()
    if is_default_buffer() then
      local menu = require("pickers.ollama")
      menu.toggle()
    end
  end
)

map(
  "<Home>",
  function()
    if is_default_buffer() then
      local menu = require("pickers.spectre")
      menu.toggle()
    end
  end
)


map(
  "<leader>j",
  function()
    local mind = require("mind")
    local mind_ui = require("mind.ui")
    local mind_node = require("mind.node")
    local mind_commands = require("mind.commands")

    mind.wrap_project_tree_fn(
      function(args)
        mind_commands.commands.move_above(args)
      end
    )
  end
)

map(
  "<C-e>",
  function()
    if is_default_buffer() then
      local menu = require("pickers.harpoon")
      menu.toggle(harpoon:list())
    end
  end
)

map(
  "<leader>a",
  function()
    local harpoon = require("harpoon")
    harpoon:list():append()
  end
)

map(
  "<leader>lp",
  function()
    local harpoon = require("harpoon")
    harpoon:list():prepend()
  end
)

map(
  "<leader>d",
  function()
    local harpoon = require("harpoon")
    harpoon:list():remove()
  end
)

map("gx", '<cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>')
