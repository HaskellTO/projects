# Cryptoarithmetic

In cryptoarithmetic problems, we are given a problem wherein the digits are replaced with characters representing digits. A solution to such a problem is a set of character-to-digit bindings that, when sustituted into the problem gives a true numerical interpretation.

For example, `["IS", "IT"] "OK"` has the solution `[('I', 1), ('K', 1), ('O', 3), ('S', 5), ('T', 6)]`.

Write the function

    solve :: [String] -> String -> [Set (Char, Integer)]

to solve problems assuming the addition relationship between `[String]` and `String`.

### Sample inputs

    ["IS", "IT"] "OK"
    ["IT", "IS", "NOT"] "OK"
    ["ALPHA", "BETA"] "CHARLIE"
    ["THE", "QUICK", "BROWN", "FOX", "JUMPS", "OVER", "THE", "LAZY"] "HIPPOPOTAMUS"

### Bonus points

- Disallow leading zeros
- Make sure each binding is unique. Under this restriction the example solution for `["IS", "IT"] "OK"` is invalid because both `'I'` and `'K'` represent `1`
- Provide solution sets for all basic arithmetic operations (addition, subtraction, multiplication and division) rather than just addition
