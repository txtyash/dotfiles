;; extends

(true) @boolean.true
(false) @boolean.false
(null) @boolean.false
(undefined) @boolean.false

((string) @boolean.false (#eq? @boolean.false "\"\""))
((string) @boolean.false (#eq? @boolean.false "''"))
((template_string) @boolean.false (#eq? @boolean.false "``"))

((number) @number.zero (#eq? @number.zero "0"))

(variable_declarator
  name: (identifier) @variable.local)
