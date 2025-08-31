.ONESHELL:

# Default project (override with 'make proj=design2')
proj_name = 

# Vivado executable
VIVADO = vivado

# Target TCL script path
MAKE_PROJECT_TCL = ./scripts/make_project.tcl

TOOL =

UVM_SRC_PATH = $(shell python3 yaml_parser.py files.yaml uvm_src_path)

CONTAINER_NAME ?= xc_env_cnt


#compile_C_files:
#	gcc -Wall -Wextra -o model

project:
	@echo "Building project: $(proj)"
	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL)

create_container:
	docker run --name $(CONTAINER_NAME) \
	-v /media/amir/1C8F205019F09CF8/Users/amir9/Documents/EQU/:/proj \
	-v /tools/Cadence:/mnt/Cadence \
	-d xc-env \
	tail -f /dev/null&& 

start_container:
	docker start $(CONTAINER_NAME)
	docker exec $(CONTAINER_NAME) bash -c " cd /proj && source /tools/Cadence/installs/XCELIUM2403/setup_xcelium.sh && make compile_xcelium_tb"
	docker stop $(CONTAINER_NAME)
#	docker logs -f xc_env_cnt

compile_xcelium_tb:
	FILE_TYPE=tb; \
	FILES=$$(python3 yaml_parser.py files.yaml $$FILE_TYPE); \
	echo $$FILES; \
	echo $$UVM_SRC_PATH; \
  xrun -clean -UVMLINEDEBUG -access +rwc -uvm  $$FILES  -64bit
#  irun -uvm  $$FILES  -64bit
##	xrun -uvm -sv $$FILES -incdir $(UVM_SRC_PATH) $(UVM_SRC_PATH)/uvm_pkg.sv

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
