local dap = require('dap')
local widgets = require('dap.ui.widgets')

vim.keymap.set('n', '<space>dc', function() dap.continue() end, { desc = "continue" })
vim.keymap.set('n', '<space>do', function() dap.step_over() end, { desc = "step over" })
vim.keymap.set('n', '<space>di', function() dap.step_into() end, { desc = "step into" })
vim.keymap.set('n', '<space>dO', function() dap.step_out() end, { desc = "step out" })
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)

vim.keymap.set('n', '<space>db', function() dap.toggle_breakpoint() end, { desc = "toggle breakpoint" })
vim.keymap.set('n', '<space>dlb', function() dap.list_breakpoints() end, { desc = "list breakpoints" })
vim.keymap.set('n', '<space>dlp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "set log point" })

vim.keymap.set({'n', 'v'}, '<space>dh', function() widgets.hover() end, { desc = "hover value" })
vim.keymap.set({'n', 'v'}, '<space>dp', function() widgets.preview() end, { desc = "preview value" })

vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "debug repl" })
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "run last" })

vim.keymap.set('n', '<space>ds', function() widgets.centered_float(widgets.scopes) end, { desc = "scopes" })
vim.keymap.set('n', '<space>dvs', function() widgets.sidebar(widgets.scopes).open() end, { desc = "scopes in sidebar" })

vim.keymap.set('n', '<space>df', function() widgets.centered_float(widgets.frames) end, { desc = "frames" })
vim.keymap.set('n', '<space>dvf', function() widgets.sidebar(widgets.frames).open() end, { desc = "frames in sidebar" })

vim.keymap.set('n', '<space>de', function() widgets.centered_float(widgets.expression) end, { desc = "expressions" })
vim.keymap.set('n', '<space>dve', function() widgets.sidebar(widgets.expression).open() end, { desc = "expressions in sidebar" })

vim.keymap.set('n', '<space>dt', function() widgets.centered_float(widgets.threads) end, { desc = "threads" })
vim.keymap.set('n', '<space>dvt', function() widgets.sidebar(widgets.threads).open() end, { desc = "threads in sidebar" })

vim.keymap.set('n', '<space>dS', function() widgets.centered_float(widgets.sessions) end, { desc = "sessions" })
vim.keymap.set('n', '<space>dvS', function() widgets.sidebar(widgets.sessions).open() end, { desc = "sessions in sidebar" })
