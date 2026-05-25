local function filterDuplicates(array)
  local uniqueArray = {}
  for _, tableA in ipairs(array) do
    local isDuplicate = false
    for _, tableB in ipairs(uniqueArray) do
      if vim.deep_equal(tableA, tableB) then
        isDuplicate = true
        break
      end
    end
    if not isDuplicate then
      table.insert(uniqueArray, tableA)
    end
  end
  return uniqueArray
end

local M = {}

function M.on_list(options)
  options.items = filterDuplicates(options.items)
  vim.fn.setqflist({}, ' ', options)
  vim.cmd('botright copen')
end

return M
