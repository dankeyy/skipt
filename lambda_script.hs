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


-- SKI combinators represented by our calc lambda
iCombinator :: Term
iCombinator = abstraction "x" id


kCombinator :: Term
kCombinator = abstraction "x" $ \x -> abstraction "y" $ \_ -> x


sCombinator :: Term
sCombinator = abstraction "x" $ \x ->
              abstraction "y" $ \y ->
              abstraction "z" $ \z ->
              application (application x z) (application y z)


-- util
prettyPrint :: Term -> String
prettyPrint (Var x) = x
prettyPrint (Abstraction x body) = "λ" ++ x ++ ".(" ++ prettyPrint body ++ ")"
prettyPrint (Application f x) = "(" ++ prettyPrint f ++ " " ++ prettyPrint x ++ ")"


main :: IO ()
main = do
  putStrLn "I Combinator:"
  print iCombinator
  putStrLn $ "Pretty: " ++ prettyPrint iCombinator

  putStrLn "\nK Combinator:"
  print kCombinator
  putStrLn $ "Pretty: " ++ prettyPrint kCombinator

  putStrLn "\nS Combinator:"
  print sCombinator
  putStrLn $ "Pretty: " ++ prettyPrint sCombinator

