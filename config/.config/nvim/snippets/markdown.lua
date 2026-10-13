local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({ trig = "experiment", desc = "Insert experimental callout" }, {
    t({ "> [!EXPERIMENT]", "> " }),
    i(1),
  }),
  s({ trig = "exp", desc = "Insert experimental callout" }, {
    t({ "> [!EXPERIMENT]", "> " }),
    i(1),
  })
}
