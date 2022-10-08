VIVADO_PROJ_FOLDER=vivado-base-platform
PETALINUX_PROJ_FOLDER=petalinux-project
export PLATFORM ?= xilinx_zcu106_vcuDec_DP
CPU_ARCH=a53
XSCT = $(XILINX_VITIS)/bin/xsct
XSA_DIR ?= ./vivado-base-platform/build/vivado
CWD=$(shell pwd)
OUTPUT_PATH ?= $(CWD)/platform_repo

.PHONY: all clean

all: vivado-proj petalinux-proj petalinux-sysroot pfm

vivado-proj:
	make -C $(VIVADO_PROJ_FOLDER) all

petalinux-proj:
	make -C $(PETALINUX_PROJ_FOLDER) all

petalinux-sysroot:
	make -C $(PETALINUX_PROJ_FOLDER) sysroot

ifeq ($(COMMON_RFS_KRNL_SYSROOT), TRUE)
pfm:
	$(XSCT) -nodisp -sdx scripts/create_pfm.tcl ${PLATFORM} ${XSA_DIR} ${OUTPUT_PATH}
	mkdir platform_repo/${PLATFORM}/export/${PLATFORM}/sw/${PLATFORM}/pre-built/
	cp -rf platform_repo/tmp/sw_components/src/${CPU_ARCH}/BOOT.BIN platform_repo/${PLATFORM}/export/${PLATFORM}/sw/${PLATFORM}/pre-built/
else
pfm:
	$(XSCT) -nodisp -sdx scripts/create_pfm.tcl ${PLATFORM} ${XSA_DIR} ${OUTPUT_PATH}
	mkdir platform_repo/${PLATFORM}/export/${PLATFORM}/sw/${PLATFORM}/pre-built/
	cp -rf platform_repo/tmp/sw_components/src/${CPU_ARCH}/BOOT.BIN platform_repo/${PLATFORM}/export/${PLATFORM}/sw/${PLATFORM}/pre-built/
	cp -rf platform_repo/tmp/sw_components/src/${CPU_ARCH}/xrt/filesystem platform_repo/${PLATFORM}/export/${PLATFORM}/sw/${PLATFORM}/
endif

clean:
	make -C $(VIVADO_PROJ_FOLDER) clean
	make -C $(PETALINUX_PROJ_FOLDER) clean
	rm -rf $(OUTPUT_PATH)
	rm -rf .Xil/
