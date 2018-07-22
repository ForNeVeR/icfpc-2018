module Main where

import System.Environment

import Trace
import Model
import Generator
import Algorithms
import TraceGens
import Sim
import Evaluator
import Data.Array.BitArray
import Data.Binary

gentrace:: (BitArray P3 -> [Command]) -> FilePath -> FilePath -> IO()
gentrace f infile outfile = do
    modelFile <- decodeFile infile
    let trace = f $ mfMatrix modelFile
    writeTrace outfile trace

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["display", file] -> displayModelFile file
    ["construct", infile, outfile] -> dumbHighSolver infile outfile
    ["deconstruct", infile, outfile] -> dumbDestructor infile outfile
    ["reconstruct", src, dst, outfile] -> dumbReconstructor src dst outfile
    ["eval", model, trace] -> doEvalTrace model trace
    _ -> fail "unknown command"
