-- Utility functions for Neovim configuration
local M = {}

-- Helper function to check if a plugin is available
function M.has_plugin(plugin_name)
  return pcall(require, plugin_name)
end

-- Helper function to safely require a module
function M.safe_require(module_name)
  local ok, module = pcall(require, module_name)
  if not ok then
    vim.notify("Failed to load module: " .. module_name, vim.log.levels.ERROR)
    return nil
  end
  return module
end

-- Helper function to create keymaps with consistent options
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M