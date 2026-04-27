local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Document environment
  s("begin", {
    t("\\begin{"), i(1, "environment"), t("}"),
    t({"", "\t"}), i(0),
    t({"", "\\end{"}), i(1), t("}"),
  }),

  -- Itemize
  s("item", {
    t("\\begin{itemize}"),
    t({"", "\t\\item "}), i(0),
    t({"", "\\end{itemize}"}),
  }),

  -- Enumerate
  s("enum", {
    t("\\begin{enumerate}"),
    t({"", "\t\\item "}), i(0),
    t({"", "\\end{enumerate}"}),
  }),

  -- Fraction
  s("frac", {
    t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0)
  }),

  -- Bold text
  s("bf", {
    t("\\textbf{"), i(1), t("}"), i(0)
  }),

  -- Italic text
  s("it", {
    t("\\textit{"), i(1), t("}"), i(0)
  }),

  -- Math mode
  s("mk", {
    t("$"), i(1), t("$"), i(0)
  }),

  -- Display math
  s("dm", {
    t("\\["),
    t({"", "\t"}), i(1),
    t({"", "\\]"}), i(0)
  }),

  -- Section
  s("sec", {
    t("\\section{"), i(1), t("}"), i(0)
  }),

  -- Subsection
  s("sub", {
    t("\\subsection{"), i(1), t("}"), i(0)
  }),
}
