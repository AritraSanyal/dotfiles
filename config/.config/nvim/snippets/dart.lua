local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local flutter_snippets = {
  s("stless", {
    t("class "),
    i(1, "WidgetName"),
    t({ " extends StatelessWidget {", "  const " }),
    i(2, "WidgetName"),
    t("({super.key});"),
    t({ "", "", "  @override", "  Widget build(BuildContext context) {", "    return " }),
    i(3, "Widget"),
    t({ ";", "  }", "}" }),
  }),

  s("stful", {
    t("class "),
    i(1, "WidgetName"),
    t({ " extends StatefulWidget {", "  const " }),
    i(2, "WidgetName"),
    t("({super.key});"),
    t({ "", "  @override", "  State<" }),
    i(3, "WidgetName"),
    t("> createState() => _"),
    i(4, "WidgetName"),
    t("State();", "}", "", "class _"),
    i(5, "WidgetName"),
    t("State extends State<"),
    i(6, "WidgetName"),
    t({ "> {", "  @override", "  Widget build(BuildContext context) {", "    return " }),
    i(7, "Widget"),
    t({ ";", "  }", "}" }),
  }),

  s("bndl", {
    t({ "Widget build(BuildContext context) {", "  return " }),
    i(1, "Widget"),
    t({ ";", "}" }),
  }),

  s("init", {
    t({ "@override", "  void initState() {", "    super.initState();", "    " }),
    i(1, "// TODO"),
    t({ "", "  }" }),
  }),

  s("dispose", {
    t({ "@override", "  void dispose() {", "    " }),
    i(1, "// cleanup"),
    t({ "", "    super.dispose();", "  }" }),
  }),

  s("cust", {
    t("class "),
    i(1, "WidgetName"),
    t({ " extends StatelessWidget {", "  const " }),
    i(2, "WidgetName"),
    t("({super.key});"),
    t({ "", "  @override", "  Widget build(BuildContext context) {", "    return " }),
    i(3, "child"),
    t({ ";", "  }", "}" }),
  }),

  s("custful", {
    t("class "),
    i(1, "WidgetName"),
    t({ " extends StatefulWidget {", "  const " }),
    i(2, "WidgetName"),
    t("({super.key});"),
    t({ "", "  @override", "  State<" }),
    i(3, "WidgetName"),
    t("> createState() => _"),
    i(4, "WidgetName"),
    t("State();", "}", "", "class _"),
    i(5, "WidgetName"),
    t("State extends State<"),
    i(6, "WidgetName"),
    t({ "> {", "  @override", "  Widget build(BuildContext context) {", "    return " }),
    i(7, "child"),
    t({ ";", "  }", "}" }),
  }),

  s("init2", {
    t({ "void initState() {", "  super.initState();", "  " }),
    i(1, "// TODO"),
    t({ "", "}" }),
  }),

  s("rebuild", {
    t("setState(() {"),
    i(1, "// TODO"),
    t({ "});" }),
  }),

  s("ifetch", {
    t({ "Future<" }),
    i(1, "Type"),
    t({ "> fetchData() async {", "  " }),
    i(2, "// TODO"),
    t({ "", "}" }),
  }),

  s("tryc", {
    t({ "try {", "  " }),
    i(1, "// TODO"),
    t({ "", "} catch (e) {", "  " }),
    i(2, "// handle error"),
    t({ "", "}" }),
  }),

  s("log", {
    t("debugPrint('"),
    i(1, "message"),
    t("');"),
  }),

  s("assert", {
    t({ "assert(", "  " }),
    i(1, "condition"),
    t({ ",", "  '" }),
    i(2, "error message"),
    t({ "'", ");" }),
  }),

  s("test", {
    t({ "testWidgets('", }),
    i(1, "test name"),
    t({ "', (WidgetTester tester) async {", "  // Arrange", "  // Act", "  // Assert", "", "  expect(", "    " }),
    i(2, "value"),
    t({ ",", "    " }),
    i(3, "matcher"),
    t({ "", "  );", "});" }),
  }),

  s("grptest", {
    t({ "group('", }),
    i(1, "group name"),
    t({ "', () {", "  test('", }),
    i(2, "test name"),
    t({ "', () {", "    expect(", "      " }),
    i(3, "value"),
    t({ ",", "      " }),
    i(4, "matcher"),
    t({ "", "    );", "  });", "});" }),
  }),

  s("pump", {
    t("await tester.pumpAndSettle();"),
  }),

  s("pumpw", {
    t("await tester.pumpWidget("),
    i(1, "Widget"),
    t(");"),
  }),

  s("findtext", {
    t("find.text('"),
    i(1, "text"),
    t("')"),
  }),

  s("findkey", {
    t("find.byKey("),
    i(1, "key"),
    t(")"),
  }),

  s("findtype", {
    t("find.byType("),
    i(1, "WidgetType"),
    t(")"),
  }),
}

local dart_snippets = {
  s("main", {
    t("void main() {"),
    i(1, "// TODO"),
    t({ "", "}" }),
  }),

  s("print", {
    t("print('"),
    i(1, "message"),
    t("');"),
  }),

  s("fn", {
    t("void "),
    i(1, "functionName"),
    t("() {"),
    i(2, "// TODO"),
    t({ "", "}" }),
  }),

  s("afn", {
    t("Future<"),
    i(1, "void"),
    t("> "),
    i(2, "functionName"),
    t("() async {"),
    i(3, "// TODO"),
    t({ "", "}" }),
  }),

  s("fori", {
    t("for (int i = 0; i < "),
    i(1, "length"),
    t("; i++) {"),
    i(2, "// TODO"),
    t({ "", "}" }),
  }),

  s("foreach", {
    t("for (final "),
    i(1, "item"),
    t(" in "),
    i(2, "collection"),
    t(") {"),
    i(3, "// TODO"),
    t({ "", "}" }),
  }),

  s("map", {
    t("final "),
    i(1, "name"),
    t(" = <"),
    i(2, "Key"),
    t(", "),
    i(3, "Value"),
    t({ ">{", "  " }),
    i(4, "key"),
    t(": "),
    i(5, "value"),
    t({ "", "};" }),
  }),

  s("list", {
    t("final "),
    i(1, "name"),
    t(" = <"),
    i(2, "Type"),
    t({ ">[", "  " }),
    i(3, "item"),
    t({ "", "];" }),
  }),

  s("if", {
    t("if ("),
    i(1, "condition"),
    t({ ") {", "  " }),
    i(2, "// TODO"),
    t({ "", "}" }),
  }),

  s("ife", {
    t("if ("),
    i(1, "condition"),
    t({ ") {", "  " }),
    i(2, "// TODO"),
    t({ "", "} else {", "  " }),
    i(3, "// TODO"),
    t({ "", "}" }),
  }),

  s("sw", {
    t("switch ("),
    i(1, "value"),
    t({ ") {", "  case " }),
    i(2, "pattern"),
    t({ ":", "    break;", "  default:", "    break;", "}" }),
  }),

  s("class", {
    t("class "),
    i(1, "ClassName"),
    t({ " {", "  " }),
    i(2, "// TODO"),
    t({ "", "}", "" }),
  }),

  s("mixin", {
    t("mixin "),
    i(1, "MixinName"),
    t({ " on " }),
    i(2, "SuperClass"),
    t({ " {", "  " }),
    i(3, "// TODO"),
    t({ "", "}" }),
  }),

  s("ext", {
    t("extension "),
    i(1, "ExtensionName"),
    t(" on "),
    i(2, "Type"),
    t({ " {", "  " }),
    i(3, "// TODO"),
    t({ "", "}" }),
  }),

  s("null", {
    t("final "),
    i(1, "name"),
    t("? = null;"),
  }),

  s("required", {
    t("required "),
    i(1, "Type"),
    t(" "),
    i(2, "name"),
    t(";"),
  }),

  s("late", {
    t("late final "),
    i(1, "Type"),
    t(" "),
    i(2, "name"),
    t(";"),
  }),

  s("get", {
    t("get "),
    i(1, "name"),
    t(" => "),
    i(2, "value"),
    t(";"),
  }),

  s("set", {
    t("set "),
    i(1, "name"),
    t("(value) {"),
    i(2, "// TODO"),
    t({ "", "}" }),
  }),
}

require("luasnip").add_snippets("dart", dart_snippets)
require("luasnip").add_snippets("flutter", flutter_snippets)
