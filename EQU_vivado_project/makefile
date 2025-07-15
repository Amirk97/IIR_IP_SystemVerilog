# Makefile

# Default project (override with 'make proj=design2')
PROJECT_PATH ?= /media/amir/1C8F205019F09CF8/Users/amir9/Documents/EQU/EQU_vivado_project/EQU_vivado_project.xpr

# Vivado executable
VIVADO = vivado

# Target TCL script path
MAKE_PROJECT_TCL = ../scripts/make_vivado_project.tcl

elab_project:
	@echo "Building project: $(proj)"
	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL) -tclargs $(PROJECT_PATH)

compile_project:
	@echo "Building project: $(proj)"
	$(VIVADO) -mode batch -source $(MAKE_PROJECT_TCL)

clean:
	@echo "Cleaning generated files..."
	rm -rf *.jou *.log *.str *.xpr *.runs *.cache *.hw *.ip_user_files

list:
	@echo "Available projects:"
	@ls scripts/*.tcl | sed 's/scripts\///;s/.tcl//'
