module IslandCount where

import qualified Data.Set as S

type Terrain = S.Set (Integer, Integer)

countIslands :: Terrain -> Int
countIslands terrain = rec terrain 0
    where rec t ct = if S.null t then ct 
                     else rec (sinkOne t) $ succ ct

sinkOne :: Terrain -> Terrain
sinkOne terrain = rec (firstLand terrain) terrain
    where rec layer t = if S.null layer then t
                        else let nextLand = S.difference t layer
                                 nextLayer = findLand nextLand (allNeighbors layer)
                             in rec nextLayer nextLand

-- --------------
-- Parsing and IO
-- --------------
parseTerrain :: String -> Terrain
parseTerrain t = S.fromList . concatMap landY . zip [1..] . map landX $ lines t
    where landX ln = filter ((/='.') . snd) $ zip [1..] ln
          landY (y, ln) = map (flip (,) y . fst) ln

countFile fname = do tFile <- readFile fname
                     putStr . show . countIslands $ parseTerrain tFile
                     putStrLn $ " " ++ fname                            

main = mapM_ countFile ["zero.txt", "one.txt", "two.txt", "three.txt", "four.txt"]

-- -------------
-- Minor helpers
-- -------------
neighbors :: (Integer, Integer) -> [(Integer, Integer)] 
-- Currently gives the moore neighborhood
neighbors (x, y)= [(x + x', y + y') | x' <- [-1..1], y' <- [-1..1], (x', y') /= (0,0)]

allNeighbors :: S.Set (Integer, Integer) -> S.Set (Integer, Integer)
allNeighbors cells = S.fromList . concatMap neighbors $ S.toList cells

firstLand :: Terrain -> S.Set (Integer, Integer)
firstLand t = S.fromList . take 1 $ S.toList t

findLand :: Terrain -> S.Set (Integer, Integer) -> S.Set (Integer, Integer)
findLand t candidates = S.filter (flip S.member t) candidates
