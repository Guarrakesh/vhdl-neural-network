#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Fri Feb 14 11:07:14 CET 2020
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 9343e6c614e94ad39fa687145ce14850 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb2_behav xil_defaultlib.tb2 -log elaborate.log"
xelab -wto 9343e6c614e94ad39fa687145ce14850 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb2_behav xil_defaultlib.tb2 -log elaborate.log

