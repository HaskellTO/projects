{-# LANGUAGE ExistentialQuantification #-}
{-
Riddle: You have to transport an integer, a character, and a boolean across the
river. There is only one boat for this. The boat can hold any number
of items, but they all have to be the same type. Fortunately, after getting the
integer, the character, and the boolean across the river, you only have to
put them on show. How many trips do you need?
-}

import Control.Monad

data S = forall a. (Show a, Enum a) => Stor a

the_int = Stor (5 :: Integer)
the_char = Stor 'x'
the_bool = Stor False

boat = [the_int, the_char, the_bool]

process_boat = map (\(Stor a) -> show (succ a)) boat 

{- Answer: One trip -}

the_boat_I_intend = [show 5, show 'x', show False]

data S' = forall a. Stor' a (a -> String) (a -> a)

boat' = [Stor' (5 :: Integer) show succ, Stor' 'x' show pred, Stor' False show not]
        ++ map f boat'
  where f (Stor' a s t) = Stor' (t a) s t

process_boat' = map (\(Stor' a s t) -> s (t a)) boat'

g :: IO S' -> IO String
g m = do
    Stor' a s _ <- m
    return (s a)

io :: S'
io = Stor' getChar (const "trapped in IO") f
  where
    f m = replicateM_ 10 m >> m

-- use_io :: IO Char
-- use_io = case io of Stor' m s t -> t m
