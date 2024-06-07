local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s(
        { trig = "~", dscr = "Single file component" },
        fmt(
            [[
<template>
{}
</template>

<script setup lang="ts">
{}
</script>

<style scoped>
{}
</style>]],
            { i(1), i(2), i(3) }
        ),
        { condition = line_begin }
    ),
}
