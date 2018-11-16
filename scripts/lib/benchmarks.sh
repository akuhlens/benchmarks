#!/bin/sh

declare -a BENCHMARKS=(sieve fft blackscholes n_body quicksort  matmult tak ray array)

declare -a BENCHMARKS_ARGS_LATTICE=("fast.txt" "medium1.txt" "in_4K.txt" "slow.txt" "in_descend1000.txt" "400.txt" "slow.txt" "empty.txt" "slow.txt")

declare -a BENCHMARKS_ARGS_EXTREMES=("slow.txt" "slow.txt" "in_16K.txt" "slow.txt" "in_descend10000.txt" "400.txt" "slow.txt" "empty.txt" "slow.txt")
