VIVADO_PROJ_FOLDER=vivado-base-platform
PETALINUX_PROJ_FOLDER=petalinux-project
export PLATFORM ?= xilinx_zcu106_vcuDec_DP

.PHONY: all clean

all: vivado-proj petalinux-proj

vivado-proj:
	make -C $(VIVADO_PROJ_FOLDER) all


petalinux-proj:
	make -C $(PETALINUX_PROJ_FOLDER) all

clean:
	make -C $(VIVADO_PROJ_FOLDER) clean
	make -C $(PETALINUX_PROJ_FOLDER) clean
