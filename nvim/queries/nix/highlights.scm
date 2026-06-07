;; extends

(variable_expression
  name: (identifier) @boolean.true
  (#eq? @boolean.true "true"))

(variable_expression
  name: (identifier) @boolean.false
  (#eq? @boolean.false "false"))

(variable_expression
  name: (identifier) @boolean.false
  (#eq? @boolean.false "null"))

((integer_expression) @number.zero (#eq? @number.zero "0"))

((string_expression) @boolean.false (#eq? @boolean.false "\"\""))

(let_expression
  (binding_set
    (binding
      .
      (attrpath) @variable.local)))
