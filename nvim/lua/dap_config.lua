local dap = require('dap')
local widgets = require('dap.ui.widgets')

vim.keymap.set('n', '<space>dc', function() dap.continue() end)
vim.keymap.set('n', '<space>do', function() dap.step_over() end)
vim.keymap.set('n', '<space>di', function() dap.step_into() end)
vim.keymap.set('n', '<space>dO', function() dap.step_out() end)
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)

vim.keymap.set('n', '<space>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<space>dlb', function() dap.list_breakpoints() end)
vim.keymap.set('n', '<space>dlp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

vim.keymap.set({'n', 'v'}, '<space>dh', function() widgets.hover() end)
vim.keymap.set({'n', 'v'}, '<space>dp', function() widgets.preview() end)

vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)

vim.keymap.set('n', '<space>ds', function() widgets.centered_float(widgets.scopes) end)
vim.keymap.set('n', '<space>dvs', function() widgets.sidebar(widgets.scopes).open() end)

vim.keymap.set('n', '<space>df', function() widgets.centered_float(widgets.frames) end)
vim.keymap.set('n', '<space>dvf', function() widgets.sidebar(widgets.frames).open() end)

vim.keymap.set('n', '<space>de', function() widgets.centered_float(widgets.expression) end)
vim.keymap.set('n', '<space>dve', function() widgets.sidebar(widgets.expression).open() end)

vim.keymap.set('n', '<space>dt', function() widgets.centered_float(widgets.threads) end)
vim.keymap.set('n', '<space>dvt', function() widgets.sidebar(widgets.threads).open() end)

vim.keymap.set('n', '<space>dS', function() widgets.centered_float(widgets.sessions) end)
vim.keymap.set('n', '<space>dvS', function() widgets.sidebar(widgets.sessions).open() end)
