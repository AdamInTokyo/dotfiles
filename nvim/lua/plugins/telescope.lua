return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    height = 0.9,
                    preview_cutoff = 40,
                    prompt_position = "bottom",
                    width = 0.8
                },
            },
        }
    end
}
