{-# LANGUAGE BangPatterns #-}

import Criterion.Main
import Trace.Hpc.Mix (mixCreate, mixCreate', readMix, readMix')

dir = "./bench"

readShow modName = do
   !mix <- readMix [dir] $ Left modName
   mixCreate dir modName mix

serialise modName = do
   !mix <- readMix' [dir] $ Left modName
   mixCreate' dir modName mix

-- Our benchmark harness.
main = defaultMain [
  bgroup "format"
   [ bench "serialise" . nfIO $ serialise "Foundation1"
   , bench "read/show" . nfIO $ readShow "Foundation"
   ]
  ]
