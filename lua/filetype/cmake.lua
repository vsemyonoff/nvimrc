local M = {}

M.setup = function(_, _)
    local include = require('core/utils').pkg_include
    include('mappings/cmake').setup()
end

return M
