return {
    { "hrsh7th/cmp-nvim-lsp" },
    { "onsails/lspkind.nvim" },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd" },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local lspconfig = require("lspconfig")
            local common_capabilities = require("cmp_nvim_lsp").default_capabilities()

            local function common_on_attach(_, bufnr)
                local keymap = vim.keymap.set
                keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
                keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                keymap("n", "<leader>gf", function()
                    vim.lsp.buf.format({ async = true })
                end, { buffer = bufnr })
            end

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = common_capabilities,
                        on_attach = common_on_attach,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = common_capabilities,
                        on_attach = common_on_attach,
                        settings = {
                            Lua = { diagnostics = { globals = { "vim" } } },
                        },
                    })
                end,
                ["clangd"] = function()
                    lspconfig.clangd.setup({
                        cmd = { "clangd", "--fallback-style=Microsoft" },
                        capabilities = common_capabilities,
                        on_attach = common_on_attach,
                    })
                end,
            })

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = 'luasnip' },
                    { name = 'nvim_lua' },
                    { name = 'calc' },
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
            })

            lspconfig.glsl_analyzer.setup {
                filetypes = { "glsl", "vert", "frag" }
            }
        end,
    },
}
