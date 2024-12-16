vim.wo.number = true
vim.opt.relativenumber = true

vim.o.background = "light"
vim.cmd("set termguicolors")

require("config.lazy")

vim.cmd("colorscheme zenbones")
vim.cmd("set signcolumn=yes") -- predesignate space for warning and git marks

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
         lint = { enable = true },
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
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { noremap = true, silent = true, desc = "LSP Formatter" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Default LSP Hover" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
-- below are from https://wagomu.me/blog/2023-05-17-vim-ekiden
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- Tab formatting
local tab_spaces = 3
vim.o.tabstop = tab_spaces     -- A TAB character looks like X spaces
vim.o.expandtab = true         -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = tab_spaces -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = tab_spaces  -- Number of spaces inserted when indenting

-- Omni-func completion settings
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.keymap.set('i', '<C-J>', vim.lsp.omnifunc, { noremap = true, silent = true, desc = "Autocomplete" })

-- Telescope init and binds:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
