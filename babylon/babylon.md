# Babylon

Babylon is a two player game. The game starts with 12 stones (3 green, 3 red, 3 white and 3 black) arranged on a tabletop. The players take turns placing an existing stack of stones on top of another valid stack. The winner is the last player that can make a legal move.

Two stacks can be combined if

1. They are the same height

 - or -

2. The top stone of each stack is the same color.

Here's a possible encoding (though others are certainly possible):

    data Color = Green | Red | White | Black deriving (Eq)
    type Stack = (Color, Int)
    type Board = [Stack]

    startingPosition :: Board
    startingPosition = [ (Green, 1), (Green, 1), (Green, 1)
                       , (Red, 1), (Red, 1), (Red, 1)
                       , (Black, 1), (Black, 1), (Black, 1)
                       , (White, 1), (White, 1), (White, 1)
                       ]

Solve the game.
