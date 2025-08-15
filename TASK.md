# AXI Lite Mailbox Implementation Task

## Task Description
Implement an AXI4-Lite mailbox that enables bidirectional communication between two AXI4-Lite slave ports through internal FIFOs.

## Module Overview
This module implements a hardware mailbox where two AXI4-Lite slave ports are connected to each other over two FIFOs. Data written on port 0 is made available for reading on port 1 and vice versa, with configurable interrupt capabilities and error handling.

### Key Features
- Bidirectional FIFO-based communication between two ports
- Configurable interrupt system with threshold and error triggers
- Memory-mapped register interface for control and status
- Support for both level and edge-triggered interrupts

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_lite_mailbox
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_lite_mailbox.sv`.

**Test Information**: Mailbox communication tests with interrupt handling and error conditions

## Analysis Hints
Carefully analyze the testbench for:
- Study the detailed register specification in `doc/axi_lite_mailbox.md`
- Understand FIFO depth configuration and threshold mechanisms
- Analyze interrupt trigger conditions and acknowledgment procedures
- Observe error handling for full/empty FIFO conditions

## Interface Requirements
- **Input**: Two AXI4-Lite slave interfaces
- **Output**: Two interrupt lines (one per port)
- **Parameters**: MailboxDepth, IrqEdgeTrig, IrqActHigh, address/data widths
- **Signals**: Clock, reset, test mode, base addresses

**Note**: This module has comprehensive documentation available at `doc/axi_lite_mailbox.md` with detailed register specifications and usage examples.

---
**Module**: `axi_lite_mailbox.sv` | **Testbench**: `tb_axi_lite_mailbox.sv`
