# AXI Lite to APB Bridge Implementation Task

## Task Description
Implement an AXI4-Lite to APB4 protocol conversion bridge that supports multiple APB slave devices.

## Module Overview
This module converts AXI4-Lite transactions to APB4 protocol, supporting multiple APB slave devices with address mapping and selection. It handles the protocol conversion between the more complex AXI4-Lite and the simpler APB4 interface.

### Key Features
- Convert AXI4-Lite transactions to APB4 protocol
- Support multiple APB slave devices with address mapping
- Handle address decoding and slave selection
- Implement proper APB4 two-phase transfer protocol (setup + enable)

## Build and Test Commands
```bash
make clean
make compile_vcs.log
cd build
../scripts/run_vcs.sh axi_lite_to_apb
```

## Verification Requirements
Your implementation must pass the complete test suite in `tb_axi_lite_to_apb.sv`.

**Test Information**: 10000 write + 20000 read random transactions with multiple APB slaves

## Analysis Hints
Carefully analyze the testbench for:
- Study APB slave configuration (NoApbSlaves: 8)
- Understand address mapping rules (NoAddrRules: 9)
- Analyze APB protocol timing requirements (setup + enable phases)
- Observe pipeline configuration options

## Interface Requirements
- **Input**: Standard AXI4-Lite slave interface
- **Output**: Multiple APB4 master interfaces
- **Parameters**: NoApbSlaves, NoRules, AddrWidth, DataWidth, Pipeline options
- **Signals**: Clock, reset, address map inputs

---
**Module**: `axi_lite_to_apb.sv` | **Testbench**: `tb_axi_lite_to_apb.sv`
