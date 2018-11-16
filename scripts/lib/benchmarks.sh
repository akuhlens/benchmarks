#!/bin/sh

declare -a BENCHMARKS=(sieve quicksort fft blackscholes matmult n_body tak ray array)

declare -a BENCHMARKS_ARGS_LATTICE=("fast.txt" "in_descend1000.txt" "medium1.txt" "in_4K.txt" "400.txt" "slow.txt" "slow.txt" "empty.txt" "slow.txt")

declare -a BENCHMARKS_ARGS_EXTREMES=("slow.txt" "in_descend10000.txt" "slow.txt" "in_16K.txt" "400.txt" "slow.txt" "slow.txt" "empty.txt" "slow.txt")
