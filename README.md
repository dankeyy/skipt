# skipt
ski combinators compiled to JS in lambda calc terms

output:
```js
I Combinator:
Abstraction "x" (Var "x")
prettified code: λx.(x)
JS code: const iComb = (x) => { return x; }

K Combinator:
Abstraction "x" (Abstraction "y" (Var "x"))
prettified code: λx.(λy.(x))
JS code: const kComb = (x) => { return (y) => { return x; }; }

S Combinator:
Abstraction "x" (Abstraction "y" (Abstraction "z" (Application (Application (Var "x") (Var "z")) (Application (Var "y") (Var "z")))))
prettified code: λx.(λy.(λz.(((x z) (y z)))))
JS code: const sComb = (x) => { return (y) => { return (z) => { return ((x)(z))((y)(z)); }; }; }
```

see test.js for some examples
