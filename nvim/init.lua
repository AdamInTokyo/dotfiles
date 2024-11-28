vim.wo.number = true
vim.opt.relativenumber = true


vim.o.background = "light"
vim.cmd("set termguicolors")

require("config.lazy")

vim.cmd("colorscheme zenbones")

-- LSP servers
require("lspconfig").basedpyright.setup{}
require("lspconfig").lua_ls.setup{}

-- Formatters
require("lint").linters_by_ft = {
--  lua = {"stylua"},
}

-- Key binds
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Default LSP Hover" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
