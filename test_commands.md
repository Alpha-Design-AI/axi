# AXI Test Commands

This document lists all available testbenches and the commands to run them.

## Available Testbenches

The following testbenches are available in the `test/` directory:

- `axi_addr_test` - AXI address testing
- `axi_atop_filter` - AXI atomic operation filter
- `axi_bus_compare` - AXI bus comparison
- `axi_cdc` - AXI clock domain crossing
- `axi_delayer` - AXI transaction delayer
- `axi_dw_downsizer` - AXI data width downsizer
- `axi_dw_upsizer` - AXI data width upsizer
- `axi_fifo` - AXI FIFO
- `axi_isolate` - AXI isolation
- `axi_iw_converter` - AXI ID width converter
- `axi_lite_dw_converter` - AXI-Lite data width converter
- `axi_lite_mailbox` - AXI-Lite mailbox
- `axi_lite_regs` - AXI-Lite registers
- `axi_lite_to_apb` - AXI-Lite to APB bridge
- `axi_lite_to_axi` - AXI-Lite to AXI converter
- `axi_lite_xbar` - AXI-Lite crossbar
- `axi_modify_address` - AXI address modifier
- `axi_serializer` - AXI serializer
- `axi_sim_mem` - AXI simulation memory
- `axi_slave_compare` - AXI slave comparison
- `axi_to_axi_lite` - AXI to AXI-Lite converter
- `axi_to_mem_banked` - AXI to banked memory
- `axi_xbar` - AXI crossbar

## Running Tests

### Prerequisites

#### For Questasim/ModelSim
1. Compile the design first:
   ```bash
   make compile.log
   ```

#### For VCS
1. Compile the design first:
   ```bash
   make compile_vcs.log
   ```

### Individual Test Commands

#### Questasim/ModelSim
Run a specific testbench:
```bash
make sim-<testbench_name>.log
```

Examples:
```bash
make sim-axi_fifo.log
make sim-axi_xbar.log
make sim-axi_lite_to_axi.log
```

#### VCS
Run a specific testbench:
```bash
make sim-<testbench_name>.vcs.log
```

Examples:
```bash
make sim-axi_fifo.vcs.log
make sim-axi_xbar.vcs.log
make sim-axi_lite_to_axi.vcs.log
```

### Run All Tests

#### Questasim/ModelSim
```bash
make sim_all
```

#### VCS
```bash
make sim_all_vcs
```

### Run with Random Seed

#### Questasim/ModelSim
The test runner supports random seeds for enhanced coverage:
```bash
export VSIM="vsim"; cd build && ../scripts/run_vsim.sh --random-seed <testbench_name>
```

#### VCS
```bash
export VCS="vcs"; cd build && ../scripts/run_vcs.sh --random-seed <testbench_name>
```

### Verilator Synthesis Check
Run synthesis check with Verilator:
```bash
./scripts/run_verilator.sh
```

## Test-Specific Parameters

Some tests run with specific parameters automatically:

### axi_atop_filter
- Tests with different maximum transaction counts (1, 3, 12)

### axi_dw_downsizer/axi_dw_upsizer
- Tests various data width combinations (8, 16, 32, 64, 128, 256, 512, 1024 bits)

### axi_fifo
- Tests different depths (0, 1, 16) and fall-through modes

### axi_iw_converter
- Tests various ID width configurations and exclusive access modes

### axi_lite_regs
- Tests different privilege/security modes and register sizes

### axi_xbar
- Tests different master/slave counts and feature combinations

## Build Targets

- `make help` - Show available targets
- `make all` - Compile, elaborate, and run all tests (Questasim)
- `make compile.log` - Compile using Questasim
- `make compile_vcs.log` - Compile using VCS
- `make elab.log` - Elaborate using Synopsys DC
- `make sim_all` - Run all tests using Questasim
- `make sim_all_vcs` - Run all tests using VCS
- `make clean` - Clean generated files

## Tool Requirements

- **Questasim/ModelSim**: For simulation (vsim)
- **VCS**: For simulation (vcs, vlogan, vhdlan)
- **Synopsys DC**: For elaboration (dc_shell)
- **Verilator**: For synthesis checking (optional)
- **Bender**: For dependency management

## VCS-Specific Features

The VCS scripts include:
- Full 64-bit compilation support
- Debug access and KDB generation
- UVM 1.2 support
- Coverage collection capabilities
- Comprehensive error checking