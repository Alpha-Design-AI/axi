# AXI Simulation Memory Implementation Task

## Task Description
Implement an AXI simulation memory module that provides memory behavior for testbench environments with configurable memory characteristics.

## Module Overview
This module implements a simulation-only memory that responds to AXI transactions with configurable memory behavior, supporting various memory access patterns and timing characteristics for verification purposes.

### Key Features
- Configurable memory size and address range
- Support for read/write memory operations
- Configurable access latency and timing
- Error injection capabilities for testing

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_sim_mem
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_sim_mem.sv`.

**Test Information**: Memory functionality tests with various access patterns and timing scenarios

## Analysis Hints
Carefully analyze the testbench for:
- Study memory configuration parameters
- Understand memory initialization and data patterns
- Analyze access timing and latency requirements
- Observe error handling and edge case behavior

## Interface Requirements
- **Input**: Standard AXI4 slave interface
- **Output**: Memory response behavior
- **Parameters**: Memory size, address range, timing configuration
- **Signals**: Clock, reset, memory control ports

---
**Module**: `axi_sim_mem.sv` | **Testbench**: `tb_axi_sim_mem.sv`
