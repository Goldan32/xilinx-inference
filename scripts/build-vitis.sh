#!/bin/bash

PROJECT_ROOT=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd ; cd - > /dev/null)

VVAS_REPO=$PROJECT_ROOT
PLATFORM_PATH=$PROJECT_ROOT/platform_repo/xilinx_zcu106_vcuDec_DP/export/xilinx_zcu106_vcuDec_DP
VITIS_AI_REPO=$PROJECT_ROOT/Vitis-AI
pfm_name=xilinx_zcu106_vcuDec_DP.xpfm
DP_PROJECT=$VVAS_REPO/VVAS/vvas-examples/Embedded/smart_model_select

git -C $DP_PROJECT apply $PROJECT_ROOT/scripts/0001-Replace-rqs-report-for-zcu106.patch
make -C $DP_PROJECT PLATFORM=$PLATFORM_PATH/$pfm_name DPU_TRD_PATH=$VITIS_AI_REPO/DPUCZDX8G HW_ACCEL_PATH=$VVAS_REPO/VVAS/vvas-accel-hw/
