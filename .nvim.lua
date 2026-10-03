vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "love",
                    "vim",
                },
            },
            workspace = {
                checkThirdParty = false,
                enableTelemetry = false,
                library = {
                    "${3rd}/love2d/library"
                },
            },
        },
    },
})

vim.keymap.set('n', '<leader>ls', ':! love .<CR>')
