 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#101418',
    base01 = '#1c2024',
    base02 = '#272a2f',
    base03 = '#8c9198',
    base04 = '#c2c7cf',
    base05 = '#e0e2e8',
    base06 = '#e0e2e8',
    base07 = '#e0e2e8',
    base08 = '#ffb4ab',
    base09 = '#d2bfe6',
    base0A = '#b9c8da',
    base0B = '#9acbfa',
    base0C = '#d2bfe6',
    base0D = '#9acbfa',
    base0E = '#b9c8da',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e0e2e8',          bg = '#101418' })
  hi('TelescopeBorder',         { fg = '#8c9198',             bg = '#101418' })
  hi('TelescopePromptNormal',   { fg = '#e0e2e8',          bg = '#101418' })
  hi('TelescopePromptBorder',   { fg = '#8c9198',             bg = '#101418' })
  hi('TelescopePromptPrefix',   { fg = '#9acbfa',             bg = '#101418' })
  hi('TelescopePromptCounter',  { fg = '#c2c7cf',  bg = '#101418' })
  hi('TelescopePromptTitle',    { fg = '#101418',             bg = '#9acbfa' })
  hi('TelescopePreviewTitle',   { fg = '#101418',             bg = '#b9c8da' })
  hi('TelescopeResultsTitle',   { fg = '#101418',             bg = '#d2bfe6' })
  hi('TelescopeSelection',      { fg = '#e0e2e8',          bg = '#272a2f' })
  hi('TelescopeSelectionCaret', { fg = '#9acbfa',             bg = '#272a2f' })
  hi('TelescopeMatching',       { fg = '#9acbfa',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
