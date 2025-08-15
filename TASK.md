# AXI Isolate Implementation Task

## Task Description
Implement an AXI bus isolator that supports dynamic isolation and graceful disconnection of AXI transactions.

## Module Overview
This module can dynamically isolate AXI bus connections by gracefully terminating all in-flight transactions and providing isolation control signals with proper status feedback.

### Key Features
- Track in-flight transaction counts
- Graceful termination: wait for all pending transactions to complete
- Block new transactions during isolation or return error responses
- Support ATOP transaction special handling

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_isolate
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_isolate.sv`.

**Test Information**: Isolation-recovery cycle tests with transaction count verification

## Analysis Hints
Carefully analyze the testbench for:
- Understand isolate_i and isolated_o signal timing relationships
- Analyze transaction counting and state management logic
- Study TerminateTransaction parameter effects
- Observe graceful termination behavior

## Interface Requirements
- **Input**: Standard AXI4 slave interface + isolate_i signal
- **Output**: Standard AXI4 master interface + isolated_o signal
- **Parameters**: NumPending, TerminateTransaction, AtopSupport
- **Signals**: Clock, reset, isolation control

---
**Module**: `axi_isolate.sv` | **Testbench**: `tb_axi_isolate.sv`
