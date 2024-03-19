local npairs = require('nvim-autopairs')
local conds = require('nvim-autopairs.conds')
-- local ts_conds = require('nvim-autopairs.ts-conds')
local Rule = require('nvim-autopairs.rule')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

npairs.setup {
  -- check_ts = true,
}

-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

npairs.add_rules {
  Rule('<', '>', {'rust', 'typescript'})
    :with_pair(conds.not_before_text(' '))
    :with_move(conds.move_right())
    -- :with_pair(ts_conds.is_not_ts_node({'binary_expression'}))
    -- :with_pair(ts_conds.is_ts_node({
    --   'type_arguments',
    --   'function_declaration',
    --   'struct_item',
    -- }))
}
