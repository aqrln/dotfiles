local dap = require('dap')
local widgets = require('dap.ui.widgets')
local dapui = require('dapui')

dapui.setup()

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
vim.keymap.set('n', '<space>dlp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
  { desc = "set log point" })

vim.keymap.set({ 'n', 'v' }, '<space>dh', function() widgets.hover() end, { desc = "hover value" })
vim.keymap.set({ 'n', 'v' }, '<space>dp', function() widgets.preview() end, { desc = "preview value" })

vim.keymap.set('n', '<space>dr', function() dap.repl.open() end, { desc = "debug repl" })
vim.keymap.set('n', '<space>dl', function() dap.run_last() end, { desc = "run last" })

vim.keymap.set('n', '<space>ds', function() widgets.centered_float(widgets.scopes) end, { desc = "scopes" })
vim.keymap.set('n', '<space>dvs', function() widgets.sidebar(widgets.scopes).open() end, { desc = "scopes in sidebar" })

vim.keymap.set('n', '<space>df', function() widgets.centered_float(widgets.frames) end, { desc = "frames" })
vim.keymap.set('n', '<space>dvf', function() widgets.sidebar(widgets.frames).open() end, { desc = "frames in sidebar" })

vim.keymap.set('n', '<space>dE', function() widgets.centered_float(widgets.expression) end, { desc = "expression" })
vim.keymap.set('n', '<space>dvE', function() widgets.sidebar(widgets.expression).open() end,
  { desc = "expression in sidebar" })

vim.keymap.set('n', '<space>dt', function() widgets.centered_float(widgets.threads) end, { desc = "threads" })
vim.keymap.set('n', '<space>dvt', function() widgets.sidebar(widgets.threads).open() end, { desc = "threads in sidebar" })

vim.keymap.set('n', '<space>dS', function() widgets.centered_float(widgets.sessions) end, { desc = "sessions" })
vim.keymap.set('n', '<space>dvS', function() widgets.sidebar(widgets.sessions).open() end,
  { desc = "sessions in sidebar" })

vim.keymap.set('n', '<space>du', function() dapui.toggle() end, { desc = "toggle dap ui" })
vim.keymap.set({ 'n', 'v' }, '<space>de', function() dapui.eval() end, { desc = "dap ui eval" })

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {vim.fn.expand("~/.local/share/nvim/lazy/vscode-js-debug/dist/src/dapDebugServer.js"), "${port}"},
  }
}

for _, language in ipairs({ 'javascript', 'javascriptreact' }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file with node",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end

for _, language in ipairs({ 'typescript', 'typescriptreact' }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file with tsx",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      runtimeExecutable = "tsx",
      args = { "${file}" },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
    },
  }
end
