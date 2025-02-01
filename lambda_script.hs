class LambdaCalculus o where
  -- String just to distinguish names in pretty printing
  identity :: String -> o
  abstraction :: String -> (o -> o) -> o
  application :: o -> o -> o


data Term
  = Var String
  | Abstraction String Term
  | Application Term Term
  deriving Show


instance LambdaCalculus Term where
  identity name = Var name
  abstraction name f = Abstraction name (f (identity name))
  application f x = Application f x


-- SKI combinators
iCombinator :: Term
iCombinator = abstraction "x" id


kCombinator :: Term
kCombinator = abstraction "x" $ \x -> abstraction "y" $ \_ -> x


sCombinator :: Term
sCombinator = abstraction "x" $ \x ->
              abstraction "y" $ \y ->
              abstraction "z" $ \z ->
              application (application x z) (application y z)


-- js
termToJString :: Term -> String
termToJString (Var name) = name

termToJString (Abstraction name body) =
  let
    jsBody = termToJString body
  in
    "(" ++ name ++ ") => { return " ++ jsBody ++ "; }"

termToJString (Application f x) =
  let
    fBody = termToJString f
    xBody = termToJString x
  in
    "(" ++ fBody ++ ")(" ++ xBody ++ ")"


-- util
prettify :: Term -> String
prettify (Var x) = x
prettify (Abstraction x body) = "λ" ++ x ++ ".(" ++ prettify body ++ ")"
prettify (Application f x) = "(" ++ prettify f ++ " " ++ prettify x ++ ")"


main :: IO ()
main = do
  putStrLn "I Combinator:"
  print iCombinator
  putStrLn $ "prettified code: " ++ prettify iCombinator
  putStrLn $ "JS code: const iComb = " ++ termToJString iCombinator

  putStrLn "\nK Combinator:"
  print kCombinator
  putStrLn $ "prettified code: " ++ prettify kCombinator
  putStrLn $ "JS code: const kComb = " ++ termToJString  kCombinator

  putStrLn "\nS Combinator:"
  print sCombinator
  putStrLn $ "prettified code: " ++ prettify sCombinator
  putStrLn $ "JS code: const sComb = " ++ termToJString sCombinator

  return ()
