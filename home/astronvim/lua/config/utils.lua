vim.utils = {
  ---Looks for the last match of `pattern`
  ---@param s       string|number
  ---@param pattern string|number
  ---@param init?   integer
  ---@param plain?  boolean
  ---@return integer|nil start
  ---@return integer|nil end
  ---@return any|nil ... captured
  find_back = function(s, pattern, init, plain)
    s = init and s:sub(1, init) or s
    local match = {}
    local last = {}
    repeat
      match = { s:find(pattern, match[1] and match[1] + 1, plain) }
      if match[1] then last = vim.deepcopy(match) end
    until not match[1]
    return unpack(last)
  end,
  termcodes = function(s) return vim.api.nvim_replace_termcodes(s, true, true, true) end,
  operatorfunc_mode_to_key = function(mode)
    return mode and ({ char = "v", line = "V", block = vim.utils.termcodes "<C-v>" })[mode] or "v"
  end,
  tbl_remove = function(t, k)
    local x = t[k]
    t[k] = nil
    return x
  end,
  executable = function(s) return vim.fn.executable(s) == 1 end,
}
