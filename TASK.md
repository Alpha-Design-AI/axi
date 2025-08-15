# AXI to AXI Lite Converter Implementation Task

## Task Description
Implement an AXI4 to AXI4-Lite protocol downgrade converter that transforms AXI4 burst transactions into AXI4-Lite single-beat transactions.

## Module Overview
This module converts AXI4 transactions (which support burst transfers) into AXI4-Lite transactions (simplified single-beat transactions), handling burst splitting and response merging.

### Key Features
- Convert AXI4 burst transactions to AXI4-Lite single-beat transactions
- Split burst transfers into individual beats
- Merge responses appropriately
- Handle protocol downgrade signal mapping

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_to_axi_lite
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_to_axi_lite.sv`.

**Test Information**: Protocol conversion tests with burst splitting verification

## Analysis Hints
Carefully analyze the testbench for:
- Study AXI4 to AXI4-Lite signal mapping requirements
- Understand burst splitting mechanisms
- Analyze response merging and ordering requirements
- Observe transaction flow conversion

## Interface Requirements
- **Input**: Standard AXI4 slave interface
- **Output**: Standard AXI4-Lite master interface  
- **Parameters**: Address width, data width
- **Signals**: Clock, reset

---
**Module**: `axi_to_axi_lite.sv` | **Testbench**: `tb_axi_to_axi_lite.sv`
