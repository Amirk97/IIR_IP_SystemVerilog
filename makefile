.ONESHELL:

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
else
GUI_FLAG =
endif

TESTCASE ?= const_coeff_test

#compile_C_files:
#	gcc -Wall -Wextra -o model

project:
	@echo "Building project: $(proj)"
	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL)

regression:
	FILE_TYPE=tests; \
	TESTS=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$TESTS; \
	docker start $(CONTAINER_NAME); \
	TESTLOG=""; \
	for t in $$TESTS;do \
		make exec_docker TESTCASE=$$t; \
		TESTLOG="$${TESTLOG} $${t}.log"
	done; \
	echo $$TESTLOG; \
	pwd; \
	python3 log_parser.py $$TESTLOG; \
	docker stop $(CONTAINER_NAME)

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
	docker exec  $(CONTAINER_NAME) bash -c "export DISPLAY=:0 && cd /proj && source /tools/Cadence/installs/XCELIUM2403/setup_xcelium.sh && make compile_xcelium_tb GUI=$(GUI) TESTCASE=$(TESTCASE)"
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
	xrun -elaborate -snapshot my_design -uvm $$FILES -64bit -CFLAGS "-I./C_code_source_FPGA"; \
	xrun -64bit -R  $(GUI_FLAG) -snapshot my_design +UVM_TESTNAME=$(TESTCASE) -UVMLINEDEBUG -linedebug -access +rwc -uvm -logfile $(TESTCASE).log
#	xrun $(GUI_FLAG) -clean -UVMLINEDEBUG -linedebug -access +rwc -uvm $$FILES -64bit -CFLAGS "-I./C_code_source_FPGA" +UVM_TESTNAME=$(TESTCASE) -logfile $(TESTCASE).log
# -svseed 12345
# irun -uvm  $$FILES  -64bit
#	xrun -uvm -sv $$FILES -incdir $(UVM_SRC_PATH) $(UVM_SRC_PATH)/uvm_pkg.sv

compile_xcelium_rtl:
	FILE_TYPE=rtl; \
	FILES=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$FILES; \
	xrun $$FILES

clean:
	@echo "Cleaning generated files..."
	rm -rf *.jou *.log *.str *.xpr *.runs *.cache *.hw *.ip_user_files xcelium.d .Xil

list:
	@echo "Available projects:"
	@ls scripts/*.tcl | sed 's/scripts\///;s/.tcl//'
