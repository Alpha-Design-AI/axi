# AXI Lite to AXI Converter Implementation Task

## Task Description
Implement an AXI4-Lite to AXI4 protocol upgrade converter that transforms simplified AXI-Lite transactions into full AXI4 format.

## Module Overview
This module converts AXI4-Lite transactions (simplified single-beat transactions) into AXI4 transactions (which support burst transfers), handling the protocol differences and signal mapping.

### Key Features
- Convert AXI4-Lite single-beat transactions to AXI4 format
- Handle protocol upgrade signal mapping
- Maintain transaction data integrity
- Support proper burst length and size settings

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_lite_to_axi
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_lite_to_axi.sv`.

**Test Information**: Protocol conversion tests with various transaction patterns

## Analysis Hints
Carefully analyze the testbench for:
- Study AXI4-Lite to AXI4 signal mapping requirements
- Understand burst length and size handling (should be single-beat)
- Analyze transaction flow and handshake conversion
- Observe any additional AXI4 signal requirements

## Interface Requirements
- **Input**: Standard AXI4-Lite slave interface
- **Output**: Standard AXI4 master interface
- **Parameters**: Address width, data width, ID width
- **Signals**: Clock, reset

---
**Module**: `axi_lite_to_axi.sv` | **Testbench**: `tb_axi_lite_to_axi.sv`
