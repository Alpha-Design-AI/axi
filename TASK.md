# AXI ID Width Converter Implementation Task

## Task Description
Implement an AXI ID width converter that enables communication between AXI interfaces with different ID widths.

## Module Overview
This module converts between AXI interfaces with different ID widths, managing ID mapping tables and handling transaction routing based on ID relationships.

### Key Features
- Convert between different AXI ID widths (narrow ↔ wide)
- Manage ID mapping and translation tables
- Handle transaction concurrency and ordering
- Support bidirectional ID width conversion

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_iw_converter
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_iw_converter.sv`.

**Test Information**: ID width conversion tests with mapping table verification

## Analysis Hints
Carefully analyze the testbench for:
- Study ID width conversion configurations
- Understand ID mapping table mechanisms
- Analyze transaction concurrency handling
- Observe ID assignment and recovery logic

## Interface Requirements
- **Input**: AXI4 slave interface (configurable ID width)
- **Output**: AXI4 master interface (configurable ID width)
- **Parameters**: AxiSlvPortIdWidth, AxiMstPortIdWidth, AxiAddrWidth
- **Signals**: Clock, reset

---
**Module**: `axi_iw_converter.sv` | **Testbench**: `tb_axi_iw_converter.sv`
