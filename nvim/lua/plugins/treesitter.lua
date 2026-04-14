-- Treesitter is a new parser generator tool that we can
-- use in Neovim to power faster and more accurate
-- syntax highlighting.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- master branch is deprecated, use main for nvim 0.12+
    build = ":TSUpdate",
    event = "VeryLazy",
    lazy = false,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    ------@param opts TSConfig
    ---config = function(_, opts)
    ---  if type(opts.ensure_installed) == "table" then
    ---    opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    ---  end
    ---  require("nvim-treesitter.configs").setup(opts)
    ---end,
  },

--   {
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     event = "VeryLazy",
--     enabled = true,
--     config = function()
--       -- If treesitter is already loaded, we need to run config again for textobjects
--       -- if LazyVim.is_loaded("nvim-treesitter") then
--       --   local opts = LazyVim.opts("nvim-treesitter")
--       --   require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
--       -- end
--
--       -- When in diff mode, we want to use the default
--       -- vim text objects c & C instead of the treesitter ones.
--       local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
--       local configs = require("nvim-treesitter.configs")
--       for name, fn in pairs(move) do
--         if name:find("goto") == 1 then
--           move[name] = function(q, ...)
--             if vim.wo.diff then
--               local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
--               for key, query in pairs(config or {}) do
--                 if q == query and key:find("[%]%[][cC]") then
--                   vim.cmd("normal! " .. key)
--                   return
--                 end
--               end
--             end
--             return fn(q, ...)
--           end
--         end
--       end
--     end,
--   },
   {
     "nvim-treesitter/nvim-treesitter-textobjects",
     branch = "main",
     init = function()
       -- Disable entire built-in ftplugin mappings to avoid conflicts.
       -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
       vim.g.no_plugin_maps = true

       -- Or, disable per filetype (add as you like)
       -- vim.g.no_python_maps = true
       -- vim.g.no_ruby_maps = true
       -- vim.g.no_rust_maps = true
       -- vim.g.no_go_maps = true
     end,
     config = function()
       -- put your config here
     end,
   },
}
