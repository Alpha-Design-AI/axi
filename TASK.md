# AXI Delayer Implementation Task

## Task Description
Implement an AXI channel delayer that adds configurable timing delays to AXI transactions while preserving protocol correctness.

## Module Overview
This module inserts configurable delays between AXI slave and master interfaces, supporting both fixed and random delay modes while maintaining transaction data integrity and proper handshake protocols.

### Key Features
- Support fixed delay and random delay modes
- Preserve transaction data integrity
- Maintain correct AXI handshake and back-pressure handling
- Handle all AXI channels with appropriate delay control

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_delayer
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_delayer.sv`.

**Test Information**: 200 consecutive transaction delay tests with data integrity verification

## Analysis Hints
Carefully analyze the testbench for:
- Observe delay parameter configurations in testbench
- Understand transaction data preservation requirements (0xcafebabe pattern)
- Analyze ID queuing mechanisms to ensure response ordering
- Study the relationship between input and output timing

## Interface Requirements
- **Input**: Standard AXI4 slave interface
- **Output**: Standard AXI4 master interface
- **Parameters**: StallRandomInput, StallRandomOutput, FixedDelayInput, FixedDelayOutput
- **Signals**: Clock, reset

---
**Module**: `axi_delayer.sv` | **Testbench**: `tb_axi_delayer.sv`
