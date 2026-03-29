local util = {}

-- TODO: this function needs some cleaning up... for the kind2 repo some
-- directories have Makefiles in them which are not the top level directory
-- which trips this up
-- local root_names = { ".git", "Makefile" }
local root_names = { ".git" }

local root_cache = {}

function util.get_root()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
        path = vim.fn.getcwd()
    end
    local root = root_cache[path]
    if root == nil then
        local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
        if root_file == nil then
            root_file = path
        end
        root = vim.fs.dirname(root_file)
        root_cache[path] = root
    end
    return root
end

return util
