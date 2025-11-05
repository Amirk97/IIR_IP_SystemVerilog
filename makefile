.ONESHELL:

C_FILES := $(shell python3 yaml_parser.py files.yaml "c")

# Default project (override with 'make proj=design2')
proj_name = 

# Vivado executable
VIVADO = vivado

# Target TCL script path
MAKE_PROJECT_TCL = ./scripts/make_project.tcl

TOOL =

UVM_SRC_PATH = $(shell python3 yaml_parser.py files.yaml uvm_src_path)

CONTAINER_NAME ?= xc_env_cnt1

GUI ?= 0

ifeq ($(GUI),1)
GUI_FLAG = -gui
EXTRA_ARGS += --trace --trace-fst --trace-structs
else
GUI_FLAG =
endif

EXTRA_ARGS += $(shell python3 ./Python_tb/cfg_pkg.py)
PYTHONPATH = $(shell pwd)/Python_tb/
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(shell pwd)/EQU_vivado_project/EQU_vivado_project.srcs/sources_1/new/*.sv
TOPLEVEL = IIR
COCOTB_TEST_MODULES = top_tb_IIR
SIM = verilator
COCO_TRGT ?= all
export TOPLEVEL_LANG VERILOG_SOURCES TOPLEVEL COCOTB_TEST_MODULES SIM EXTRA_ARGS GUI PYTHONPATH VERILATOR_COMPILE_ARGS

TESTCASE ?= test_const_coeff

compile_c: $(C_FILES)
	echo $(C_FILES)
	gcc -shared -fPIC $(C_FILES) -o ./Python_tb/libmylib.so &&
	@touch $@
#	FILE_TYPE=c; \
#	FILES=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \

cocotb: compile_c
	. /home/amir/venvs/pyuvm/bin/activate && \
	$(MAKE) -f $(shell cocotb-config --makefiles)/Makefile.sim $(COCO_TRGT); \
	deactivate

gtkwave:
	$(MAKE) cocotb GUI=1
	gtkwave dump.fst 

project:
	@echo "Building project: $(proj)"
	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL)

regression_sv_uvm:
	FILE_TYPE=tests; \
	TESTS=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$TESTS; \
	docker start $(CONTAINER_NAME); \
	TESTLOG=""; \
	for t in $$TESTS;do \
		$(MAKE) exec_docker TESTCASE=$$t; \
		TESTLOG="$${TESTLOG} test-results/$${t}.log" ; \
	done; \
	docker cp $(CONTAINER_NAME):/proj/test-results/. ./test-results/; \
	python3 log_parser.py $$TESTLOG; \
	docker stop $(CONTAINER_NAME)

regression_all:
	$(MAKE) regression_sv_uvm
	$(MAKE) cocotb GUI=1

create_container:
	docker run --name $(CONTAINER_NAME) \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /media/amir/1C8F205019F09CF8/Users/amir9/Documents/EQU/:/proj \
	-v /tools/Cadence:/mnt/Cadence \
	-d xc-env \
	tail -f /dev/null

exec_docker:
	docker exec  $(CONTAINER_NAME) bash -c "export DISPLAY=:0 && cd /proj && source /tools/Cadence/installs/XCELIUM2403/setup_xcelium.sh && make compile_xcelium_tb GUI=$(GUI) TESTCASE=$(TESTCASE)"

run_container:
	docker start $(CONTAINER_NAME)
	$(MAKE) exec_docker
	docker stop $(CONTAINER_NAME)
#	docker logs -f xc_env_cnt

compile_xcelium_tb:
	FILE_TYPE=tb; \
	FILES=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$FILES; \
	echo $$UVM_SRC_PATH; \
	echo $(GUI_FLAG); \
	echo $(GUI); \
	echo $(TESTCASE); \
	xrun -access +rwc -elaborate -snapshot my_design -uvm $$FILES -64bit -CFLAGS "-I./C_code_source_FPGA" +assertdebug; \
	xrun -64bit -R  $(GUI_FLAG) -snapshot my_design +UVM_TESTNAME=$(TESTCASE) -UVMLINEDEBUG -linedebug -access +rwc -uvm -logfile test-results/$(TESTCASE).log -svseed random +assertdebug
# -coverage all ;-covtest $(TESTCASE) -covwork ./cov/$(TESTCASE) -covoverwrite
#	xrun $(GUI_FLAG) -clean -UVMLINEDEBUG -linedebug -access +rwc -uvm $$FILES -64bit -CFLAGS "-I./C_code_source_FPGA" +UVM_TESTNAME=$(TESTCASE) -logfile $(	TESTCASE).log
# -svseed 12345
# irun -uvm  $$FILES  -64bit
#	xrun -uvm -sv $$FILES -incdir $(UVM_SRC_PATH) $(UVM_SRC_PATH)/uvm_pkg.sv

compile_verilator_tb:
	FILE_TYPE=tb; \
	FILES=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$UVM_HOME; \
	verilator -Wno-fatal --binary -j $$(nproc) --top-module top_tb_IIR -CFLAGS "-I./C_code_source_FPGA" \
  +incdir+$$UVM_HOME \
	$$UVM_HOME/uvm_pkg.sv $$FILES


compile_xcelium_rtl:
	FILE_TYPE=rtl; \
	FILES=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$FILES; \
	xrun $$FILES

clean:
	@echo "Cleaning generated files..."
	rm -rf *.jou *.log *.str *.xpr *.runs *.cache *.hw *.ip_user_files xcelium.d .Xil compile_c

list:
	@echo "Available projects:"
	@ls scripts/*.tcl | sed 's/scripts\///;s/.tcl//'

