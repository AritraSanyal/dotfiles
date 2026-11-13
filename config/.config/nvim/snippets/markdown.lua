local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- SNIPPET ADDING EXPERIMENT CALLOUT
  s({ trig = 'experiment', desc = 'Insert experimental callout' }, {
    t { '> [!EXPERIMENT]', '> ' },
    i(1),
  }),
  s({ trig = 'exp', desc = 'Insert experimental callout' }, {
    t { '> [!EXPERIMENT]', '> ' },
    i(1),
  }),

  -- SNIPPET ADDING D2 CODE SNIPPET
  s({ trig = 'd2', desc = 'Insert D2 Diagram' }, {
    t { '```d2', '' },
    i(1),
    t { '', '```' },
  }),
}
