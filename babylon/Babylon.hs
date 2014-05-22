module Babylon where

import Data.List
import Control.Monad

data Color = Green | Red | White | Black deriving (Eq, Ord, Show, Read)
type Stack = (Color, Int)
type Board = [Stack]

startingPosition :: Board
startingPosition = [ (Green, 1), (Green, 1), (Green, 1)
                   , (Red, 1), (Red, 1), (Red, 1)
                   , (Black, 1), (Black, 1), (Black, 1)
                   , (White, 1), (White, 1), (White, 1)
                   ]

reduced :: Board
reduced = nub startingPosition

merge :: Stack -> Stack -> Stack
merge (color, h) (_, h') = (color, h + h')

viewOne :: Board -> [(Stack, Board)]
viewOne board = [(s,b') | s <- b, let b' = board \\ [s]]
    where
      b = map head . group . sort $ board

nexts :: Board -> [Board]
nexts b0 = do
  (s1@(c1, h1), b1) <- viewOne b0
  (s2@(c2, h2), b2) <- viewOne b1
  guard (c1 == c2 || h1 == h2)
  return (merge s1 s2 : b2)

playTilEnd b0 = do
    b1 <- nexts b0
    path <- playTilEnd b1
    return (b0 : path)
  `orelse`
    return [b0]

orelse [] t = t
orelse s _ = s

main = putStrLn "Test"
