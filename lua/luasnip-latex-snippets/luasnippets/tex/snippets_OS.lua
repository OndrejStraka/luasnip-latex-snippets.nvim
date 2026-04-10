
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- [
-- personal imports
-- ]
local tex = require("luasnip-latex-snippets.luasnippets.tex.utils.conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin



M = {
  autosnippet({ trig = "bfr", name = "begin frame", dscr = "Beamer Frame Environment" },
    {
      t({ "\\begin{frame}{" }),
      i(1, "frame title"),
      t({ "}", "\t" }),
      i(0),
      t({ "", "\\end{frame}" }),
    }, 
    { condition =  tex.in_beamer * line_begin , show_condition = tex.in_beamer * line_begin}),

  autosnippet({ trig = 'beq', name = 'Equation Environment', dscr = 'Create an equation environment.' },
    { 
      t({ "\\begin{equation}", "\t" }),
      i(1, "content"), 
      t({ "", "\\end{equation}" }),
    },
    { condition =  tex.in_text * line_begin , show_condition = tex.in_beamer * line_begin}),
  
  autosnippet( { trig = 'bseq', name = 'Equation Environment without number', dscr = 'Create a star equation environment.' },
    { 
      t({ '\\begin{equation*}', '\t' }),
      i(1, "content"),
      t({ '', '\\end{equation*}' }),
    },
    { condition =  tex.in_text * line_begin , show_condition = tex.in_beamer * line_begin}),
  
  autosnippet( { trig = 'bal', name = 'Align Environment', dscr = 'Create an align environment.' },
    {
      t({ '\\begin{align}' }),
      t({ '\\label{ali:' }),
      i(1, "label"),
      t({ '}', '\t' }),
      i(0, "content"),
      t({ '', '\\end{align}' })
    },
    { condition =  tex.in_text * line_begin , show_condition = tex.in_beamer * line_begin}),


  autosnippet( { trig = 'bsal', name = 'Align Environment without number', dscr = 'Create a star equation environment.' },
    { 
      t({ '\\begin{align*}', '\t' }),
      i(1, "content"),
      t({ '', '\\end{align*}' }),
    },
    { condition =  tex.in_text * line_begin , show_condition = tex.in_beamer * line_begin}),

  autosnippet({ trig = "col2", name = "two columns", dscr = "Columns Environment" }, 
    {
      t({ "\\begin{columns}", "\t\\begin{column}{0." }),
      i(1, "left width"),
      t({ "\\textwidth}", "\t\\centering\t", "\t" }),
      i(2, "left content"),
      t({ "", "\t\\end{column}", "\t\\begin{column}{0." }),
      i(3, "right width"),
      t({ "\\textwidth}", "\t\\centering\t", "\t" }),
      i(4, "right content"),
      t({ "", "\t\\end{column}", "\\end{columns}" }),
      i(0),
    }, { condition = tex.in_beamer * line_begin, show_condition = tex.in_beamer * line_begin }),

  autosnippet({ trig = "sec", name = "Section", dscr = "Insert a section in beamer." }, 
    {
      t({ "\\section{" }),
      i(1),
      t({ "}", "", "" }),
    },
    { condition = tex.in_beamer * line_begin, show_condition = tex.in_beamer * line_begin  }),

  autosnippet({ trig = "OY", name = "Owl Yellow", dscr = "Insert Owl Yellow Style." },
    { t("\\OY{"), i(1), t("}") },
    { condition = tex.in_beamer, show_condition = tex.in_beamer }
  ),

  autosnippet(
    { trig = "OR", name = "Owl Red", dscr = "Insert Owl Red Style." },
    { t("\\OR{"), i(1), t("}") },
    { condition = tex.in_beamer, show_condition = tex.in_beamer }
  ),

  autosnippet(
    { trig = "OB", name = "Owl Blue", dscr = "Insert Owl Blue Style." },
    { t("\\OB{"), i(1), t("}") },
    { condition = tex.in_beamer, show_condition = tex.in_beamer }
  ),
}
return M
