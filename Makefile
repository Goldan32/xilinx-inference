VIVADO_PROJ_FOLDER=vivado-base-platform
PETALINUX_PROJ_FOLDER=petalinux-project
export PLATFORM ?= xilinx_zcu106_vcuDec_DP
CPU_ARCH=a53
XSCT = $(XILINX_VITIS)/bin/xsct
XSA_DIR ?= ./vivado-base-platform/build/vivado
CWD=$(shell pwd)
OUTPUT_PATH ?= $(CWD)/platform_repo
ACCELERATOR_DOWNLOAD_PATH = https://www.xilinx.com/bin/public/openDownload?filename=DPUCZDX8G.tar.gz
ACCELERATOR_NAME=DPUCZDX8G
ACCELERATOR_TARGZ=$(ACCELERATOR_NAME).tar.gz
VITIS_AI_PATH=./Vitis-AI

.PHONY: all platform clean

all: platform

platform: vivado-proj petalinux-proj petalinux-sysroot pfm

project: $(ACCELERATOR_NAME)

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

$(ACCELERATOR_NAME):
	wget -O $(VITIS_AI_PATH)/$(ACCELERATOR_TARGZ) $(ACCELERATOR_DOWNLOAD_PATH)
	tar -xf $(VITIS_AI_PATH)/$(ACCELERATOR_TARGZ) -C $(VITIS_AI_PATH)/
	rm $(VITIS_AI_PATH)/$(ACCELERATOR_TARGZ)

clean:
	make -C $(VIVADO_PROJ_FOLDER) clean
	make -C $(PETALINUX_PROJ_FOLDER) clean
	rm -rf $(OUTPUT_PATH)
	rm -rf .Xil/
