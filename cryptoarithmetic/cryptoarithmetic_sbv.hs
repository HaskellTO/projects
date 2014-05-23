module Main where


import Data.List
import Data.Maybe
import Data.SBV
import Control.Monad


toNum :: Num a => [ a ] => a
toNum = foldl ( \ a b -> a * 10 + b ) 0

solve' :: [ String ] -> String -> IO SatResult
solve' left right = sat $ do
  let varsUnique = map (:[]) $ nub $ concat left ++ right
  varsUnique' <- sIntegers varsUnique
  let varsLookupTable = zip varsUnique varsUnique'
      vl v = fromJust $ lookup v varsLookupTable
      left' = map ( map (:[]) ) left
      right' = map (:[]) right
      sumLeft = sum $ map ( toNum . map vl ) left'
      numRight = toNum $ map vl right'

  return $ bAnd [ -- assign all variables differently
                  allDifferent varsUnique'

                , -- sum of left side equal right side
                  sumLeft .== numRight

                , -- constrain range
                  bAnd $ map ( \ x -> x .>= 1 {- &&& x .<= 9 -} ) varsUnique'
                ]

test :: Modelable a => ( [ String ], String ) -> a -> Bool
test ( lefts, right ) solution =
  let replace c = getModelValue [ c ] solution
      replacedLeft  = map ( map replace ) lefts
      replacedRight = map replace right
      nothing = Nothing `elem` concat replacedLeft ++ replacedRight
      replacedLeft' = map ( map fromJust ) replacedLeft
      replacedRight' = map fromJust replacedRight
  in ( not nothing &&
       ( sum $ map toNum replacedLeft' :: Integer )
       == ( toNum replacedRight' :: Integer ) )

solveAndTest :: ( [ String ], String ) -> IO String
solveAndTest problem = do
  r <- uncurry solve' problem
  print $ "testing: " ++
    if test problem r then
      "pass"
    else
      "fail"
  return $ show r

problems :: [ ( [ String ], String ) ]
problems = [ ( ["IS", "IT"], "OK" )
           , ( ["IT", "IS", "NOT"], "OK" )
           , ( ["ALPHA", "BETA"], "CHARLIE" )
           , ( ["THE", "QUICK", "BROWN", "FOX", "JUMPS", "OVER", "THE", "LAZY"], "HIPPOPOTAMUS" )
           , ( [ "GRUMPY", "WIZARDS", "MAKE", "TOXIC", "BREW", "FOR", "THE", "EVIL", "QUEEN", "AND" ], "JACK" )
           ]

main :: IO ()
main =
  liftM unlines ( mapM solveAndTest problems ) >>= putStr
