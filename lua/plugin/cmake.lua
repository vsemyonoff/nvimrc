local config = require('cmake/project_config')
local path = require('plenary/path')
local cmake = require('cmake')

cmake.setup({
    parameters_file = '.project',
    build_dir = tostring(path:new('{cwd}', 'build', '{build_type}')),
    default_projects_path = tostring(path:new(vim.loop.os_homedir(), 'Sources')),
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
    build_args = { '-- -j8' },
    on_build_output = function(line)
        local match = string.match(line or "", "(%[.*%])")
        if match then
            vim.b.progress = string.gsub(match, "%%", "%%%%")
        end
    end,
    quickfix_height = 15,
    quickfix_only_on_error = true,
    dap_configuration = { type = 'cpp', request = 'launch' },
    -- dap_configuration = {
    --     type = 'codelldb',
    --     request = 'launch',
    --     stopOnEntry = false,
    --     runInTerminal = false,
    -- },
    dap_open_command = require('dap').repl.open,
})

local cmake_build = function(build_all)
    if vim.b.building then
        return
    end

    local all = build_all or false
    vim.b.building = true
    vim.b.progress = 0
    local job = all and cmake.build_all() or cmake.build()
    job:after(vim.schedule_wrap(function(_, exit_code)
        vim.b.building = false
        local target = "Build all targets"
        if not all then
            target = config.new().json.current_target
        end
        if exit_code == 0 then
            vim.notify("Target was built successfully", vim.log.levels.INFO, {
                title = target,
            })
        else
            vim.notify("Target build failed", vim.log.levels.ERROR, {
                title = target,
            })
        end
    end))
end

vim.api.nvim_create_user_command("CMakeBuild", cmake_build, {
    desc = "Build current project",
})

local cmake_clean = function()
    local job = cmake.clean()
    job:after(vim.schedule_wrap(function(_, exit_code)
        local project = config.new()
        local target = project.json.current_target
        if exit_code == 0 then
            vim.notify("Target was cleaned successfully", vim.log.levels.INFO, {
                title = target,
            })
        else
            vim.notify("Target clean failed", vim.log.levels.ERROR, {
                title = target,
            })
        end
    end))
end

vim.api.nvim_create_user_command("CMakeClean", cmake_clean, {
    desc = "Clean current project",
})
