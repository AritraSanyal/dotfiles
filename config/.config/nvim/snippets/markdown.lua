local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- List of all callouts supported by render-markdown config
local callouts = {
  'NOTE',
  'TIP',
  'IMPORTANT',
  'WARNING',
  'CAUTION',
  'ABSTRACT',
  'SUMMARY',
  'TLDR',
  'INFO',
  'TODO',
  'HINT',
  'SUCCESS',
  'CHECK',
  'DONE',
  'QUESTION',
  'HELP',
  'FAQ',
  'ATTENTION',
  'FAILURE',
  'FAIL',
  'MISSING',
  'DANGER',
  'ERROR',
  'BUG',
  'EXAMPLE',
  'QUOTE',
  'CITE',
  'EXPERIMENT',
}

local snippets = {
  -- ADDING D2 CODE SNIPPET
  s({ trig = 'd2', desc = 'Insert D2 Diagram' }, {
    t { '```d2', '' },
    i(1),
    t { '', '```' },
  }),

  -- GENERIC CALLOUT SNIPPET
  s({ trig = 'callout', desc = 'Insert Customj Callout' }, {
    t '> [!',
    i(1, 'NOTE'),
    t { ']', '> ' },
    i(2),
  }),
}

-- GENERATE SNIPPETS FOR EACH CALLOUT AUTOMATICALLY
for _, name in ipairs(callouts) do
  table.insert(
    snippets,
    s({ trig = name:lower(), desc = 'Insert' .. name .. ' callout' }, {
      t { '> [!' .. name .. ']', '> ' },
      i(1),
    })
  )
end

return snippets
