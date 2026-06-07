;; extends

(true) @boolean.true
(false) @boolean.false
(nil) @boolean.false

((number) @number.zero (#eq? @number.zero "0"))

((string) @boolean.false (#eq? @boolean.false "\"\""))
((string) @boolean.false (#eq? @boolean.false "''"))

(variable_declaration
  (assignment_statement
    (variable_list
      name: (identifier) @variable.local)))

((identifier) @variable.builtin
  (#eq? @variable.builtin "vim"))
