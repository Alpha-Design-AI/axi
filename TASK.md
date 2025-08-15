# AXI Serializer Implementation Task

## Task Description
Implement an AXI transaction serializer that converts multiple concurrent AXI transactions with different IDs into a single-ID sequential transaction stream.

## Module Overview
This module receives concurrent AXI transactions with different IDs and serializes them into sequential transactions with ID=0, while maintaining transaction integrity and AXI protocol compliance.

### Key Features
- Support configurable pending transaction limits
- Handle AXI4+ATOP protocol
- Maintain correct transaction data and response mapping
- Preserve transaction ordering and integrity

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_serializer
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_serializer.sv`.

**Test Information**: 3000 read transactions + 5000 write transactions with random patterns

## Analysis Hints
Carefully analyze the testbench for:
- Study MaxReadTxns/MaxWriteTxns parameters in the testbench
- Understand ATOP transaction special handling requirements  
- Analyze ID reconstruction mechanisms
- Observe transaction queuing and serialization behavior

## Interface Requirements
- **Input**: Standard AXI4 slave interface
- **Output**: Standard AXI4 master interface
- **Parameters**: MaxReadTxns, MaxWriteTxns, AxiIdWidth
- **Signals**: Clock, reset, and AXI protocol signals

---
**Module**: `axi_serializer.sv` | **Testbench**: `tb_axi_serializer.sv`
