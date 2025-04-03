local function time()
    return os.date('%H:%M')
end

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            -- options = {
            --     theme = "catppuccin",
            -- },
            sections = {
                lualine_z = { 'location', time },
            }
        })
    end,
}
