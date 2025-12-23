.ONESHELL:

C_FILES := $(shell python3 yaml_parser.py files.yaml "c")

PY_ENV_PATH ?= /home/amir/venvs/pyuvm/bin/activate

# Default project (override with 'make proj=design2')
proj_name = 

# Vivado executable
VIVADO = vivado

# Target TCL script path
MAKE_PROJECT_TCL = ./scripts/make_project.tcl

TOOL =

UVM_SRC_PATH = $(shell python3 yaml_parser.py files.yaml uvm_src_path)

CONTAINER_NAME ?= xc_env_cnt2

TESTCASE ?= test_const_coeff
PY_TESTCASE ?= test_const_coeff
CFG_INDX ?=0
GUI ?= 0

ifeq ($(GUI),1)
GUI_FLAG = -gui
EXTRA_ARGS += --trace --trace-fst --trace-structs
else
GUI_FLAG =
endif

COCOTB_SEED ?=0
ifeq ($(COCOTB_SEED),0)
else
export COCOTB_RANDOM_SEED =$(COCOTB_SEED)
endif

XCE_SEED ?= random
#For Giving the params to verilator
EXTRA_ARGS += --coverage --trace-coverage 
PYTHONPATH = $(shell pwd)/Python_tb/
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = rtl/*.sv
VERILOG_INCLUDE_DIRS = rtl
TOPLEVEL = IIR
COCOTB_TEST_MODULES = top_tb_IIR
SIM = verilator
COCO_TRGT ?= all
export TOPLEVEL_LANG VERILOG_SOURCES TOPLEVEL COCOTB_TEST_MODULES SIM EXTRA_ARGS GUI PYTHONPATH VERILATOR_COMPILE_ARGS PY_TESTCASE COCOTB_FAIL_ON_ERROR CFG_INDX VERILOG_INCLUDE_DIRS

# Doesn't run reliably in terms of generated xml file
regression_coco_pytest:
	pytest -vv -s ./Python_tb/test_manager.py --junitxml=pytest_results.xml
	xmllint --format pytest_results.xml -o pytest_results.xml
	xmllint --format pytest_results.xml

compile_c: $(C_FILES)
	echo $(C_FILES)
	gcc -shared -fPIC $(C_FILES) -o ./Python_tb/libmylib.so &&
	@touch $@

cocotb: compile_c
	rm -rf ./sim_build
	CFG=$$(CFG_INDX=$(CFG_INDX) PY_TESTCASE=$(PY_TESTCASE) python3 ./Python_tb/cfg_pkg.py)
	EXTRA_ARGS="$${EXTRA_ARGS} $${CFG}"
	. $(PY_ENV_PATH) && \
	$(MAKE) -f $(shell cocotb-config --makefiles)/Makefile.sim $(COCO_TRGT) PY_TESTCASE=$(PY_TESTCASE); \
	deactivate

gtkwave:
	$(MAKE) cocotb GUI=1 PY_TESTCASE=$(PY_TESTCASE)
	gtkwave dump.fst 

regression_coco:
	FILE_TYPE=tests_py; \
	TESTS=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$TESTS; \
	TESTLOGS=""; \
	COVLOGS=""; \
	rm test-results/test*.xml
	rm total_coverage
	rm coverage_report/*.sv coverage_report/*.dat *.dat
	for t in $$TESTS;do \
		$(MAKE) cocotb PY_TESTCASE=$$t > /dev/null; \
	  mv results.xml test-results/$${t}.xml
		TESTLOGS="$${TESTLOGS} test-results/$${t}.xml"
		mv coverage.dat ./coverage_report/$${t}_coverage.dat
	 	COVLOGS="$${COVLOGS} $${t}_coverage.dat"	
	done; \
	echo $$TESTLOGS
	python3 cocotb_xml_parser.py $$TESTLOGS; \
	cd coverage_report;\
	verilator_coverage $${COVLOGS} --write total_coverage;\
	cd ..;\
	verilator_coverage ./coverage_report/total_coverage --annotate ./coverage_report/ --annotate-points --annotate-all

regression_sv_uvm:
	FILE_TYPE=tests; \
	TESTS=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$TESTS; \
	docker start $(CONTAINER_NAME); \
	TESTLOG=""; \
	for t in $$TESTS;do \
		$(MAKE) exec_docker TESTCASE=$$t ; \
		TESTLOG="$${TESTLOG} test-results/$${t}.log" ; \
	done; \
	docker cp $(CONTAINER_NAME):/proj/test-results/. ./test-results/; \
	python3 log_parser.py $$TESTLOG; \
	docker stop $(CONTAINER_NAME)

regression_all:
	$(MAKE) regression_sv_uvm
	$(MAKE) regression_coco
	xmllint --format test-results/results_xcelium.xml
	xmllint --format test-results/results_cocotb.xml

create_container:
	docker run --name $(CONTAINER_NAME) \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /mnt/drive2/Documents/IIR/:/proj \
	-v /tools/Cadence:/mnt/Cadence \
	-d xc-env \
	tail -f /dev/null

exec_docker:
	docker exec  $(CONTAINER_NAME) bash -c "export DISPLAY=:0 && cd /proj && source /tools/Cadence/installs/XCELIUM2403/setup_xcelium.sh && make compile_xcelium_tb GUI=$(GUI) TESTCASE=$(TESTCASE) XCE_SEED=$(XCE_SEED)"

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
	xrun -access +rwc -elaborate -snapshot my_design -uvm $$FILES -64bit -CFLAGS "-I./C_code_source_FPGA" +assertdebug +incdir+./rtl; \
	xrun -64bit -R  $(GUI_FLAG) -snapshot my_design +UVM_TESTNAME=$(TESTCASE) -UVMLINEDEBUG -linedebug -access +rwc -uvm -logfile test-results/$(TESTCASE).log -svseed $(XCE_SEED) +assertdebug
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
	rm -rf *.xml *.jou *.log *.str *.xpr *.runs *.cache *.hw *.ip_user_files xcelium.d .Xil compile_c *.fst sim_build test-results/*.xml total_coverage coverage_report/*.sv coverage_report/*.dat ./*.dat .bpad *.err *.diag
	rmdir ./.simvision

#list:
#	@echo "Available projects:"
#	@ls scripts/*.tcl | sed 's/scripts\///;s/.tcl//'
#
#project:
#	@echo "Building project: $(proj)"
#	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL)
