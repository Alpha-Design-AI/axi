# AXI ATOP Filter Implementation Task

## Task Description
Implement an AXI atomic operations filter that identifies and filters ATOP transactions from the AXI stream.

## Module Overview
This module identifies AXI5 atomic operations (ATOP) transactions and filters them out, returning appropriate error responses for ATOP transactions while allowing normal transactions to pass through.

### Key Features
- Identify and filter AXI5 atomic operations (ATOP) transactions
- Return appropriate error responses for ATOP transactions  
- Allow normal transactions to pass through unchanged
- Maintain AXI protocol compliance

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_atop_filter
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_atop_filter.sv`.

**Test Information**: ATOP filtering functionality with various transaction types

## Analysis Hints
Carefully analyze the testbench for:
- Understand ATOP transaction identification (aw_atop field)
- Study error response generation mechanisms
- Analyze normal transaction pass-through behavior
- Observe protocol compliance requirements

## Interface Requirements
- **Input**: Standard AXI4+ATOP slave interface
- **Output**: Standard AXI4 master interface (ATOP-free)
- **Parameters**: Configuration parameters for filtering behavior
- **Signals**: Clock, reset

---
**Module**: `axi_atop_filter.sv` | **Testbench**: `tb_axi_atop_filter.sv`
