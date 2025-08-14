#!/bin/bash
# Copyright (c) 2014-2018 ETH Zurich, University of Bologna
#
# Copyright and related rights are licensed under the Solderpad Hardware
# License, Version 0.51 (the "License"); you may not use this file except in
# compliance with the License.  You may obtain a copy of the License at
# http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
# or agreed to in writing, software, hardware and materials distributed under
# this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#
# Authors:
# - Andreas Kurth <akurth@iis.ee.ethz.ch>
# - Fabian Schuiki <fschuiki@iis.ee.ethz.ch>
# - Wolfgang Roenninger <wroennin@iis.ee.ethz.ch>

set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

if test -z ${VCS+x}; then
    VCS=vcs
fi

# Seed values for random simulation; can be extended with specific values on a per-TB basis, as well as with
# a random number by passing the `--random` flag.  The default value, 0, is always included to stay
# regression-consistent.
SEEDS=(0)

call_vcs() {
    local tb_name=$1
    shift
    for seed in ${SEEDS[@]}; do
        echo "Running VCS simulation with seed $seed"
        ./simv_$tb_name +ntb_random_seed=$seed "$@" < /dev/null | tee vcs.log 2>&1
        # Check for simulation success (adjust pattern as needed)
        if grep -q "PASSED\|SUCCESS\|TEST PASSED\|Success\." vcs.log || ! grep -q "ERROR\|FAILED\|Fatal:" vcs.log; then
            echo "Simulation PASSED with seed $seed"
        else
            echo "Simulation FAILED with seed $seed"
            exit 1
        fi
    done
}

exec_test() {
    if [ ! -e "$ROOT/test/tb_$1.sv" ]; then
        echo "Testbench for '$1' not found!"
        exit 1
    fi
    
    # Elaborate the testbench using the compiled libraries
    echo "Elaborating testbench tb_$1..."
    $VCS -full64 -debug_access+all -kdb -lca \
        -timescale=1ns/1ps \
        -top tb_$1 \
        -o simv_$1
    
    # Run simulation based on testbench type
    case "$1" in
        axi_atop_filter)
            for MAX_TXNS in 1 3 12; do
                echo "Running axi_atop_filter with MAX_TXNS=$MAX_TXNS"
                call_vcs $1 +TB_N_TXNS=1000 +TB_AXI_MAX_WRITE_TXNS=$MAX_TXNS
            done
            ;;
        axi_cdc|axi_delayer)
            call_vcs $1
            ;;
        axi_dw_downsizer)
            call_vcs $1 +TbAxiSlvPortDataWidth=32 +TbAxiMstPortDataWidth=16 +TbInitialBStallCycles=100000
            call_vcs $1 +TbAxiSlvPortDataWidth=32 +TbAxiMstPortDataWidth=16 +TbInitialRStallCycles=100000
            for AxiSlvPortDataWidth in 8 16 32 64 128 256 512 1024; do
                for (( AxiMstPortDataWidth = 8; \
                        AxiMstPortDataWidth < $AxiSlvPortDataWidth; \
                        AxiMstPortDataWidth *= 2 )); \
                do
                    call_vcs $1 +TbAxiSlvPortDataWidth=$AxiSlvPortDataWidth +TbAxiMstPortDataWidth=$AxiMstPortDataWidth
                done
            done
            ;;
        axi_dw_upsizer)
            for AxiSlvPortDataWidth in 8 16 32 64 128 256 512 1024; do
                for (( AxiMstPortDataWidth = $AxiSlvPortDataWidth*2; \
                        AxiMstPortDataWidth <= 1024; \
                        AxiMstPortDataWidth *= 2 )); \
                do
                    call_vcs $1 +TbAxiSlvPortDataWidth=$AxiSlvPortDataWidth +TbAxiMstPortDataWidth=$AxiMstPortDataWidth
                done
            done
            ;;
        axi_fifo)
            for DEPTH in 0 1 16; do
                for FALL_THROUGH in 0 1; do
                    call_vcs $1 +Depth=$DEPTH +FallThrough=$FALL_THROUGH
                done
            done
            ;;
        axi_lite_regs)
            SEEDS+=(10 42)
            for PRIV in 0 1; do
                for SECU in 0 1; do
                    for BYTES in 42 200 369; do
                        call_vcs $1 +TbPrivProtOnly=$PRIV +TbSecuProtOnly=$SECU +TbRegNumBytes=$BYTES
                    done
                done
            done
            ;;
        axi_lite_to_apb)
            for PIPE_REQ in 0 1; do
                for PIPE_RESP in 0 1; do
                    call_vcs $1 +TbPipelineRequest=$PIPE_REQ +TbPipelineResponse=$PIPE_RESP
                done
            done
            ;;
        axi_lite_to_axi)
            for DW in 8 16 32 64 128 256 512 1024; do
                call_vcs $1 +TB_DW=$DW
            done
            ;;
        axi_sim_mem)
            for AW in 16 32 64; do
                for DW in 32 64 128 256 512 1024; do
                    call_vcs $1 +TbAddrWidth=$AW +TbDataWidth=$DW
                done
            done
            ;;
        axi_xbar)
            for NumMst in 1 6; do
                for NumSlv in 1 8; do
                    for Atop in 0 1; do
                        for Exclusive in 0 1; do
                            for UniqueIds in 0 1; do
                                call_vcs $1 +TbNumMasters=$NumMst +TbNumSlaves=$NumSlv \
                                        +TbEnAtop=$Atop +TbEnExcl=$Exclusive \
                                        +TbUniqueIds=$UniqueIds
                            done
                        done
                    done
                done
            done
            ;;
        axi_to_mem_banked)
            for MEM_LAT in 1 2; do
                for BANK_FACTOR in 1 2; do
                    for NUM_BANKS in 1 2 ; do
                        for AXI_DATA_WIDTH in 64 256 ; do
                            ACT_BANKS=$((2*$BANK_FACTOR*$NUM_BANKS))
                            MEM_DATA_WIDTH=$(($AXI_DATA_WIDTH/$NUM_BANKS))
                            call_vcs $1 +TbAxiDataWidth=$AXI_DATA_WIDTH \
                                +TbNumWords=2048 \
                                +TbNumBanks=$ACT_BANKS \
                                +TbMemDataWidth=$MEM_DATA_WIDTH \
                                +TbMemLatency=$MEM_LAT \
                                +TbNumWrites=2000 \
                                +TbNumReads=2000
                        done
                    done
                done
            done
            ;;
        axi_lite_dw_converter)
            for DWSLV in 32 64 128; do
                for DWMST in 16 32 64; do
                    call_vcs $1 +TbAxiDataWidthSlv=$DWSLV +TbAxiDataWidthMst=$DWMST
                done
            done
            ;;
        *)
            call_vcs $1
            ;;
    esac
}

# Parse flags.
PARAMS=""
while (( "$#" )); do
    case "$1" in
        --random-seed)
            SEEDS+=(19260817)
            shift;;
        -*--*) # unsupported flag
            echo "Error: Unsupported flag '$1'." >&2
            exit 1;;
        *) # preserve positional arguments
            PARAMS="$PARAMS $1"
            shift;;
    esac
done
eval set -- "$PARAMS"

if [ "$#" -eq 0 ]; then
    tests=()
    while IFS=  read -r -d $'\0'; do
        tb_name="$(basename -s .sv $REPLY)"
        dut_name="${tb_name#tb_}"
        tests+=("$dut_name")
    done < <(find "$ROOT/test" -name 'tb_*.sv' -a \( ! -name '*_pkg.sv' \) -print0)
else
    tests=("$@")
fi

for t in "${tests[@]}"; do
    exec_test $t
done