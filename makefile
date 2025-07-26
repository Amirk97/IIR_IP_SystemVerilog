# Makefile

# Default project (override with 'make proj=design2')
proj_name = 

# Vivado executable
VIVADO = vivado

# Target TCL script path
MAKE_PROJECT_TCL = ./scripts/make_project.tcl

TOOL =

#FILES = $(shell pwd)/$(shell python3 yaml_parser.py files.yaml) 
FILES = $(shell python3 yaml_parser.py files.yaml) 

#CURRENT_DIR

project:
	@echo "Building project: $(proj)"
	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL)

compile_xcelium:
	@echo $(FILES)
	@xrun $(FILES)

clean:
	@echo "Cleaning generated files..."
	rm -rf *.jou *.log *.str *.xpr *.runs *.cache *.hw *.ip_user_files

list:
	@echo "Available projects:"
	@ls scripts/*.tcl | sed 's/scripts\///;s/.tcl//'
