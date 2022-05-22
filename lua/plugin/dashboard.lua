local g = vim.g
local fn = vim.fn

local plugins_count = fn.len(vim.fn.globpath(fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))

g.dashboard_default_executive = "telescope"

g.dashboard_custom_header = {
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    '',
    '',
}

g.dashboard_custom_section = {
    a = {
        description = { "   Find File                 SPC f f" },
        command = "Telescope find_files",
    },
    b = {
        description = { "   Recents                   SPC f r" },
        command = "Telescope oldfiles",
    },
    c = {
        description = { "   Search Word               SPC s w" },
        command = "Telescope live_grep",
    },
    d = {
        description = { "   New File                  SPC f n" },
        command = "DashboardNewFile",
    },
    e = {
        description = { "   Bookmarks                 SPC f m" },
        command = "Telescope marks",
    },
    f = {
        description = { "   Last Workspace            SPC w l" },
        command = "SessionLoad",
    },
}

g.dashboard_custom_footer = {
    " ",
    (" Loaded %s plugins "):format(plugins_count),
}
