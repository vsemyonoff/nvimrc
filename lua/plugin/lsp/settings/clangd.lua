local root_pattern = require('lspconfig/util').root_pattern

return {
    cmd = {
        "clangd",
        "-j=4",
        "--background-index",
        "--clang-tidy",
        "--suggest-missing-includes",
        "--log=error",
        "--compile-commands-dir=build",
    },

    root_dir = root_pattern('.git', '.project'),
}
