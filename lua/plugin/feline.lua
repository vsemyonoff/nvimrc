local M = {}

local feline = require('feline')
local C = require('nightfox.palette').load('nightfox')
local hl = require('core/status').hl
local provider = require('core/status').provider
local conditional = require('core/status').conditional

-- stylua: ignore
feline.setup({
    disable = {
        filetypes = {
            "^NvimTree$",
            "^neo%-tree$",
            "^dashboard$",
            "^Outline$",
            "^aerial$",
        },
    },
    theme = hl.group("StatusLine", { fg = C.fg, bg = C.bg_1 }),
    components = {
        active = {
            {
                { -- Mode
                    provider = function() return (" %s "):format(vim.fn.mode()):upper() end,
                    hl = hl.mode(),
                },
                { provider = provider.spacer() },

                { -- Project name
                    provider = provider.lsp_project_name,
                    hl = hl.fg("Conditional", { fg = C.purple_1, style = "bold" }),
                    enabled = conditional.has_lsp_project,
                },
                {
                    provider = provider.spacer(),
                    enabled = conditional.has_lsp_project,
                },

                { -- File name
                    provider = { name = "file_info", opts = { type = "unique" } },
                },

                { -- File git info
                    provider = "git_diff_added",
                    hl = hl.fg("GitSignsAdd", { fg = C.green }),
                    icon = "  ",
                    enabled = conditional.git_changed,
                },
                {
                    provider = "git_diff_changed",
                    hl = hl.fg("GitSignsChange", { fg = C.orange_1 }),
                    icon = " 柳",
                    enabled = conditional.git_changed,
                },
                {
                    provider = "git_diff_removed",
                    hl = hl.fg("GitSignsDelete", { fg = C.red_1 }),
                    icon = "  ",
                    enabled = conditional.git_changed,
                },
            },
            {
                { -- LSP index progress
                    provider = provider.lsp_progress,
                    enabled = conditional.bar_width,
                },
                { provider = provider.spacer() },

                { -- LSP diagnostics
                    provider = "diagnostic_errors",
                    hl = hl.fg("DiagnosticError", { fg = C.red_1 }),
                    icon = "  ",
                },
                {
                    provider = "diagnostic_warnings",
                    hl = hl.fg("DiagnosticWarn", { fg = C.orange_1 }),
                    icon = "  ",
                },
                {
                    provider = "diagnostic_info",
                    hl = hl.fg("DiagnosticInfo", { fg = C.white_2 }),
                    icon = "  ",
                },
                {
                    provider = "diagnostic_hints",
                    hl = hl.fg("DiagnosticHint", { fg = C.yellow_1 }),
                    icon = "  ",
                },
                { provider = provider.spacer() },

                { -- Treesitter
                    provider = provider.treesitter_status,
                    enabled = conditional.bar_width,
                    hl = hl.fg("GitSignsAdd", { fg = C.green }),
                },
                { provider = provider.spacer() },

                { -- Git branch
                    provider = "git_branch",
                    hl = hl.fg("Conditional", { fg = C.purple_1, style = "bold" }),
                    icon = " ",
                    enabled = conditional.git_available,
                },
                {
                    provider = provider.spacer(),
                    enabled = conditional.git_available,
                },

                { provider = "line_percentage" },
                { provider = provider.spacer() },

                { -- Ruler
                    provider = "scroll_bar",
                    hl = hl.fg("TypeDef", { fg = C.yellow }),
                },
                { provider = provider.spacer() },
            },
        },
    },
})

return M
