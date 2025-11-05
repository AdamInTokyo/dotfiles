vim.wo.number = true
vim.opt.relativenumber = true

vim.o.background = "light"
vim.cmd("set termguicolors")

require("config.lazy")

vim.cmd("colorscheme zenbones")
vim.cmd("set signcolumn=yes") -- predesignate space for warning and git marks
vim.opt.statuscolumn = '%=%{(v:relnum >= 1)?v:relnum.\"\":\"\"}' .. '%{(v:relnum == 0)?"♪".v:lnum.\"\":\"\"}%s'
vim.opt.cursorline = true
vim.o.winborder = "single"

-- Clear highlighting on escape
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Resume from last cursor position
vim.api.nvim_create_autocmd({ 'BufWinEnter' },
   {
      desc = 'Resume from last cursor postion',
      pattern = '*',
      command = 'silent! normal! g`"zz',
   }
)

-- Show diagnostic messages after nvim 0.11
vim.diagnostic.config({ virtual_text = true })

-- Python stuff
vim.g.python_recommended_style = 0

-- LSP servers
vim.lsp.config("basedpyright", {
   settings = {
      basedpyright = {
         analysis = {
            -- ignore = { "*" },
            typeCheckingMode = "basic",
         },
      },
   },
})
vim.lsp.config("ruff", {
   init_options = {
      settings = {
         configuration = "~/.config/nvim/ruff.toml",
         lint = { enable = false },
      }
   }
})
--require("lspconfig").rust_analyzer.setup {}
--require("lspconfig").lua_ls.setup {}
vim.lsp.enable({ "basedpyright", "ruff", "rust_analyzer", "lua_ls" })

-- Linters
require("lint").linters_by_ft = {
   --  lua = {"stylua"},
}

-- Key binds --

-- Lsp-related keybinds:
vim.keymap.set('n', '<leader>gf', "<cmd>lua vim.fn.setreg('+', vim.fn.expand('%:p'))<CR>",
   { noremap = true, desc = "Copy file path to clipboard" })
-- vim.keymap.set('n', '<leader>wq', '<C-w><C-q>', { noremap = true, desc = "Close window" })
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { noremap = true, silent = true, desc = "LSP Formatter" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Default LSP Hover" })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "LSP Signature Help" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set('n', '<leader>uh', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
   { noremap = true, silent = true, desc = "Toggle inlay hints" })
vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '<leader>e]', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>e[', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "LSP references list" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = true, desc = "Delete word" })

-- Line Break Toggle:
vim.keymap.set("n", "<leader>tw", function()
   vim.opt.wrap = not vim.opt.wrap:get()
   vim.opt.linebreak = vim.opt.wrap:get() -- This can probably just be true all the time
end, { desc = "Toggle wrap and linebreak" })

-- Navigate tabs:
vim.keymap.set('n', '<Right>', '<cmd>tabn<CR>', { desc = "Next tab" })
vim.keymap.set('n', '<Left>', '<cmd>tabN<CR>', { desc = "Previous tab" })
-- Navigate splits:
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left split" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to below split" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to above split" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right split" })


-- mini keybinds:
vim.keymap.set('n', '<leader>mm', MiniMap.toggle, { desc = "Toggle minimap" })
vim.keymap.set('n', '<leader>mp', MiniVisits.select_path, { desc = "Path history" })

-- Telescope init and binds:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
   builtin.find_files { find_command = { 'rg', '--files', '--hidden', '--follow', '-g', '!.git' } }
end, { desc = 'Telescope file finder' })
vim.keymap.set('n', '<leader>fc', function()
   builtin.find_files { find_command = { 'rg', '--files', '--hidden', '--follow', '--iglob', '!.git', '/home/adam/.config/nvim' } }
end, { desc = 'Telescope config finder' })
vim.keymap.set('n', '<leader>fv', function()
   venv_location = vim.lsp.buf.list_workspace_folders()[1] .. '/.venv'
   print(venv_location)
   builtin.live_grep { search_dirs = { ".venv" }, additional_args = { "--hidden", "--no-ignore" } }
end, { desc = 'Telescope venv searcher' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Tab formatting
local tab_spaces = 3
vim.opt.tabstop = tab_spaces     -- A TAB character looks like X spaces
vim.opt.expandtab = true         -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = tab_spaces -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = tab_spaces  -- Number of spaces inserted when indenting

-- Omni-func completion settings
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview", "popup" } -- preview/popup isn't working in python files for some reason
-- vim.keymap.set('i', '<C-J>', '<C-x><C-o>', { noremap = true, silent = true, desc = "Autocomplete" })
-- Might need this:
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(ev)
--         vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })
--     end,
-- })

-- Leap keybind initialization
--require('leap').create_default_mappings()

-- Hop keybinds for character search
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', 'F', function()
   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', 't', function()
   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, { remap = true })
vim.keymap.set('n', 's', '<cmd>HopWord<CR>', { desc = 'Hop to word' })

-- Gutter Icons and highlights
vim.diagnostic.config({
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = ' 󰈸',
         [vim.diagnostic.severity.WARN] = ' ',
         [vim.diagnostic.severity.HINT] = ' ',
      },
      linehl = {
      },
      numhl = {
         -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
         -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
      },
   },
})

-- Terminal binds and colorscheme switch:
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.api.nvim_create_augroup("TerminalColors", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
   group = "TerminalColors",
   pattern = "*",
   callback = function()
      vim.defer_fn(function()
         vim.cmd("colorscheme zenburned")
      end, 10) -- Delay in ms to ensure proper initialization
   end,
})

vim.api.nvim_create_autocmd("BufEnter", {
   group = "TerminalColors",
   pattern = "*",
   callback = function()
      if vim.bo.buftype == 'terminal' then
         -- Delay the colorscheme change slightly to ensure everything is initialized
         vim.defer_fn(function()
            vim.cmd("colorscheme zenburned")
         end, 10)
      end
   end,
})

vim.api.nvim_create_autocmd("BufLeave", {
   group = "TerminalColors",
   pattern = "*",
   callback = function()
      if vim.bo.buftype == 'terminal' then
         -- Restore the default colorscheme when leaving the terminal buffer
         vim.cmd("colorscheme zenbones") -- for some reason it needs to be run twice
         vim.cmd("set background=light")
         vim.defer_fn(function()
            vim.cmd("colorscheme zenbones")
         end, 10)
      end
   end,
})

-- Highlight text while yanking
vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight text while yanking',
   callback = function()
      vim.highlight.on_yank()
   end,
})

-- Aerial settings
require("aerial").setup({
   -- Priority list of preferred backends for aerial.
   backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
   -- optionally use on_attach to set keymaps when aerial has attached to a buffer
   on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
   end,
   layout = {
      -- These control the width of the aerial window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a list of mixed types.
      -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
      max_width = { 40, 0.2 },
      width = nil,
      min_width = 17,

      -- key-value pairs of window-local options for aerial window (e.g. winhl)
      win_opts = {},

      -- Determines the default direction to open the aerial window. The 'prefer'
      -- options will open the window in the other direction *if* there is a
      -- different buffer in the way of the preferred direction
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = "prefer_right",

      -- Determines where the aerial window will be opened
      --   edge   - open aerial at the far right/left of the editor
      --   window - open aerial to the right/left of the current window
      placement = "window",

      -- When the symbols change, resize the aerial window (within min/max constraints) to fit
      resize_to_content = true,

      -- Preserve window size equality with (:help CTRL-W_=)
      preserve_equality = false,
   }
})
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<leader>A", "<cmd>Telescope aerial<CR>")
