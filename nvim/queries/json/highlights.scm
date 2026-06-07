;; extends

(true) @boolean.true
(false) @boolean.false
(null) @boolean.false

((number) @number.zero (#eq? @number.zero "0"))

((string) @boolean.false (#eq? @boolean.false "\"\""))
