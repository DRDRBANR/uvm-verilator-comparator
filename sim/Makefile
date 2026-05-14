RTL_DIR   = ../rtl
TB_DIR    = ../tb
TESTS_DIR = ../tests

TOP_MODULE = tb_top

# UVM
UVM_ROOT  = ../uvm
UVM_FLAGS = +incdir+$(UVM_ROOT)/src $(UVM_ROOT)/src/uvm_pkg.sv

VERILATOR_FLAGS = --binary -sv --trace --coverage -Wno-fatal -Wno-lint -Wno-style -Wno-SYMRSVDWORD -Wno-IGNOREDRETURN -Wno-DECLFILENAME --timing +define+UVM_NO_DPI +incdir+$(TB_DIR)

SRC  =	$(UVM_FLAGS) \
	$(RTL_DIR)/data_comparator.sv \
	$(TB_DIR)/$(TOP_MODULE).sv

.PHONY: all build run_test run_regression clean

all: build

build:
	@echo ">>> Starting Verilator build..."
	verilator $(VERILATOR_FLAGS) --top-module $(TOP_MODULE) $(SRC)

run_test:
	@echo ">>> Running test: $(TEST)"
	./obj_dir/V$(TOP_MODULE) +UVM_TESTNAME=$(TEST)

run_regression:
	@echo ">>> Starting test regression..."
	bash run_regression.sh

clean:
	@echo ">>> Cleaning up..."
	rm -rf obj_dir/ coverage.dat dump.vcd *.log

coverage:
	@echo ">>> Generating HTML coverage report..."
	verilator_coverage --write-info coverage.info coverage.dat
	lcov --remove coverage.info '*/uvm/*' '*/usr/*' -o coverage_clean.info
	genhtml coverage_clean.info --output-directory coverage_html
