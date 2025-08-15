# AXI Lite Registers Implementation Task

## Task Description
Implement an AXI4-Lite register module that provides memory-mapped register access with configurable features and access controls.

## Module Overview
This module implements a configurable register file accessible via AXI4-Lite interface, supporting various register types, access controls, and optional read-only protection features.

### Key Features
- Memory-mapped register access via AXI4-Lite
- Configurable register types and access controls
- Optional read-only and protection features
- Proper AXI4-Lite protocol compliance

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_lite_regs
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_lite_regs.sv`.

**Test Information**: Register access tests with various configurations and access patterns

## Analysis Hints
Carefully analyze the testbench for:
- Study register configuration and mapping
- Understand access control mechanisms
- Analyze read-only and protection features
- Observe address decoding and register selection

## Interface Requirements
- **Input**: AXI4-Lite slave interface
- **Output**: Register interface signals
- **Parameters**: Register configuration parameters
- **Signals**: Clock, reset, register data ports

---
**Module**: `axi_lite_regs.sv` | **Testbench**: `tb_axi_lite_regs.sv`
