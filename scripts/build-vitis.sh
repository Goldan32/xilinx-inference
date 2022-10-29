#!/bin/bash

VVAS_REPO=/home/goldan/onlab/
PLATFORM_PATH=/home/goldan/onlab/xilinx-inference/platform_repo/xilinx_zcu106_vcuDec_DP/export/xilinx_zcu106_vcuDec_DP
VITIS_AI_REPO=/home/goldan/onlab/Vitis-AI
pfm_name=xilinx_zcu106_vcuDec_DP.xpfm

make PLATFORM=$PLATFORM_PATH/$pfm_name DPU_TRD_PATH=$VITIS_AI_REPO/DPUCZDX8G HW_ACCEL_PATH=$VVAS_REPO/VVAS/vvas-accel-hw/
