
################################################################
# This is a generated script based on design: image_processing_2d_design
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source image_processing_2d_design_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# frequency_analyzer_manager, frequency_analyzer_manager, frequency_analyzer_synch, image_capture_manager, linescanner_image_capture_unit, linescanner_image_capture_unit

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-3
}


# CHANGE DESIGN NAME HERE
set design_name image_processing_2d_design

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set LINESCANNER0_DATA [ create_bd_port -dir I -from 7 -to 0 LINESCANNER0_DATA ]
  set LINESCANNER0_END_ADC [ create_bd_port -dir I LINESCANNER0_END_ADC ]
  set LINESCANNER0_LOAD_PULSE [ create_bd_port -dir O LINESCANNER0_LOAD_PULSE ]
  set LINESCANNER0_LVAL [ create_bd_port -dir I LINESCANNER0_LVAL ]
  set LINESCANNER0_MAIN_CLOCK [ create_bd_port -dir O -type clk LINESCANNER0_MAIN_CLOCK ]
  set LINESCANNER0_N_RESET [ create_bd_port -dir O -from 0 -to 0 -type rst LINESCANNER0_N_RESET ]
  set LINESCANNER0_PIXEL_CLOCK [ create_bd_port -dir I -type clk LINESCANNER0_PIXEL_CLOCK ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {25000000} \
 ] $LINESCANNER0_PIXEL_CLOCK
  set LINESCANNER0_RST_CDS [ create_bd_port -dir O LINESCANNER0_RST_CDS ]
  set LINESCANNER0_RST_CVC [ create_bd_port -dir O LINESCANNER0_RST_CVC ]
  set LINESCANNER0_SAMPLE [ create_bd_port -dir O LINESCANNER0_SAMPLE ]
  set LINESCANNER1_DATA [ create_bd_port -dir I -from 7 -to 0 LINESCANNER1_DATA ]
  set LINESCANNER1_END_ADC [ create_bd_port -dir I LINESCANNER1_END_ADC ]
  set LINESCANNER1_LOAD_PULSE [ create_bd_port -dir O LINESCANNER1_LOAD_PULSE ]
  set LINESCANNER1_LVAL [ create_bd_port -dir I LINESCANNER1_LVAL ]
  set LINESCANNER1_MAIN_CLOCK [ create_bd_port -dir O -type clk LINESCANNER1_MAIN_CLOCK ]
  set LINESCANNER1_N_RESET [ create_bd_port -dir O -from 0 -to 0 -type rst LINESCANNER1_N_RESET ]
  set LINESCANNER1_PIXEL_CLOCK [ create_bd_port -dir I -type clk LINESCANNER1_PIXEL_CLOCK ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {25000000} \
 ] $LINESCANNER1_PIXEL_CLOCK
  set LINESCANNER1_RST_CDS [ create_bd_port -dir O LINESCANNER1_RST_CDS ]
  set LINESCANNER1_RST_CVC [ create_bd_port -dir O LINESCANNER1_RST_CVC ]
  set LINESCANNER1_SAMPLE [ create_bd_port -dir O LINESCANNER1_SAMPLE ]
  set LINESCANNER_CLK [ create_bd_port -dir O -type clk LINESCANNER_CLK ]
  set LINESCANNER_CS [ create_bd_port -dir O -from 1 -to 0 LINESCANNER_CS ]
  set LINESCANNER_MISO [ create_bd_port -dir I LINESCANNER_MISO ]
  set LINESCANNER_MOSI [ create_bd_port -dir O LINESCANNER_MOSI ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {5} \
CONFIG.NUM_SI {2} \
 ] $axi_interconnect_0

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
CONFIG.C_FIFO_DEPTH {16} \
CONFIG.C_NUM_SS_BITS {2} \
CONFIG.C_NUM_TRANSFER_BITS {8} \
CONFIG.C_SCK_RATIO {2} \
CONFIG.C_TYPE_OF_AXI4_INTERFACE {0} \
CONFIG.C_USE_STARTUP {0} \
CONFIG.C_USE_STARTUP_INT {0} \
CONFIG.C_XIP_MODE {0} \
CONFIG.FIFO_INCLUDED {1} \
CONFIG.Master_mode {1} \
 ] $axi_quad_spi_0

  # Create instance: frequency_analyzer_manager_0, and set properties
  set block_name frequency_analyzer_manager
  set block_cell_name frequency_analyzer_manager_0
  if { [catch {set frequency_analyzer_manager_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $frequency_analyzer_manager_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
CONFIG.FREQUENCY_DEVIATION {20} \
CONFIG.PIXEL0_FREQUENCY0 {5000} \
CONFIG.PIXEL0_FREQUENCY1 {10000} \
CONFIG.PIXEL0_INDEX {63} \
CONFIG.PIXEL1_INDEX {511} \
CONFIG.PIXEL2_FREQUENCY0 {40000} \
CONFIG.PIXEL2_FREQUENCY1 {50000} \
CONFIG.PIXEL2_INDEX {1000} \
 ] $frequency_analyzer_manager_0

  # Create instance: frequency_analyzer_manager_1, and set properties
  set block_name frequency_analyzer_manager
  set block_cell_name frequency_analyzer_manager_1
  if { [catch {set frequency_analyzer_manager_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $frequency_analyzer_manager_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
CONFIG.FREQUENCY_DEVIATION {20} \
CONFIG.PIXEL0_FREQUENCY0 {5000} \
CONFIG.PIXEL0_FREQUENCY1 {10000} \
CONFIG.PIXEL0_INDEX {63} \
CONFIG.PIXEL2_FREQUENCY0 {40000} \
CONFIG.PIXEL2_FREQUENCY1 {50000} \
CONFIG.PIXEL2_INDEX {1000} \
 ] $frequency_analyzer_manager_1

  # Create instance: frequency_analyzer_synch_0, and set properties
  set block_name frequency_analyzer_synch
  set block_cell_name frequency_analyzer_synch_0
  if { [catch {set frequency_analyzer_synch_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $frequency_analyzer_synch_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: image_capture_manager_0, and set properties
  set block_name image_capture_manager
  set block_cell_name image_capture_manager_0
  if { [catch {set image_capture_manager_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $image_capture_manager_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: linescanner_image_capture_unit_0, and set properties
  set block_name linescanner_image_capture_unit
  set block_cell_name linescanner_image_capture_unit_0
  if { [catch {set linescanner_image_capture_unit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $linescanner_image_capture_unit_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: linescanner_image_capture_unit_1, and set properties
  set block_name linescanner_image_capture_unit
  set block_cell_name linescanner_image_capture_unit_1
  if { [catch {set linescanner_image_capture_unit_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $linescanner_image_capture_unit_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]
  set_property -dict [ list \
CONFIG.C_AUX_RST_WIDTH {16} \
CONFIG.C_EXT_RST_WIDTH {16} \
 ] $proc_sys_reset_0

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
CONFIG.PCW_ACT_CAN0_PERIPHERAL_FREQMHZ {23.8095} \
CONFIG.PCW_ACT_CAN1_PERIPHERAL_FREQMHZ {23.8095} \
CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {125.000000} \
CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {20.000000} \
CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_I2C_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_ACT_TTC_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ACT_USB0_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_ACT_USB1_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {666.666667} \
CONFIG.PCW_ARMPLL_CTRL_FBDIV {60} \
CONFIG.PCW_CAN0_BASEADDR {0xE0008000} \
CONFIG.PCW_CAN0_CAN0_IO {<Select>} \
CONFIG.PCW_CAN0_GRP_CLK_ENABLE {0} \
CONFIG.PCW_CAN0_GRP_CLK_IO {<Select>} \
CONFIG.PCW_CAN0_HIGHADDR {0xE0008FFF} \
CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN0_PERIPHERAL_FREQMHZ {-1} \
CONFIG.PCW_CAN1_BASEADDR {0xE0009000} \
CONFIG.PCW_CAN1_CAN1_IO {<Select>} \
CONFIG.PCW_CAN1_GRP_CLK_ENABLE {0} \
CONFIG.PCW_CAN1_GRP_CLK_IO {<Select>} \
CONFIG.PCW_CAN1_HIGHADDR {0xE0009FFF} \
CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN1_PERIPHERAL_FREQMHZ {-1} \
CONFIG.PCW_CAN_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_CAN_PERIPHERAL_VALID {0} \
CONFIG.PCW_CLK0_FREQ {100000000} \
CONFIG.PCW_CLK1_FREQ {50000000} \
CONFIG.PCW_CLK2_FREQ {20000000} \
CONFIG.PCW_CLK3_FREQ {10000000} \
CONFIG.PCW_CORE0_FIQ_INTR {0} \
CONFIG.PCW_CORE0_IRQ_INTR {0} \
CONFIG.PCW_CORE1_FIQ_INTR {0} \
CONFIG.PCW_CORE1_IRQ_INTR {0} \
CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {867} \
CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {2000.000} \
CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {3} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} \
CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION {HPR(0)/LPR(32)} \
CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL {15} \
CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL {2} \
CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
CONFIG.PCW_DDR_PORT0_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT1_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT2_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT3_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PRIORITY_READPORT_0 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_1 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_2 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_3 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3 {<Select>} \
CONFIG.PCW_DDR_RAM_BASEADDR {0x00100000} \
CONFIG.PCW_DDR_RAM_HIGHADDR {0x1FFFFFFF} \
CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL {2} \
CONFIG.PCW_DM_WIDTH {4} \
CONFIG.PCW_DQS_WIDTH {4} \
CONFIG.PCW_DQ_WIDTH {32} \
CONFIG.PCW_ENET0_BASEADDR {0xE000B000} \
CONFIG.PCW_ENET0_ENET0_IO {<Select>} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {0} \
CONFIG.PCW_ENET0_GRP_MDIO_IO {<Select>} \
CONFIG.PCW_ENET0_HIGHADDR {0xE000BFFF} \
CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} \
CONFIG.PCW_ENET0_RESET_IO {<Select>} \
CONFIG.PCW_ENET1_BASEADDR {0xE000C000} \
CONFIG.PCW_ENET1_ENET1_IO {<Select>} \
CONFIG.PCW_ENET1_GRP_MDIO_ENABLE {0} \
CONFIG.PCW_ENET1_GRP_MDIO_IO {<Select>} \
CONFIG.PCW_ENET1_HIGHADDR {0xE000CFFF} \
CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET1_RESET_ENABLE {0} \
CONFIG.PCW_ENET1_RESET_IO {<Select>} \
CONFIG.PCW_ENET_RESET_ENABLE {0} \
CONFIG.PCW_ENET_RESET_POLARITY {Active Low} \
CONFIG.PCW_ENET_RESET_SELECT {<Select>} \
CONFIG.PCW_EN_4K_TIMER {0} \
CONFIG.PCW_EN_CAN0 {0} \
CONFIG.PCW_EN_CAN1 {0} \
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_CLK3_PORT {0} \
CONFIG.PCW_EN_CLKTRIG0_PORT {0} \
CONFIG.PCW_EN_CLKTRIG1_PORT {0} \
CONFIG.PCW_EN_CLKTRIG2_PORT {0} \
CONFIG.PCW_EN_CLKTRIG3_PORT {0} \
CONFIG.PCW_EN_DDR {1} \
CONFIG.PCW_EN_EMIO_CAN0 {0} \
CONFIG.PCW_EN_EMIO_CAN1 {0} \
CONFIG.PCW_EN_EMIO_CD_SDIO0 {0} \
CONFIG.PCW_EN_EMIO_CD_SDIO1 {0} \
CONFIG.PCW_EN_EMIO_ENET0 {0} \
CONFIG.PCW_EN_EMIO_ENET1 {0} \
CONFIG.PCW_EN_EMIO_GPIO {1} \
CONFIG.PCW_EN_EMIO_I2C0 {0} \
CONFIG.PCW_EN_EMIO_I2C1 {0} \
CONFIG.PCW_EN_EMIO_MODEM_UART0 {0} \
CONFIG.PCW_EN_EMIO_MODEM_UART1 {0} \
CONFIG.PCW_EN_EMIO_PJTAG {0} \
CONFIG.PCW_EN_EMIO_SDIO0 {0} \
CONFIG.PCW_EN_EMIO_SDIO1 {0} \
CONFIG.PCW_EN_EMIO_SPI0 {0} \
CONFIG.PCW_EN_EMIO_SPI1 {0} \
CONFIG.PCW_EN_EMIO_SRAM_INT {0} \
CONFIG.PCW_EN_EMIO_TRACE {0} \
CONFIG.PCW_EN_EMIO_TTC0 {1} \
CONFIG.PCW_EN_EMIO_TTC1 {0} \
CONFIG.PCW_EN_EMIO_UART0 {0} \
CONFIG.PCW_EN_EMIO_UART1 {0} \
CONFIG.PCW_EN_EMIO_WDT {0} \
CONFIG.PCW_EN_EMIO_WP_SDIO0 {0} \
CONFIG.PCW_EN_EMIO_WP_SDIO1 {0} \
CONFIG.PCW_EN_ENET0 {0} \
CONFIG.PCW_EN_ENET1 {0} \
CONFIG.PCW_EN_GPIO {1} \
CONFIG.PCW_EN_I2C0 {0} \
CONFIG.PCW_EN_I2C1 {0} \
CONFIG.PCW_EN_MODEM_UART0 {0} \
CONFIG.PCW_EN_MODEM_UART1 {0} \
CONFIG.PCW_EN_PJTAG {0} \
CONFIG.PCW_EN_PTP_ENET0 {0} \
CONFIG.PCW_EN_PTP_ENET1 {0} \
CONFIG.PCW_EN_QSPI {0} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {0} \
CONFIG.PCW_EN_RST3_PORT {0} \
CONFIG.PCW_EN_SDIO0 {1} \
CONFIG.PCW_EN_SDIO1 {0} \
CONFIG.PCW_EN_SMC {1} \
CONFIG.PCW_EN_SPI0 {0} \
CONFIG.PCW_EN_SPI1 {0} \
CONFIG.PCW_EN_TRACE {0} \
CONFIG.PCW_EN_TTC0 {1} \
CONFIG.PCW_EN_TTC1 {0} \
CONFIG.PCW_EN_UART0 {0} \
CONFIG.PCW_EN_UART1 {1} \
CONFIG.PCW_EN_USB0 {0} \
CONFIG.PCW_EN_USB1 {0} \
CONFIG.PCW_EN_WDT {0} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {4} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {8} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {5} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {10} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {10} \
CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK_CLK0_BUF {true} \
CONFIG.PCW_FCLK_CLK1_BUF {true} \
CONFIG.PCW_FCLK_CLK2_BUF {true} \
CONFIG.PCW_FCLK_CLK3_BUF {false} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {20} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
CONFIG.PCW_FPGA_FCLK2_ENABLE {1} \
CONFIG.PCW_FPGA_FCLK3_ENABLE {0} \
CONFIG.PCW_FTM_CTI_IN0 {DISABLED} \
CONFIG.PCW_FTM_CTI_IN1 {DISABLED} \
CONFIG.PCW_FTM_CTI_IN2 {DISABLED} \
CONFIG.PCW_FTM_CTI_IN3 {DISABLED} \
CONFIG.PCW_FTM_CTI_OUT0 {DISABLED} \
CONFIG.PCW_FTM_CTI_OUT1 {DISABLED} \
CONFIG.PCW_FTM_CTI_OUT2 {DISABLED} \
CONFIG.PCW_FTM_CTI_OUT3 {DISABLED} \
CONFIG.PCW_GPIO_BASEADDR {0xE000A000} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO {4} \
CONFIG.PCW_GPIO_EMIO_GPIO_WIDTH {4} \
CONFIG.PCW_GPIO_HIGHADDR {0xE000AFFF} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_BASEADDR {0xE0004000} \
CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
CONFIG.PCW_I2C0_GRP_INT_IO {<Select>} \
CONFIG.PCW_I2C0_HIGHADDR {0xE0004FFF} \
CONFIG.PCW_I2C0_I2C0_IO {<Select>} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_IO {<Select>} \
CONFIG.PCW_I2C1_BASEADDR {0xE0005000} \
CONFIG.PCW_I2C1_GRP_INT_ENABLE {0} \
CONFIG.PCW_I2C1_GRP_INT_IO {<Select>} \
CONFIG.PCW_I2C1_HIGHADDR {0xE0005FFF} \
CONFIG.PCW_I2C1_I2C1_IO {<Select>} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C1_RESET_ENABLE {0} \
CONFIG.PCW_I2C1_RESET_IO {<Select>} \
CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_I2C_RESET_POLARITY {Active Low} \
CONFIG.PCW_I2C_RESET_SELECT {<Select>} \
CONFIG.PCW_IMPORT_BOARD_PRESET {None} \
CONFIG.PCW_INCLUDE_ACP_TRANS_CHECK {0} \
CONFIG.PCW_INCLUDE_TRACE_BUFFER {0} \
CONFIG.PCW_IOPLL_CTRL_FBDIV {60} \
CONFIG.PCW_IO_IO_PLL_FREQMHZ {2000.000} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_IRQ_F2P_MODE {DIRECT} \
CONFIG.PCW_MIO_0_DIRECTION {out} \
CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_0_PULLUP {enabled} \
CONFIG.PCW_MIO_0_SLEW {slow} \
CONFIG.PCW_MIO_10_DIRECTION {inout} \
CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_10_PULLUP {enabled} \
CONFIG.PCW_MIO_10_SLEW {slow} \
CONFIG.PCW_MIO_11_DIRECTION {inout} \
CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_11_PULLUP {enabled} \
CONFIG.PCW_MIO_11_SLEW {slow} \
CONFIG.PCW_MIO_12_DIRECTION {inout} \
CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_12_PULLUP {enabled} \
CONFIG.PCW_MIO_12_SLEW {slow} \
CONFIG.PCW_MIO_13_DIRECTION {inout} \
CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_13_PULLUP {enabled} \
CONFIG.PCW_MIO_13_SLEW {slow} \
CONFIG.PCW_MIO_14_DIRECTION {in} \
CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_14_PULLUP {enabled} \
CONFIG.PCW_MIO_14_SLEW {slow} \
CONFIG.PCW_MIO_15_DIRECTION {inout} \
CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_15_PULLUP {enabled} \
CONFIG.PCW_MIO_15_SLEW {slow} \
CONFIG.PCW_MIO_16_DIRECTION {inout} \
CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_16_SLEW {fast} \
CONFIG.PCW_MIO_17_DIRECTION {inout} \
CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_17_SLEW {fast} \
CONFIG.PCW_MIO_18_DIRECTION {inout} \
CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_18_SLEW {fast} \
CONFIG.PCW_MIO_19_DIRECTION {inout} \
CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_19_SLEW {fast} \
CONFIG.PCW_MIO_1_DIRECTION {inout} \
CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_1_PULLUP {disabled} \
CONFIG.PCW_MIO_1_SLEW {fast} \
CONFIG.PCW_MIO_20_DIRECTION {inout} \
CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_20_SLEW {fast} \
CONFIG.PCW_MIO_21_DIRECTION {inout} \
CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_21_SLEW {fast} \
CONFIG.PCW_MIO_22_DIRECTION {inout} \
CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_22_SLEW {fast} \
CONFIG.PCW_MIO_23_DIRECTION {inout} \
CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_23_SLEW {fast} \
CONFIG.PCW_MIO_24_DIRECTION {inout} \
CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_24_SLEW {fast} \
CONFIG.PCW_MIO_25_DIRECTION {inout} \
CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_25_SLEW {fast} \
CONFIG.PCW_MIO_26_DIRECTION {inout} \
CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_26_SLEW {fast} \
CONFIG.PCW_MIO_27_DIRECTION {inout} \
CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_27_SLEW {fast} \
CONFIG.PCW_MIO_28_DIRECTION {inout} \
CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_28_PULLUP {enabled} \
CONFIG.PCW_MIO_28_SLEW {slow} \
CONFIG.PCW_MIO_29_DIRECTION {inout} \
CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_29_PULLUP {enabled} \
CONFIG.PCW_MIO_29_SLEW {slow} \
CONFIG.PCW_MIO_2_DIRECTION {out} \
CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_2_PULLUP {disabled} \
CONFIG.PCW_MIO_2_SLEW {fast} \
CONFIG.PCW_MIO_30_DIRECTION {inout} \
CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_30_PULLUP {enabled} \
CONFIG.PCW_MIO_30_SLEW {slow} \
CONFIG.PCW_MIO_31_DIRECTION {inout} \
CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_31_PULLUP {enabled} \
CONFIG.PCW_MIO_31_SLEW {slow} \
CONFIG.PCW_MIO_32_DIRECTION {inout} \
CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_32_PULLUP {enabled} \
CONFIG.PCW_MIO_32_SLEW {slow} \
CONFIG.PCW_MIO_33_DIRECTION {inout} \
CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_33_PULLUP {enabled} \
CONFIG.PCW_MIO_33_SLEW {slow} \
CONFIG.PCW_MIO_34_DIRECTION {in} \
CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_34_PULLUP {enabled} \
CONFIG.PCW_MIO_34_SLEW {slow} \
CONFIG.PCW_MIO_35_DIRECTION {in} \
CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_35_PULLUP {enabled} \
CONFIG.PCW_MIO_35_SLEW {slow} \
CONFIG.PCW_MIO_36_DIRECTION {inout} \
CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_36_PULLUP {enabled} \
CONFIG.PCW_MIO_36_SLEW {slow} \
CONFIG.PCW_MIO_37_DIRECTION {inout} \
CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_37_PULLUP {enabled} \
CONFIG.PCW_MIO_37_SLEW {slow} \
CONFIG.PCW_MIO_38_DIRECTION {inout} \
CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_38_PULLUP {enabled} \
CONFIG.PCW_MIO_38_SLEW {slow} \
CONFIG.PCW_MIO_39_DIRECTION {inout} \
CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_39_PULLUP {enabled} \
CONFIG.PCW_MIO_39_SLEW {slow} \
CONFIG.PCW_MIO_3_DIRECTION {out} \
CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_3_PULLUP {disabled} \
CONFIG.PCW_MIO_3_SLEW {fast} \
CONFIG.PCW_MIO_40_DIRECTION {inout} \
CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_40_PULLUP {disabled} \
CONFIG.PCW_MIO_40_SLEW {fast} \
CONFIG.PCW_MIO_41_DIRECTION {inout} \
CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_41_SLEW {fast} \
CONFIG.PCW_MIO_42_DIRECTION {inout} \
CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_42_PULLUP {disabled} \
CONFIG.PCW_MIO_42_SLEW {fast} \
CONFIG.PCW_MIO_43_DIRECTION {inout} \
CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_43_SLEW {fast} \
CONFIG.PCW_MIO_44_DIRECTION {inout} \
CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_44_PULLUP {disabled} \
CONFIG.PCW_MIO_44_SLEW {fast} \
CONFIG.PCW_MIO_45_DIRECTION {inout} \
CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_45_SLEW {fast} \
CONFIG.PCW_MIO_46_DIRECTION {inout} \
CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_46_PULLUP {disabled} \
CONFIG.PCW_MIO_46_SLEW {slow} \
CONFIG.PCW_MIO_47_DIRECTION {inout} \
CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_47_PULLUP {disabled} \
CONFIG.PCW_MIO_47_SLEW {slow} \
CONFIG.PCW_MIO_48_DIRECTION {out} \
CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_48_PULLUP {disabled} \
CONFIG.PCW_MIO_48_SLEW {slow} \
CONFIG.PCW_MIO_49_DIRECTION {in} \
CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_49_PULLUP {disabled} \
CONFIG.PCW_MIO_49_SLEW {slow} \
CONFIG.PCW_MIO_4_DIRECTION {inout} \
CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_4_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {fast} \
CONFIG.PCW_MIO_50_DIRECTION {inout} \
CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_50_PULLUP {disabled} \
CONFIG.PCW_MIO_50_SLEW {slow} \
CONFIG.PCW_MIO_51_DIRECTION {inout} \
CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_51_PULLUP {disabled} \
CONFIG.PCW_MIO_51_SLEW {slow} \
CONFIG.PCW_MIO_52_DIRECTION {inout} \
CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_52_PULLUP {disabled} \
CONFIG.PCW_MIO_52_SLEW {slow} \
CONFIG.PCW_MIO_53_DIRECTION {inout} \
CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_53_PULLUP {disabled} \
CONFIG.PCW_MIO_53_SLEW {slow} \
CONFIG.PCW_MIO_5_DIRECTION {inout} \
CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_5_PULLUP {disabled} \
CONFIG.PCW_MIO_5_SLEW {fast} \
CONFIG.PCW_MIO_6_DIRECTION {inout} \
CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_6_PULLUP {disabled} \
CONFIG.PCW_MIO_6_SLEW {fast} \
CONFIG.PCW_MIO_7_DIRECTION {out} \
CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_7_PULLUP {disabled} \
CONFIG.PCW_MIO_7_SLEW {slow} \
CONFIG.PCW_MIO_8_DIRECTION {out} \
CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_8_PULLUP {disabled} \
CONFIG.PCW_MIO_8_SLEW {slow} \
CONFIG.PCW_MIO_9_DIRECTION {inout} \
CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_9_PULLUP {enabled} \
CONFIG.PCW_MIO_9_SLEW {slow} \
CONFIG.PCW_MIO_PRIMITIVE {54} \
CONFIG.PCW_MIO_TREE_PERIPHERALS {NAND Flash#GPIO#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#NAND Flash#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#UART 1#UART 1#GPIO#GPIO#GPIO#GPIO} \
CONFIG.PCW_MIO_TREE_SIGNALS {cs#gpio[1]#ale#we_b#data[2]#data[0]#data[1]#cle#re_b#data[4]#data[5]#data[6]#data[7]#data[3]#busy#gpio[15]#gpio[16]#gpio[17]#gpio[18]#gpio[19]#gpio[20]#gpio[21]#gpio[22]#gpio[23]#gpio[24]#gpio[25]#gpio[26]#gpio[27]#clk#cmd#data[0]#data[1]#data[2]#data[3]#wp#cd#gpio[36]#gpio[37]#gpio[38]#gpio[39]#gpio[40]#gpio[41]#gpio[42]#gpio[43]#gpio[44]#gpio[45]#gpio[46]#gpio[47]#tx#rx#gpio[50]#gpio[51]#gpio[52]#gpio[53]} \
CONFIG.PCW_M_AXI_GP0_ENABLE_STATIC_REMAP {0} \
CONFIG.PCW_M_AXI_GP0_FREQMHZ {50} \
CONFIG.PCW_M_AXI_GP0_ID_WIDTH {12} \
CONFIG.PCW_M_AXI_GP0_SUPPORT_NARROW_BURST {0} \
CONFIG.PCW_M_AXI_GP0_THREAD_ID_WIDTH {12} \
CONFIG.PCW_M_AXI_GP1_ENABLE_STATIC_REMAP {0} \
CONFIG.PCW_M_AXI_GP1_FREQMHZ {10} \
CONFIG.PCW_M_AXI_GP1_ID_WIDTH {12} \
CONFIG.PCW_M_AXI_GP1_SUPPORT_NARROW_BURST {0} \
CONFIG.PCW_M_AXI_GP1_THREAD_ID_WIDTH {12} \
CONFIG.PCW_NAND_CYCLES_T_AR {1} \
CONFIG.PCW_NAND_CYCLES_T_CLR {1} \
CONFIG.PCW_NAND_CYCLES_T_RC {11} \
CONFIG.PCW_NAND_CYCLES_T_REA {1} \
CONFIG.PCW_NAND_CYCLES_T_RR {1} \
CONFIG.PCW_NAND_CYCLES_T_WC {11} \
CONFIG.PCW_NAND_CYCLES_T_WP {1} \
CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
CONFIG.PCW_NAND_GRP_D8_IO {<Select>} \
CONFIG.PCW_NAND_NAND_IO {MIO 0 2.. 14} \
CONFIG.PCW_NAND_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_NOR_CS0_T_CEOE {1} \
CONFIG.PCW_NOR_CS0_T_PC {1} \
CONFIG.PCW_NOR_CS0_T_RC {11} \
CONFIG.PCW_NOR_CS0_T_TR {1} \
CONFIG.PCW_NOR_CS0_T_WC {11} \
CONFIG.PCW_NOR_CS0_T_WP {1} \
CONFIG.PCW_NOR_CS0_WE_TIME {0} \
CONFIG.PCW_NOR_CS1_T_CEOE {1} \
CONFIG.PCW_NOR_CS1_T_PC {1} \
CONFIG.PCW_NOR_CS1_T_RC {11} \
CONFIG.PCW_NOR_CS1_T_TR {1} \
CONFIG.PCW_NOR_CS1_T_WC {11} \
CONFIG.PCW_NOR_CS1_T_WP {1} \
CONFIG.PCW_NOR_CS1_WE_TIME {0} \
CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
CONFIG.PCW_NOR_GRP_A25_IO {<Select>} \
CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
CONFIG.PCW_NOR_GRP_CS0_IO {<Select>} \
CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
CONFIG.PCW_NOR_GRP_CS1_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_INT_IO {<Select>} \
CONFIG.PCW_NOR_NOR_IO {<Select>} \
CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_NOR_SRAM_CS0_T_CEOE {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_PC {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_RC {11} \
CONFIG.PCW_NOR_SRAM_CS0_T_TR {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_WC {11} \
CONFIG.PCW_NOR_SRAM_CS0_T_WP {1} \
CONFIG.PCW_NOR_SRAM_CS0_WE_TIME {0} \
CONFIG.PCW_NOR_SRAM_CS1_T_CEOE {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_PC {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_RC {11} \
CONFIG.PCW_NOR_SRAM_CS1_T_TR {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_WC {11} \
CONFIG.PCW_NOR_SRAM_CS1_T_WP {1} \
CONFIG.PCW_NOR_SRAM_CS1_WE_TIME {0} \
CONFIG.PCW_OVERRIDE_BASIC_CLOCK {0} \
CONFIG.PCW_P2F_CAN0_INTR {0} \
CONFIG.PCW_P2F_CAN1_INTR {0} \
CONFIG.PCW_P2F_CTI_INTR {0} \
CONFIG.PCW_P2F_DMAC0_INTR {0} \
CONFIG.PCW_P2F_DMAC1_INTR {0} \
CONFIG.PCW_P2F_DMAC2_INTR {0} \
CONFIG.PCW_P2F_DMAC3_INTR {0} \
CONFIG.PCW_P2F_DMAC4_INTR {0} \
CONFIG.PCW_P2F_DMAC5_INTR {0} \
CONFIG.PCW_P2F_DMAC6_INTR {0} \
CONFIG.PCW_P2F_DMAC7_INTR {0} \
CONFIG.PCW_P2F_DMAC_ABORT_INTR {0} \
CONFIG.PCW_P2F_ENET0_INTR {0} \
CONFIG.PCW_P2F_ENET1_INTR {0} \
CONFIG.PCW_P2F_GPIO_INTR {0} \
CONFIG.PCW_P2F_I2C0_INTR {0} \
CONFIG.PCW_P2F_I2C1_INTR {0} \
CONFIG.PCW_P2F_QSPI_INTR {0} \
CONFIG.PCW_P2F_SDIO0_INTR {0} \
CONFIG.PCW_P2F_SDIO1_INTR {0} \
CONFIG.PCW_P2F_SMC_INTR {0} \
CONFIG.PCW_P2F_SPI0_INTR {0} \
CONFIG.PCW_P2F_SPI1_INTR {0} \
CONFIG.PCW_P2F_UART0_INTR {0} \
CONFIG.PCW_P2F_UART1_INTR {0} \
CONFIG.PCW_P2F_USB0_INTR {0} \
CONFIG.PCW_P2F_USB1_INTR {0} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.469} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.468} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.270} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.288} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.059} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.063} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {0.404} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {0.362} \
CONFIG.PCW_PACKAGE_NAME {clg484} \
CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {10} \
CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_PERIPHERAL_BOARD_PRESET {part0} \
CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_PJTAG_PJTAG_IO {<Select>} \
CONFIG.PCW_PLL_BYPASSMODE_ENABLE {0} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 3.3V} \
CONFIG.PCW_PS7_SI_REV {PRODUCTION} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_FBCLK_IO {<Select>} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_IO1_IO {<Select>} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {<Select>} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SS1_IO {<Select>} \
CONFIG.PCW_QSPI_INTERNAL_HIGHADDRESS {0xFCFFFFFF} \
CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_QSPI_QSPI_IO {<Select>} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 35} \
CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
CONFIG.PCW_SD0_GRP_POW_IO {<Select>} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
CONFIG.PCW_SD0_GRP_WP_IO {MIO 34} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_SD0_IO {MIO 28 .. 33} \
CONFIG.PCW_SD1_GRP_CD_ENABLE {0} \
CONFIG.PCW_SD1_GRP_CD_IO {<Select>} \
CONFIG.PCW_SD1_GRP_POW_ENABLE {0} \
CONFIG.PCW_SD1_GRP_POW_IO {<Select>} \
CONFIG.PCW_SD1_GRP_WP_ENABLE {0} \
CONFIG.PCW_SD1_GRP_WP_IO {<Select>} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SD1_SD1_IO {<Select>} \
CONFIG.PCW_SDIO0_BASEADDR {0xE0100000} \
CONFIG.PCW_SDIO0_HIGHADDR {0xE0100FFF} \
CONFIG.PCW_SDIO1_BASEADDR {0xE0101000} \
CONFIG.PCW_SDIO1_HIGHADDR {0xE0101FFF} \
CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {40} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
CONFIG.PCW_SMC_CYCLE_T0 {NA} \
CONFIG.PCW_SMC_CYCLE_T1 {NA} \
CONFIG.PCW_SMC_CYCLE_T2 {NA} \
CONFIG.PCW_SMC_CYCLE_T3 {NA} \
CONFIG.PCW_SMC_CYCLE_T4 {NA} \
CONFIG.PCW_SMC_CYCLE_T5 {NA} \
CONFIG.PCW_SMC_CYCLE_T6 {NA} \
CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {20} \
CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_SMC_PERIPHERAL_VALID {1} \
CONFIG.PCW_SPI0_BASEADDR {0xE0006000} \
CONFIG.PCW_SPI0_GRP_SS0_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS0_IO {<Select>} \
CONFIG.PCW_SPI0_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS1_IO {<Select>} \
CONFIG.PCW_SPI0_GRP_SS2_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS2_IO {<Select>} \
CONFIG.PCW_SPI0_HIGHADDR {0xE0006FFF} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI0_SPI0_IO {<Select>} \
CONFIG.PCW_SPI1_BASEADDR {0xE0007000} \
CONFIG.PCW_SPI1_GRP_SS0_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS0_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS1_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS2_IO {<Select>} \
CONFIG.PCW_SPI1_HIGHADDR {0xE0007FFF} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI1_SPI1_IO {<Select>} \
CONFIG.PCW_SPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
CONFIG.PCW_SPI_PERIPHERAL_VALID {0} \
CONFIG.PCW_S_AXI_ACP_ARUSER_VAL {31} \
CONFIG.PCW_S_AXI_ACP_AWUSER_VAL {31} \
CONFIG.PCW_S_AXI_ACP_FREQMHZ {10} \
CONFIG.PCW_S_AXI_ACP_ID_WIDTH {3} \
CONFIG.PCW_S_AXI_GP0_FREQMHZ {10} \
CONFIG.PCW_S_AXI_GP0_ID_WIDTH {6} \
CONFIG.PCW_S_AXI_GP1_FREQMHZ {10} \
CONFIG.PCW_S_AXI_GP1_ID_WIDTH {6} \
CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {32} \
CONFIG.PCW_S_AXI_HP0_FREQMHZ {142} \
CONFIG.PCW_S_AXI_HP0_ID_WIDTH {6} \
CONFIG.PCW_S_AXI_HP1_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP1_FREQMHZ {10} \
CONFIG.PCW_S_AXI_HP1_ID_WIDTH {6} \
CONFIG.PCW_S_AXI_HP2_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP2_FREQMHZ {10} \
CONFIG.PCW_S_AXI_HP2_ID_WIDTH {6} \
CONFIG.PCW_S_AXI_HP3_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP3_FREQMHZ {10} \
CONFIG.PCW_S_AXI_HP3_ID_WIDTH {6} \
CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_TRACE_BUFFER_CLOCK_DELAY {12} \
CONFIG.PCW_TRACE_BUFFER_FIFO_SIZE {128} \
CONFIG.PCW_TRACE_GRP_16BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_16BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_2BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_2BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_32BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_32BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_4BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_4BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_8BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_8BIT_IO {<Select>} \
CONFIG.PCW_TRACE_INTERNAL_WIDTH {2} \
CONFIG.PCW_TRACE_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TRACE_PIPELINE_WIDTH {8} \
CONFIG.PCW_TRACE_TRACE_IO {<Select>} \
CONFIG.PCW_TTC0_BASEADDR {0xE0104000} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_HIGHADDR {0xE0104fff} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
CONFIG.PCW_TTC1_BASEADDR {0xE0105000} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_HIGHADDR {0xE0105fff} \
CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TTC1_TTC1_IO {<Select>} \
CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UART0_BASEADDR {0xE0000000} \
CONFIG.PCW_UART0_BAUD_RATE {115200} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
CONFIG.PCW_UART0_GRP_FULL_IO {<Select>} \
CONFIG.PCW_UART0_HIGHADDR {0xE0000FFF} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_UART0_UART0_IO {<Select>} \
CONFIG.PCW_UART1_BASEADDR {0xE0001000} \
CONFIG.PCW_UART1_BAUD_RATE {115200} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
CONFIG.PCW_UART1_GRP_FULL_IO {<Select>} \
CONFIG.PCW_UART1_HIGHADDR {0xE0001FFF} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {40} \
CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} \
CONFIG.PCW_UIPARAM_DDR_AL {0} \
CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
CONFIG.PCW_UIPARAM_DDR_BL {8} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.469} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.468} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.270} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.288} \
CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {16 Bit} \
CONFIG.PCW_UIPARAM_DDR_CL {7} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {65.019} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {65.019} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {65.019} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {65.019} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} \
CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
CONFIG.PCW_UIPARAM_DDR_CWL {5.000000} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {73.263} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {68.4725} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {73.388} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {71.086} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {66.794} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {108.7385} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.059} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.063} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.404} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.362} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {63.860} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {64.1705} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {63.850} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {63.686} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {68.46} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {105.4895} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333313} \
CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} \
CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {Custom} \
CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1600K} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_UIPARAM_DDR_T_FAW {40} \
CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35} \
CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
CONFIG.PCW_UIPARAM_DDR_T_RCD {11} \
CONFIG.PCW_UIPARAM_DDR_T_RP {11} \
CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
CONFIG.PCW_UIPARAM_GENERATE_SUMMARY {NONE} \
CONFIG.PCW_USB0_BASEADDR {0xE0102000} \
CONFIG.PCW_USB0_HIGHADDR {0xE0102fff} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB0_RESET_ENABLE {0} \
CONFIG.PCW_USB0_RESET_IO {<Select>} \
CONFIG.PCW_USB0_USB0_IO {<Select>} \
CONFIG.PCW_USB1_BASEADDR {0xE0103000} \
CONFIG.PCW_USB1_HIGHADDR {0xE0103fff} \
CONFIG.PCW_USB1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB1_RESET_ENABLE {0} \
CONFIG.PCW_USB1_RESET_IO {<Select>} \
CONFIG.PCW_USB1_USB1_IO {<Select>} \
CONFIG.PCW_USB_RESET_ENABLE {0} \
CONFIG.PCW_USB_RESET_POLARITY {Active Low} \
CONFIG.PCW_USB_RESET_SELECT {<Select>} \
CONFIG.PCW_USE_AXI_FABRIC_IDLE {0} \
CONFIG.PCW_USE_AXI_NONSECURE {0} \
CONFIG.PCW_USE_CORESIGHT {0} \
CONFIG.PCW_USE_CROSS_TRIGGER {1} \
CONFIG.PCW_USE_CR_FABRIC {1} \
CONFIG.PCW_USE_DDR_BYPASS {0} \
CONFIG.PCW_USE_DEBUG {0} \
CONFIG.PCW_USE_DEFAULT_ACP_USER_VAL {0} \
CONFIG.PCW_USE_DMA0 {0} \
CONFIG.PCW_USE_DMA1 {0} \
CONFIG.PCW_USE_DMA2 {0} \
CONFIG.PCW_USE_DMA3 {0} \
CONFIG.PCW_USE_EXPANDED_IOP {0} \
CONFIG.PCW_USE_EXPANDED_PS_SLCR_REGISTERS {0} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_HIGH_OCM {0} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_M_AXI_GP1 {0} \
CONFIG.PCW_USE_PROC_EVENT_BUS {0} \
CONFIG.PCW_USE_PS_SLCR_REGISTERS {0} \
CONFIG.PCW_USE_S_AXI_ACP {0} \
CONFIG.PCW_USE_S_AXI_GP0 {0} \
CONFIG.PCW_USE_S_AXI_GP1 {0} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {0} \
CONFIG.PCW_USE_S_AXI_HP2 {0} \
CONFIG.PCW_USE_S_AXI_HP3 {0} \
CONFIG.PCW_USE_TRACE {0} \
CONFIG.PCW_USE_TRACE_DATA_EDGE_DETECTOR {0} \
CONFIG.PCW_VALUE_SILVERSION {3} \
CONFIG.PCW_WDT_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_WDT_WDT_IO {<Select>} \
 ] $processing_system7_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.IN0_WIDTH {1} \
CONFIG.IN1_WIDTH {1} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins axi_quad_spi_0/AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins image_capture_manager_0/s00_axi]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins frequency_analyzer_manager_0/s00_axi]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_interconnect_0/M03_AXI] [get_bd_intf_pins frequency_analyzer_manager_1/s00_axi]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins axi_interconnect_0/M04_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net LINESCANNER0_DATA_1 [get_bd_ports LINESCANNER0_DATA] [get_bd_pins linescanner_image_capture_unit_0/data]
  connect_bd_net -net LINESCANNER0_END_ADC_1 [get_bd_ports LINESCANNER0_END_ADC] [get_bd_pins linescanner_image_capture_unit_0/end_adc]
  connect_bd_net -net LINESCANNER0_LVAL_1 [get_bd_ports LINESCANNER0_LVAL] [get_bd_pins linescanner_image_capture_unit_0/lval]
  connect_bd_net -net LINESCANNER0_PIXEL_CLOCK_1 [get_bd_ports LINESCANNER0_PIXEL_CLOCK] [get_bd_pins linescanner_image_capture_unit_0/pixel_clock]
  connect_bd_net -net LINESCANNER1_DATA_1 [get_bd_ports LINESCANNER1_DATA] [get_bd_pins linescanner_image_capture_unit_1/data]
  connect_bd_net -net LINESCANNER1_END_ADC_1 [get_bd_ports LINESCANNER1_END_ADC] [get_bd_pins linescanner_image_capture_unit_1/end_adc]
  connect_bd_net -net LINESCANNER1_LVAL_1 [get_bd_ports LINESCANNER1_LVAL] [get_bd_pins linescanner_image_capture_unit_1/lval]
  connect_bd_net -net LINESCANNER1_PIXEL_CLOCK_1 [get_bd_ports LINESCANNER1_PIXEL_CLOCK] [get_bd_pins linescanner_image_capture_unit_1/pixel_clock]
  connect_bd_net -net LINESCANNER_MISO_1 [get_bd_ports LINESCANNER_MISO] [get_bd_pins axi_quad_spi_0/io1_i]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets LINESCANNER_MISO_1]
  connect_bd_net -net axi_quad_spi_0_io0_o [get_bd_ports LINESCANNER_MOSI] [get_bd_pins axi_quad_spi_0/io0_o]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets axi_quad_spi_0_io0_o]
  connect_bd_net -net axi_quad_spi_0_sck_o [get_bd_ports LINESCANNER_CLK] [get_bd_pins axi_quad_spi_0/sck_o]
  connect_bd_net -net axi_quad_spi_0_ss_o [get_bd_ports LINESCANNER_CS] [get_bd_pins axi_quad_spi_0/ss_o]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets axi_quad_spi_0_ss_o]
  connect_bd_net -net clock_divider_0_output_clock [get_bd_pins linescanner_image_capture_unit_0/main_clock_source] [get_bd_pins linescanner_image_capture_unit_1/main_clock_source] [get_bd_pins processing_system7_0/FCLK_CLK1]
  connect_bd_net -net frequency_analyzer_manager_0_irq [get_bd_pins frequency_analyzer_manager_1/irq] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net frequency_analyzer_manager_1_irq [get_bd_pins frequency_analyzer_manager_0/irq] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net frequency_analyzer_synch_0_start_analyzer_0 [get_bd_pins frequency_analyzer_manager_0/start] [get_bd_pins frequency_analyzer_synch_0/start_analyzer_0]
  connect_bd_net -net frequency_analyzer_synch_0_start_analyzer_1 [get_bd_pins frequency_analyzer_manager_1/start] [get_bd_pins frequency_analyzer_synch_0/start_analyzer_1]
  connect_bd_net -net frequency_analyzer_synch_0_stop_analyzer_0 [get_bd_pins frequency_analyzer_manager_0/stop] [get_bd_pins frequency_analyzer_synch_0/stop_analyzer_0]
  connect_bd_net -net frequency_analyzer_synch_0_stop_analyzer_1 [get_bd_pins frequency_analyzer_manager_1/stop] [get_bd_pins frequency_analyzer_synch_0/stop_analyzer_1]
  connect_bd_net -net image_capture_manager_0_clear_memory [get_bd_pins frequency_analyzer_manager_0/clear] [get_bd_pins frequency_analyzer_manager_1/clear] [get_bd_pins image_capture_manager_0/clear_memory]
  connect_bd_net -net image_capture_manager_0_image_capture_enabled [get_bd_pins frequency_analyzer_synch_0/enable] [get_bd_pins image_capture_manager_0/image_capture_enabled] [get_bd_pins linescanner_image_capture_unit_0/enable] [get_bd_pins linescanner_image_capture_unit_1/enable]
  connect_bd_net -net linescanner_image_capture_unit_0_load_pulse [get_bd_ports LINESCANNER0_LOAD_PULSE] [get_bd_pins linescanner_image_capture_unit_0/load_pulse]
  connect_bd_net -net linescanner_image_capture_unit_0_main_clock [get_bd_ports LINESCANNER0_MAIN_CLOCK] [get_bd_pins linescanner_image_capture_unit_0/main_clock]
  connect_bd_net -net linescanner_image_capture_unit_0_pixel_captured [get_bd_pins frequency_analyzer_manager_0/pixel_clock] [get_bd_pins linescanner_image_capture_unit_0/pixel_captured]
  connect_bd_net -net linescanner_image_capture_unit_0_pixel_data [get_bd_pins frequency_analyzer_manager_0/data] [get_bd_pins linescanner_image_capture_unit_0/pixel_data]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets linescanner_image_capture_unit_0_pixel_data]
  connect_bd_net -net linescanner_image_capture_unit_0_rst_cds [get_bd_ports LINESCANNER0_RST_CDS] [get_bd_pins linescanner_image_capture_unit_0/rst_cds]
  connect_bd_net -net linescanner_image_capture_unit_0_rst_cvc [get_bd_ports LINESCANNER0_RST_CVC] [get_bd_pins linescanner_image_capture_unit_0/rst_cvc]
  connect_bd_net -net linescanner_image_capture_unit_0_sample [get_bd_ports LINESCANNER0_SAMPLE] [get_bd_pins linescanner_image_capture_unit_0/sample]
  connect_bd_net -net linescanner_image_capture_unit_1_load_pulse [get_bd_ports LINESCANNER1_LOAD_PULSE] [get_bd_pins linescanner_image_capture_unit_1/load_pulse]
  connect_bd_net -net linescanner_image_capture_unit_1_main_clock [get_bd_ports LINESCANNER1_MAIN_CLOCK] [get_bd_pins linescanner_image_capture_unit_1/main_clock]
  connect_bd_net -net linescanner_image_capture_unit_1_pixel_captured [get_bd_pins frequency_analyzer_manager_1/pixel_clock] [get_bd_pins linescanner_image_capture_unit_1/pixel_captured]
  connect_bd_net -net linescanner_image_capture_unit_1_pixel_data [get_bd_pins frequency_analyzer_manager_1/data] [get_bd_pins linescanner_image_capture_unit_1/pixel_data]
  connect_bd_net -net linescanner_image_capture_unit_1_rst_cds [get_bd_ports LINESCANNER1_RST_CDS] [get_bd_pins linescanner_image_capture_unit_1/rst_cds]
  connect_bd_net -net linescanner_image_capture_unit_1_rst_cvc [get_bd_ports LINESCANNER1_RST_CVC] [get_bd_pins linescanner_image_capture_unit_1/rst_cvc]
  connect_bd_net -net linescanner_image_capture_unit_1_sample [get_bd_ports LINESCANNER1_SAMPLE] [get_bd_pins linescanner_image_capture_unit_1/sample]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_ports LINESCANNER0_N_RESET] [get_bd_ports LINESCANNER1_N_RESET] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_quad_spi_0/s_axi_aresetn] [get_bd_pins frequency_analyzer_manager_0/s00_axi_aresetn] [get_bd_pins frequency_analyzer_manager_1/s00_axi_aresetn] [get_bd_pins frequency_analyzer_synch_0/reset] [get_bd_pins image_capture_manager_0/s00_axi_aresetn] [get_bd_pins linescanner_image_capture_unit_0/n_reset] [get_bd_pins linescanner_image_capture_unit_1/n_reset] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins frequency_analyzer_manager_0/s00_axi_aclk] [get_bd_pins frequency_analyzer_manager_1/s00_axi_aclk] [get_bd_pins frequency_analyzer_synch_0/clock] [get_bd_pins image_capture_manager_0/s00_axi_aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00001000 -offset 0x41E00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs frequency_analyzer_manager_0/s00_axi/reg0] SEG_frequency_analyzer_manager_0_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs frequency_analyzer_manager_1/s00_axi/reg0] SEG_frequency_analyzer_manager_1_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs image_capture_manager_0/s00_axi/reg0] SEG_image_capture_manager_0_reg0
  create_bd_addr_seg -range 0x10000000 -offset 0x50000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   commentid: "",
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port LINESCANNER0_END_ADC -pg 1 -y -620 -defaultsOSRD
preplace port DDR -pg 1 -y -760 -defaultsOSRD
preplace port LINESCANNER1_MAIN_CLOCK -pg 1 -y -340 -defaultsOSRD -left
preplace port LINESCANNER1_RST_CVC -pg 1 -y -280 -defaultsOSRD -left
preplace port LINESCANNER0_LVAL -pg 1 -y -600 -defaultsOSRD
preplace port LINESCANNER1_END_ADC -pg 1 -y -170 -defaultsOSRD
preplace port LINESCANNER_MOSI -pg 1 -y -90 -defaultsOSRD
preplace port LINESCANNER0_RST_CDS -pg 1 -y -730 -defaultsOSRD -left
preplace port LINESCANNER1_PIXEL_CLOCK -pg 1 -y -130 -defaultsOSRD
preplace port LINESCANNER1_LVAL -pg 1 -y -150 -defaultsOSRD
preplace port LINESCANNER0_LOAD_PULSE -pg 1 -y -790 -defaultsOSRD -left
preplace port LINESCANNER1_SAMPLE -pg 1 -y -320 -defaultsOSRD -left
preplace port LINESCANNER_CLK -pg 1 -y 30 -defaultsOSRD
preplace port LINESCANNER0_SAMPLE -pg 1 -y -750 -defaultsOSRD -left
preplace port FIXED_IO -pg 1 -y -740 -defaultsOSRD
preplace port LINESCANNER_MISO -pg 1 -y -110 -defaultsOSRD -right
preplace port LINESCANNER1_LOAD_PULSE -pg 1 -y -360 -defaultsOSRD -left
preplace port LINESCANNER1_RST_CDS -pg 1 -y -300 -defaultsOSRD -left
preplace port LINESCANNER0_RST_CVC -pg 1 -y -710 -defaultsOSRD -left
preplace port LINESCANNER0_MAIN_CLOCK -pg 1 -y -770 -defaultsOSRD -left
preplace port LINESCANNER0_PIXEL_CLOCK -pg 1 -y -580 -defaultsOSRD
preplace portBus LINESCANNER_CS -pg 1 -y 90 -defaultsOSRD
preplace portBus LINESCANNER0_DATA -pg 1 -y -640 -defaultsOSRD
preplace portBus LINESCANNER1_N_RESET -pg 1 -y -350 -defaultsOSRD
preplace portBus LINESCANNER1_DATA -pg 1 -y -190 -defaultsOSRD
preplace portBus LINESCANNER0_N_RESET -pg 1 -y -370 -defaultsOSRD
preplace inst frequency_analyzer_manager_1 -pg 1 -lvl 3 -y -230 -defaultsOSRD
preplace inst linescanner_image_capture_unit_0 -pg 1 -lvl 1 -y -620 -defaultsOSRD
preplace inst linescanner_image_capture_unit_1 -pg 1 -lvl 1 -y -250 -defaultsOSRD
preplace inst frequency_analyzer_synch_0 -pg 1 -lvl 2 -y -410 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 4 -y -730 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 5 -y -400 -defaultsOSRD
preplace inst image_capture_manager_0 -pg 1 -lvl 4 -y -24 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 4 -y -440 -defaultsOSRD
preplace inst frequency_analyzer_manager_0 -pg 1 -lvl 3 -y -660 -defaultsOSRD
preplace inst axi_quad_spi_0 -pg 1 -lvl 5 -y 0 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 5 -y -680 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 5 1 NJ
preplace netloc linescanner_image_capture_unit_1_main_clock 1 0 2 NJ -370 -270
preplace netloc linescanner_image_capture_unit_1_sample 1 0 2 NJ -130 -290
preplace netloc clock_divider_0_output_clock 1 0 6 -670 -850 NJ -850 NJ -850 NJ -850 NJ -850 1660
preplace netloc linescanner_image_capture_unit_1_rst_cds 1 0 2 NJ -360 -290
preplace netloc LINESCANNER1_LVAL_1 1 0 1 -680
preplace netloc linescanner_image_capture_unit_0_rst_cds 1 0 2 NJ -730 -290
preplace netloc linescanner_image_capture_unit_0_rst_cvc 1 0 2 NJ -760 -280
preplace netloc image_capture_manager_0_image_capture_enabled 1 0 5 -650 -390 NJ -330 NJ -350 370 -200 1130
preplace netloc image_capture_manager_0_clear_memory 1 2 3 140 -360 NJ -210 1140
preplace netloc LINESCANNER1_END_ADC_1 1 0 1 -690
preplace netloc frequency_analyzer_manager_1_irq 1 3 1 NJ
preplace netloc axi_quad_spi_0_ss_o 1 5 1 1640
preplace netloc processing_system7_0_M_AXI_GP0 1 3 3 NJ -870 NJ -870 1650
preplace netloc LINESCANNER_MISO_1 1 5 1 1650
preplace netloc axi_interconnect_0_M02_AXI 1 2 3 80 -810 NJ -810 1150
preplace netloc linescanner_image_capture_unit_0_load_pulse 1 0 2 NJ -790 -250
preplace netloc linescanner_image_capture_unit_0_main_clock 1 0 2 NJ -770 -260
preplace netloc frequency_analyzer_manager_0_irq 1 3 1 NJ
preplace netloc processing_system7_0_FCLK_RESET0_N 1 4 2 1190 -520 1640
preplace netloc LINESCANNER1_PIXEL_CLOCK_1 1 0 1 -720
preplace netloc linescanner_image_capture_unit_0_sample 1 0 2 NJ -750 -270
preplace netloc axi_quad_spi_0_io0_o 1 5 1 1670
preplace netloc axi_interconnect_0_M04_AXI 1 4 1 1170
preplace netloc axi_quad_spi_0_sck_o 1 5 1 1660
preplace netloc xlconcat_0_dout 1 4 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 5 1 NJ
preplace netloc linescanner_image_capture_unit_1_pixel_captured 1 1 2 NJ -260 N
preplace netloc linescanner_image_capture_unit_1_pixel_data 1 1 2 NJ -280 N
preplace netloc axi_interconnect_0_M00_AXI 1 4 1 1160
preplace netloc linescanner_image_capture_unit_0_pixel_captured 1 1 2 -230 -690 NJ
preplace netloc frequency_analyzer_synch_0_start_analyzer_0 1 2 1 80
preplace netloc linescanner_image_capture_unit_1_rst_cvc 1 0 2 NJ -140 -280
preplace netloc LINESCANNER0_END_ADC_1 1 0 1 -710
preplace netloc LINESCANNER0_DATA_1 1 0 1 -730
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 0 6 -660 -490 -280 -490 NJ -540 410 -190 NJ -310 1660
preplace netloc axi_interconnect_0_M01_AXI 1 3 2 420 -670 1130
preplace netloc frequency_analyzer_synch_0_start_analyzer_1 1 2 1 90
preplace netloc frequency_analyzer_synch_0_stop_analyzer_0 1 2 1 90
preplace netloc processing_system7_0_FCLK_CLK0 1 1 5 NJ -510 NJ -530 380 -820 1180 -840 1640
preplace netloc frequency_analyzer_synch_0_stop_analyzer_1 1 2 1 80
preplace netloc linescanner_image_capture_unit_0_pixel_data 1 1 2 -240 -710 NJ
preplace netloc linescanner_image_capture_unit_1_load_pulse 1 0 2 NJ -380 -260
preplace netloc LINESCANNER1_DATA_1 1 0 1 -700
preplace netloc axi_interconnect_0_M03_AXI 1 2 3 130 -790 NJ -790 1140
preplace netloc processing_system7_0_FCLK_CLK2 1 4 2 1200 -490 1650
preplace netloc LINESCANNER0_PIXEL_CLOCK_1 1 0 1 -680
preplace netloc LINESCANNER0_LVAL_1 1 0 1 -700
levelinfo -pg 1 -750 -440 -46 251 968 1430 1710 -top -890 -bot 110
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


