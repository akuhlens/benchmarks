#!/bin/sh

function main()
{
    ROOT_DIR="$1";   shift
    dyn_config="$1"; shift

    declare -r LIB_DIR="${ROOT_DIR}/scripts/lib"
    declare -r LB_DIR="${ROOT_DIR}/lattice_bins"
    if [ -z ${BENCHMARK_DIR+x} ]; then
	# if the variable is not set, pick the most recent experiment directory
	BENCHMARK_DIR=$(basename $(ls -td -- "${LB_DIR}/*/" | head -n 1))
	echo "The directory: \"${BENCHMARK_DIR}\" is selected for plotting"
    fi
    declare -r EXP_DIR="${LB_DIR}/${BENCHMARK_DIR}"
    declare -r DATA_DIR="${EXP_DIR}/data"
    declare -r OUT_DIR="${EXP_DIR}/output"
    declare -r TMP_DIR="${EXP_DIR}/tmp"

    . ${LIB_DIR}/runtime.sh
    . ${LIB_DIR}/benchmarks.sh
    . ${LIB_DIR}/plotting.sh

    local i j
    while (( "$#" )); do
        i=$1; shift
        j=$1; shift
        plot_two_configs $i $j $dyn_config
	plot_one_config $i $dyn_config
	plot_one_config $j $dyn_config
    done
}

main "$@"
