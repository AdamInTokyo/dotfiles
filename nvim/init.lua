vim.wo.number = true
vim.opt.relativenumber = true

vim.o.background = "light"
vim.cmd("set termguicolors")

require("config.lazy")

vim.cmd("colorscheme zenbones")
vim.cmd("set signcolumn=yes") -- predesignate space for warning and git marks
vim.opt.statuscolumn = '%=%{(v:relnum >= 1)?v:relnum.\"\":\"\"}' .. '%{(v:relnum == 0)?"♪".v:lnum.\"\":\"\"}%s'
vim.opt.cursorline = true

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

-- Python stuff
vim.g.python_recommended_style = 0

-- LSP servers
require("lspconfig").basedpyright.setup {
   settings = {
      basedpyright = {
         analysis = {
            -- ignore = { "*" },
            typeCheckingMode = "basic",
         },
      },
   },
}
require("lspconfig").ruff.setup {
   init_options = {
      settings = {
         configuration = "~/.config/nvim/ruff.toml",
         lint = { enable = false },
      }
   }
}
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").lua_ls.setup {}

-- Linters
require("lint").linters_by_ft = {
   --  lua = {"stylua"},
}

-- Key binds
vim.keymap.set('n', '<leader>gf', "<cmd>lua vim.fn.setreg('+', vim.fn.expand('%:p'))<CR>",
   { noremap = true, desc = "Copy file path to clipboard" })
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { noremap = true, silent = true, desc = "LSP Formatter" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Default LSP Hover" })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "LSP Signature Help" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set('n', '<leader>uh', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
   { noremap = true, silent = true, desc = "Toggle inlay hints" })
vim.keymap.set('n', 'gee', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', 'ge]', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', 'ge[', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "LSP references list" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Tab formatting
local tab_spaces = 3
vim.opt.tabstop = tab_spaces     -- A TAB character looks like X spaces
vim.opt.expandtab = true         -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = tab_spaces -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = tab_spaces  -- Number of spaces inserted when indenting

-- Omni-func completion settings
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview", "popup" } -- preview isn't working
vim.keymap.set('i', '<C-J>', '<C-x><C-o>', { noremap = true, silent = true, desc = "Autocomplete" })

-- Telescope init and binds:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

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
