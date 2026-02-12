--
-- Keyboard mapping helpers
--
local M = {}

-- Global bind
M.bind = function(mode, lhs, rhs, desc, opts)
  if type(mode) ~= "string" then
  elseif type(lhs) ~= "string" then
    error("[error]: `lhs` should be a sring")
  elseif type(rhs) ~= "string" and type(rhs) ~= "function" then
    error("[error]: `rhs` should the a string or function")
  elseif type(desc) ~= "string" then
    error("[error]: description string required for each keyboard mapping")
  end
  local options = { silent = true, desc = desc }

  -- Parse options
  if opts then
    -- TODO: check force vs keep
    options = vim.tbl_extend("force", options, opts)
  end

  -- Apply mapping
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Buffer local bind
M.lbind = function(mode, lhs, rhs, desc, opts)
  local options = { buffer = true }

  if opts then
    options = vim.tbl_extend("keep", options, opts)
  end

  M.bind(mode, lhs, rhs, desc, options)
end

-- +----------------------------------------------------------------+
-- |        | Norm | Ins  | Cmd  | Vis  | Sel  | Oper | Term | Lang |
-- |--------+------+------+------+------+------+------+------+------+
-- |   map  | yes  |  -   |  -   | yes  | yes  | yes  |  -   |  -   |
-- |  nmap  | yes  |  -   |  -   |  -   |  -   |  -   |  -   |  -   |
-- |  mapi  |  -   | yes  | yes  |  -   |  -   |  -   |  -   |  -   |
-- |  imap  |  -   | yes  |  -   |  -   |  -   |  -   |  -   |  -   |
-- |  cmap  |  -   |  -   | yes  |  -   |  -   |  -   |  -   |  -   |
-- |  vmap  |  -   |  -   |  -   | yes  | yes  |  -   |  -   |  -   |
-- |  xmap  |  -   |  -   |  -   | yes  |  -   |  -   |  -   |  -   |
-- |  smap  |  -   |  -   |  -   |  -   | yes  |  -   |  -   |  -   |
-- |  omap  |  -   |  -   |  -   |  -   |  -   | yes  |  -   |  -   |
-- |  tmap  |  -   |  -   |  -   |  -   |  -   |  -   | yes  |  -   |
-- |  lmap  |  -   | yes  | yes  |  -   |  -   |  -   |  -   | yes  |
-- +----------------------------------------------------------------+

-- Global
M.map = function(lhs, rhs, desc, opts)
  M.bind("", lhs, rhs, desc, opts)
end
M.nmap = function(lhs, rhs, desc, opts)
  M.bind("n", lhs, rhs, desc, opts)
end
M.mapi = function(lhs, rhs, desc, opts)
  M.bind("!", lhs, rhs, desc, opts)
end
M.imap = function(lhs, rhs, desc, opts)
  M.bind("i", lhs, rhs, desc, opts)
end
M.cmap = function(lhs, rhs, desc, opts)
  M.bind("c", lhs, rhs, desc, opts)
end
M.vmap = function(lhs, rhs, desc, opts)
  M.bind("v", lhs, rhs, desc, opts)
end
M.xmap = function(lhs, rhs, desc, opts)
  M.bind("x", lhs, rhs, desc, opts)
end
M.smap = function(lhs, rhs, desc, opts)
  M.bind("s", lhs, rhs, desc, opts)
end
M.omap = function(lhs, rhs, desc, opts)
  M.bind("o", lhs, rhs, desc, opts)
end
M.tmap = function(lhs, rhs, desc, opts)
  M.bind("t", lhs, rhs, desc, opts)
end
M.lmap = function(lhs, rhs, desc, opts)
  M.bind("l", lhs, rhs, desc, opts)
end

-- Buffer local
M.bmap = function(lhs, rhs, desc, opts)
  M.lbind("", lhs, rhs, desc, opts)
end
M.bnmap = function(lhs, rhs, desc, opts)
  M.lbind("n", lhs, rhs, desc, opts)
end
M.bmapi = function(lhs, rhs, desc, opts)
  M.lbind("!", lhs, rhs, desc, opts)
end
M.bimap = function(lhs, rhs, desc, opts)
  M.lbind("i", lhs, rhs, desc, opts)
end
M.bcmap = function(lhs, rhs, desc, opts)
  M.lbind("c", lhs, rhs, desc, opts)
end
M.bvmap = function(lhs, rhs, desc, opts)
  M.lbind("v", lhs, rhs, desc, opts)
end
M.bxmap = function(lhs, rhs, desc, opts)
  M.lbind("x", lhs, rhs, desc, opts)
end
M.bsmap = function(lhs, rhs, desc, opts)
  M.lbind("s", lhs, rhs, desc, opts)
end
M.bomap = function(lhs, rhs, desc, opts)
  M.lbind("o", lhs, rhs, desc, opts)
end
M.btmap = function(lhs, rhs, desc, opts)
  M.lbind("t", lhs, rhs, desc, opts)
end
M.blmap = function(lhs, rhs, desc, opts)
  M.lbind("l", lhs, rhs, desc, opts)
end

return M
