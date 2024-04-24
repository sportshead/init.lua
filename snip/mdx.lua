local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s(
        { trig = "PicoChallenge", dscr = "picoCTF Challenge Component" },
        fmt(
            [[
<Pico author="-+" points={-+} flag="-+">
  <Fragment slot="title">
    ## -+
  </Fragment>
  <Fragment slot="hints">
    1. -+
  </Fragment>
  <Fragment slot="tags">
    -+
  </Fragment>
  -+
</Pico>]],
            { i(1), i(2), i(3), i(4), i(5), i(7), i(6) }, -- tags last so we can use codeium
            { delimiters = "-+" } -- goofy delimiters because "" <> and {} are all used in snip
        ),
        { condition = line_begin }
    ),
}
