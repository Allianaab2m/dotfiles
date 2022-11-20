local conditionalSections = function ()
  local sections = {
      left = { '- ', '-mode', 'left_sep', 'file_name' },
      mid  = {},
      right = {'lsp_name', 'right_sep_double', '-line_column' },
  }
  local branchIcon = ' '

  if (vim.fn.isdirectory('.git') == 0) then
  else
    sections.left = { '- ', '-mode', '-branch', 'left_sep_double', 'file_name' }

    local handle = io.popen("git remote get-url origin")
    local result = handle:read("*a")
    handle:close()
    if string.find(result, 'github') then
      branchIcon = ' '
    else
    end
  end

  local status_ok, navic = pcall(require, 'nvim-navic')
  if status_ok then
    sections.mid = { navic.get_location }
  end

  return {
    sections = sections,
    branchIcon = branchIcon
  }
end

local stalineSetupOpt = conditionalSections()
require('staline').setup({
  defaults = {
    branch_symbol = stalineSetupOpt.branchIcon
  },
  sections = stalineSetupOpt.sections
})

