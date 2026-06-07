;; extends

((boolean) @boolean.true (#eq? @boolean.true "true"))
((boolean) @boolean.false (#eq? @boolean.false "false"))

"null" @boolean.false
"undefined" @boolean.false

((integer) @number.zero (#eq? @number.zero "0"))

((string_literal) @boolean.false (#eq? @boolean.false "\"\""))
