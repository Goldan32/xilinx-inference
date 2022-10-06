export PLATFORM ?= xilinx_zcu106_vcuDec_DP

ROOT_DIR=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))
ABS_BUILD_PATH=$(ROOT_DIR)/build
ABS_HW_PATH=$(ABS_BUILD_PATH)/vivado
BD_TCL=generate.tcl
ABS_BD_TCL=$(ROOT_DIR)/$(BD_TCL)

.PHONY: all

all: hw

hw:
	export PLATFORM=$(PLATFORM)
	mkdir -p $(ABS_HW_PATH)
	cd $(ABS_HW_PATH) && vivado -mode batch -notrace -source $(ABS_BD_TCL)
	echo ${PLATFORM} > src/a53/xrt/image/platform_desc.txt


clean:
	$(RM) -rf $(ABS_BUILD_PATH) vivado.* $(PLATFORM) $(PLATFORM).xsa .Xil *log *jou
