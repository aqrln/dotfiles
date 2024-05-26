local neotest = require("neotest")

neotest.setup {
  adapters = {
    require("rustaceanvim.neotest"),
    require("neotest-vitest"),
  },
}

vim.keymap.set("n", "<space>Tr", function()
  neotest.run.run()
end, { desc = "run tests" })

vim.keymap.set("n", "<space>Ts", function()
  neotest.run.stop()
end, { desc = "stop tests" })

vim.keymap.set("n", "<space>Tf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "run current file" })

vim.keymap.set("n", "<space>Td", function()
  neotest.run.run { strategy = "dap" }
end, { desc = "debug nearest test" })

vim.keymap.set("n", "<space>Ta", function()
  neotest.run.attach()
end, { desc = "attach to nearest test" })

vim.keymap.set("n", "<space>TT", function()
  neotest.summary.toggle()
end, { desc = "toggle summary window" })

vim.keymap.set("n", "<space>Tw", function()
  neotest.watch.toggle()
end, { desc = "toggle watch" })
