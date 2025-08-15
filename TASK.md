# AXI FIFO Implementation Task

## Task Description
Implement an AXI FIFO buffer that provides independent buffering for each AXI channel.

## Module Overview
This module provides FIFO buffering for all 5 AXI channels (AW/W/B/AR/R) independently, supporting configurable depth and fall-through mode while maintaining proper flow control.

### Key Features
- Independent FIFO for each AXI channel (AW, W, B, AR, R)
- Configurable FIFO depth and fall-through mode
- Proper flow control and back-pressure handling
- Maintain AXI protocol handshake correctness

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_fifo
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_fifo.sv`.

**Test Information**: FIFO buffering functionality with various depth configurations

## Analysis Hints
Carefully analyze the testbench for:
- Study FIFO depth parameter configurations
- Understand fall-through mode behavior
- Analyze flow control mechanisms for each channel
- Observe handshake preservation requirements

## Interface Requirements
- **Input**: Standard AXI4 slave interface
- **Output**: Standard AXI4 master interface
- **Parameters**: Depth, FallThrough
- **Signals**: Clock, reset, test mode

**Module**: `axi_fifo.sv` | **Testbench**: `tb_axi_fifo.sv`
