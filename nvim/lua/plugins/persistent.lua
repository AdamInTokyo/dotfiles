return {
  "olimorris/persisted.nvim",
  lazy = false,
  opts = {
    -- Your config goes here ...
    autoload = true,
    autosave = true,
    use_git_branch = true,
    telescope = {
       mappings = { -- Mappings for managing sessions in Telescope
         copy_session = "<C-c>",
         change_branch = "<C-b>",
         delete_session = "<C-d>",
       },
      },
   },
   config = function(_, opts)
      require("telescope").load_extension("persisted")
      require("persisted").setup(opts)
   end
}
