local theme = require('core/utils').include('config').ui.theme
local C = require('nightfox/palette').load(theme)
local get_hex = require('cokeline/utils').get_hex

local str_rep = string.rep

local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')

local min_buffer_width = 25

local components = {
    space0 = { --
        text = ' ',
        truncation = { priority = 1 },
    },

    space1 = { --
        text = ' ',
        truncation = { priority = 1 },
    },

    left_half = {
        -- text = '',
        text = '|',
        fg = C.bg2,
        bg = C.bg0,
        truncation = { priority = 1 },
    },

    right_half = {
        -- text = '',
        text = ' ',
        -- fg = C.bg2,
        -- bg = C.bg1,
        truncation = { priority = 1 },
    },

    devicon = {
        text = function(buffer)
            return buffer.devicon.icon
        end,
        fg = function(buffer)
            return buffer.devicon.color
        end,
        truncation = { priority = 1 },
    },

    index = {
        text = function(buffer)
            return buffer.index .. ': '
        end,
        fg = function(buffer)
            if buffer.diagnostics.errors ~= 0 then
                return errors_fg
            end
            if buffer.diagnostics.warnings ~= 0 then
                return warnings_fg
            end
            return nil
        end,
        truncation = { priority = 1 },
    },

    unique_prefix = {
        text = function(buffer)
            return buffer.unique_prefix
        end,
        fg = C.comment,
        style = 'italic',
        truncation = { priority = 3, direction = 'left' },
    },

    filename = {
        text = function(buffer)
            return buffer.filename
        end,
        fg = function(buffer)
            if buffer.diagnostics.errors ~= 0 then
                return errors_fg
            end
            if buffer.diagnostics.warnings ~= 0 then
                return warnings_fg
            end
            return nil
        end,
        style = function(buffer)
            if buffer.is_focused and buffer.diagnostics.errors ~= 0 then
                return "bold,underline"
            end
            if buffer.is_focused then
                return "bold"
            end
            if buffer.diagnostics.warnings ~= 0 then
                return "underline"
            end
            return nil
        end,
        truncation = { priority = 2, direction = 'left' },
    },

    close_or_unsaved = {
        text = function(buffer)
            return buffer.is_modified and '●' or ''
        end,
        fg = function(buffer)
            return buffer.is_modified and C.green.dim or nil
        end,
        delete_buffer_on_left_click = true,
        truncation = { priority = 1 },
    },
}

local get_remaining_space = function(buffer)
    local used_space = 0
    for _, component in pairs(components) do
        used_space = used_space + vim.fn.strwidth( --
        (type(component.text) == 'string' and component.text)
            or (type(component.text) == 'function' and component.text(buffer)))
    end
    return math.max(0, min_buffer_width - used_space)
end

local left_padding = {
    text = function(buffer)
        local remaining_space = get_remaining_space(buffer)
        return str_rep(' ', remaining_space / 2 + remaining_space % 2)
    end,
}

local right_padding = {
    text = function(buffer)
        local remaining_space = get_remaining_space(buffer)
        return str_rep(' ', remaining_space / 2)
    end,
}

require('cokeline').setup({
    show_if_buffers_are_at_least = 2,

    buffers = {
        filter_valid = function(buffer)
            if buffer.filetype == "qf" then
                return false
            end
            return true
        end,
        focus_on_delete = 'next',
        new_buffers_position = 'next',
    },

    rendering = { max_buffer_width = min_buffer_width },

    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and C.fg1 or C.comment
        end,
        bg = C.bg2,
    },

    sidebar = {
        filetype = 'neo-tree',
        components = { --
            { text = '  NeoTree', style = 'bold' },
        },
    },

    components = {
        components.left_half,
        left_padding,
        components.space0,
        components.devicon,
        components.index,
        components.unique_prefix,
        components.filename,
        components.space1,
        right_padding,
        components.close_or_unsaved,
        components.right_half,
    },
})
