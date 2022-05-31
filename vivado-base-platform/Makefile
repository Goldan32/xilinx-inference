ROOT_DIR=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))
ABS_BUILD_PATH=$(ROOT_DIR)/build
ABS_HW_PATH=$(ABS_BUILD_PATH)/vivado
BD_TCL=generate.tcl
ABS_BD_TCL=$(ROOT_DIR)/$(BD_TCL)

.PHONY: all

all: hw

hw:
	mkdir -p $(ABS_HW_PATH)
	cd $(ABS_HW_PATH); vivado -mode batch -notrace -source $(ABS_BD_TCL) -source ../../export_xsa.tcl


clean:
	$(RM) -r $(ABS_BUILD_PATH) vivado*.log vivado*.jou 