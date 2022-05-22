local M = { hl = {}, provider = {}, conditional = {} }
local C = require('nightfox/palette').load('nightfox')

local function hl_by_name(name) return string.format("#%06x", vim.api.nvim_get_hl_by_name(name.group, true)[name.prop]) end

local function hl_prop(group, prop)
    local status_ok, color = pcall(hl_by_name, { group = group, prop = prop })
    return status_ok and color or nil
end

local modes = {
    ["n"] = { "NORMAL", "Normal", C.blue },
    ["no"] = { "N-PENDING", "Normal", C.blue },
    ["i"] = { "INSERT", "Insert", C.green },
    ["ic"] = { "INSERT", "Insert", C.green },
    ["t"] = { "TERMINAL", "Insert", C.green },
    ["v"] = { "VISUAL", "Visual", C.purple },
    ["V"] = { "V-LINE", "Visual", C.purple },
    [""] = { "V-BLOCK", "Visual", C.purple },
    ["R"] = { "REPLACE", "Replace", C.red_1 },
    ["Rv"] = { "V-REPLACE", "Replace", C.red_1 },
    ["s"] = { "SELECT", "Visual", C.orange_1 },
    ["S"] = { "S-LINE", "Visual", C.orange_1 },
    [""] = { "S-BLOCK", "Visual", C.orange_1 },
    ["c"] = { "COMMAND", "Command", C.yellow_1 },
    ["cv"] = { "COMMAND", "Command", C.yellow_1 },
    ["ce"] = { "COMMAND", "Command", C.yellow_1 },
    ["r"] = { "PROMPT", "Inactive", C.grey_7 },
    ["rm"] = { "MORE", "Inactive", C.grey_7 },
    ["r?"] = { "CONFIRM", "Inactive", C.grey_7 },
    ["!"] = { "SHELL", "Inactive", C.grey_7 },
}

M.hl = {
    group = function(hlgroup, base)
        return vim.tbl_deep_extend("force", --
        base or {}, {
            fg = hl_prop(hlgroup, "foreground"),
            bg = hl_prop(hlgroup, "background"),
        })
    end,

    fg = function(hlgroup, base)
        return vim.tbl_deep_extend("force", base or {}, {
            fg = hl_prop(hlgroup, "foreground"),
        })
    end,

    mode = function(base)
        local lualine_avail, lualine = pcall(require, "lualine.themes." .. vim.g.colors_name)
        return function()
            return M.hl.group("Feline" .. modes[vim.fn.mode()][2],
                              vim.tbl_deep_extend("force",
                                                  lualine_avail and lualine[modes[vim.fn.mode()][2]:lower()].a
                                                      or {
                    fg = C.bg_1,
                    bg = modes[vim.fn.mode()][3],
                }, base or {}))
        end
    end,
}

M.provider = {
    lsp_progress = function()
        local Lsp = vim.lsp.util.get_progress_messages()[1]
        return Lsp and string.format(" %%<%s %s %s (%s%%%%) ",
                                     ((Lsp.percentage or 0) >= 70 and {
            "",
            "",
            "",
        } or { "", "", "" })[math.floor(vim.loop.hrtime() / 12e7) % 3 + 1], Lsp.title or "", Lsp.message or "",
                                     Lsp.percentage or 0) or ""
    end,

    lsp_client_names = function()
        return function()
            local buf_client_names = {}
            for _, client in ipairs(vim.lsp.buf_get_clients(0)) do
                table.insert(buf_client_names, client.name)
                -- end
            end
            return table.concat(buf_client_names, ", ")
        end
    end,

    treesitter_status = function()
        local ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
        return (ts and next(ts)) and " 綠TS" or ""
    end,

    spacer = function(n) return string.rep(" ", n or 1) end,

    lsp_project_name = function()
        local project = vim.lsp.buf.list_workspace_folders()[1]
        if not project then
            return ""
        end
        project = require('core/utils').basename(project)
        return ("[%s]"):format(project)
    end,
}

M.conditional = {
    git_available = function() return vim.b.gitsigns_head ~= nil end,

    git_changed = function()
        local git_status = vim.b.gitsigns_status_dict
        return git_status and (git_status.added or 0) + (git_status.removed or 0) + (git_status.changed or 0) > 0
    end,

    has_filetype = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1 and vim.bo.filetype and vim.bo.filetype ~= ""
    end,

    bar_width = function(n)
        return function()
            return (vim.opt.laststatus:get() == 3 and vim.opt.columns:get() or vim.fn.winwidth(0)) > (n or 80)
        end
    end,

    has_lsp_project = function() return M.provider.lsp_project_name() ~= "" end,
}

return M
