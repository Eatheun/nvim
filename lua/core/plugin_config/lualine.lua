return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()
        require("lualine").setup {
            options = {
                icons_enabled = true,
            },
            sections = {
                lualine_a = {
                    {
                        'filename',
                        path = 1,
                    }
                },
                lualine_x = {
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },
            }
        }
    end,
}
