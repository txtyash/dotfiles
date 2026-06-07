;; extends

((number_literal) @number.zero (#eq? @number.zero "0"))

((string_literal) @boolean.false (#eq? @boolean.false "\"\""))

((identifier) @boolean.false
  (#eq? @boolean.false "NULL"))

((identifier) @boolean.true
  (#eq? @boolean.true "true"))

((identifier) @boolean.false
  (#eq? @boolean.false "false"))

(function_definition
  body: (compound_statement
    (declaration
      declarator: (init_declarator
        declarator: (identifier) @variable.local))))

(function_definition
  body: (compound_statement
    (declaration
      declarator: (identifier) @variable.local)))
