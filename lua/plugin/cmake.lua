local project_name = require('core/utils').project_name
local config = require('cmake/project_config')
local path = require('plenary/path')
local cmake = require('cmake')

cmake.setup({
    parameters_file = '.project',
    build_dir = tostring(path:new('{cwd}', 'build', '{build_type}')),
    default_projects_path = tostring(path:new(vim.loop.os_homedir(), 'Sources')),
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
    build_args = { '--', '-j8' },
    on_build_output = function(line)
        local match = string.match(line or "", "(%[.*%])")
        if match then
            vim.g.cmake_build_progress = string.gsub(match, "%%", "%%%%")
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
    if vim.g.cmake_is_building then
        return
    end

    local job = build_all and cmake.build_all() or cmake.build()
    if not job then
        return
    end

    vim.g.cmake_is_building = true
    vim.g.cmake_build_progress = 0
    job:after(vim.schedule_wrap(function(_, exit_code)
        vim.g.cmake_is_building = nil
        vim.g.cmake_build_progress = nil
        local project = project_name()
        local target = "all"
        if not build_all then
            target = config.new().json.current_target
        end
        if exit_code == 0 then
            vim.notify(("Target '%s' was built successfully"):format(target), --
            vim.log.levels.INFO, { title = project })
        else
            vim.notify(("Target '%s' build failed"):format(target), --
            vim.log.levels.ERROR, { title = project })
        end
    end))
end

vim.api.nvim_create_user_command("CMakeBuild", function()
    cmake_build(false)
end, { desc = "Build target" })

vim.api.nvim_create_user_command("CMakeBuildAll", function()
    cmake_build(true)
end, { desc = "Build all targets" })

local cmake_clean = function()
    if vim.g.cmake_is_building then
        return
    end

    local job = cmake.clean()
    if not job then
        return
    end

    job:after(vim.schedule_wrap(function(_, exit_code)
        local project = project_name()
        if exit_code == 0 then
            vim.notify("Project was cleaned successfully", --
            vim.log.levels.INFO, { title = project })
        else
            vim.notify("Project clean failed", --
            vim.log.levels.ERROR, { title = project })
        end
    end))
end

vim.api.nvim_create_user_command("CMakeClean", cmake_clean, {
    desc = "Clean current project",
})
