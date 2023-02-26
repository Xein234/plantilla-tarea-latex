local root = vim.fn.expand('<sfile>:p:h')
local output = {}
local buf = {}
local function create_out_buf ()
  buf[1] = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_option(buf[1], 'readonly', false)
  vim.api.nvim_buf_set_option(buf[1], 'modifiable', false)
end

local projectCompile = function (log_buf)
  for k in pairs(output) do
      output[k] = nil
  end

  local current = vim.fn.expand('%:p')
  if current:sub(1, #root) ~= root then
    return
  end
  vim.fn.jobstart({'doit', 'build'}, {
    stdout_buffered = true,
    on_stdout = function (_, data)
      for _, value in pairs(data) do
        print(vim.inspect(value))
        table.insert(output, value)
      end
    end})
end
-- vim.keymap.set('n', '<F3>', projectCompile, {noremap = true})

vim.api.nvim_set_keymap('n', '<F3>', ':!doit build<CR>', {noremap = true})
