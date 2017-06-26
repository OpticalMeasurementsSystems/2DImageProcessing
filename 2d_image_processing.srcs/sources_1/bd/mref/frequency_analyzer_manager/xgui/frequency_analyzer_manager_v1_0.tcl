# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CLOCK_FREQUENCY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_FREQUENCY_DEVIATION" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_PIXEL0_INDEX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_PIXEL1_INDEX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_PIXEL2_INDEX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT0_FREQUENCY0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT0_FREQUENCY1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT1_FREQUENCY0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT1_FREQUENCY1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT2_FREQUENCY0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT2_FREQUENCY1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_POINT_WIDTH_PIXELS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_THRESHOLD_VALUE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TAP_COLOR_PIXELS_COUNT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TAP_DARK_PIXELS_COUNT" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLOCK_FREQUENCY { PARAM_VALUE.CLOCK_FREQUENCY } {
	# Procedure called to update CLOCK_FREQUENCY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLOCK_FREQUENCY { PARAM_VALUE.CLOCK_FREQUENCY } {
	# Procedure called to validate CLOCK_FREQUENCY
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION { PARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION } {
	# Procedure called to update DEFAULT_FREQUENCY_DEVIATION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION { PARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION } {
	# Procedure called to validate DEFAULT_FREQUENCY_DEVIATION
	return true
}

proc update_PARAM_VALUE.DEFAULT_PIXEL0_INDEX { PARAM_VALUE.DEFAULT_PIXEL0_INDEX } {
	# Procedure called to update DEFAULT_PIXEL0_INDEX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_PIXEL0_INDEX { PARAM_VALUE.DEFAULT_PIXEL0_INDEX } {
	# Procedure called to validate DEFAULT_PIXEL0_INDEX
	return true
}

proc update_PARAM_VALUE.DEFAULT_PIXEL1_INDEX { PARAM_VALUE.DEFAULT_PIXEL1_INDEX } {
	# Procedure called to update DEFAULT_PIXEL1_INDEX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_PIXEL1_INDEX { PARAM_VALUE.DEFAULT_PIXEL1_INDEX } {
	# Procedure called to validate DEFAULT_PIXEL1_INDEX
	return true
}

proc update_PARAM_VALUE.DEFAULT_PIXEL2_INDEX { PARAM_VALUE.DEFAULT_PIXEL2_INDEX } {
	# Procedure called to update DEFAULT_PIXEL2_INDEX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_PIXEL2_INDEX { PARAM_VALUE.DEFAULT_PIXEL2_INDEX } {
	# Procedure called to validate DEFAULT_PIXEL2_INDEX
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 { PARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 } {
	# Procedure called to update DEFAULT_POINT0_FREQUENCY0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 { PARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 } {
	# Procedure called to validate DEFAULT_POINT0_FREQUENCY0
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 { PARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 } {
	# Procedure called to update DEFAULT_POINT0_FREQUENCY1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 { PARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 } {
	# Procedure called to validate DEFAULT_POINT0_FREQUENCY1
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 { PARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 } {
	# Procedure called to update DEFAULT_POINT1_FREQUENCY0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 { PARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 } {
	# Procedure called to validate DEFAULT_POINT1_FREQUENCY0
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 { PARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 } {
	# Procedure called to update DEFAULT_POINT1_FREQUENCY1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 { PARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 } {
	# Procedure called to validate DEFAULT_POINT1_FREQUENCY1
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 { PARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 } {
	# Procedure called to update DEFAULT_POINT2_FREQUENCY0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 { PARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 } {
	# Procedure called to validate DEFAULT_POINT2_FREQUENCY0
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 { PARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 } {
	# Procedure called to update DEFAULT_POINT2_FREQUENCY1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 { PARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 } {
	# Procedure called to validate DEFAULT_POINT2_FREQUENCY1
	return true
}

proc update_PARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS { PARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS } {
	# Procedure called to update DEFAULT_POINT_WIDTH_PIXELS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS { PARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS } {
	# Procedure called to validate DEFAULT_POINT_WIDTH_PIXELS
	return true
}

proc update_PARAM_VALUE.DEFAULT_THRESHOLD_VALUE { PARAM_VALUE.DEFAULT_THRESHOLD_VALUE } {
	# Procedure called to update DEFAULT_THRESHOLD_VALUE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_THRESHOLD_VALUE { PARAM_VALUE.DEFAULT_THRESHOLD_VALUE } {
	# Procedure called to validate DEFAULT_THRESHOLD_VALUE
	return true
}

proc update_PARAM_VALUE.TAP_COLOR_PIXELS_COUNT { PARAM_VALUE.TAP_COLOR_PIXELS_COUNT } {
	# Procedure called to update TAP_COLOR_PIXELS_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TAP_COLOR_PIXELS_COUNT { PARAM_VALUE.TAP_COLOR_PIXELS_COUNT } {
	# Procedure called to validate TAP_COLOR_PIXELS_COUNT
	return true
}

proc update_PARAM_VALUE.TAP_DARK_PIXELS_COUNT { PARAM_VALUE.TAP_DARK_PIXELS_COUNT } {
	# Procedure called to update TAP_DARK_PIXELS_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TAP_DARK_PIXELS_COUNT { PARAM_VALUE.TAP_DARK_PIXELS_COUNT } {
	# Procedure called to validate TAP_DARK_PIXELS_COUNT
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.DEFAULT_PIXEL0_INDEX { MODELPARAM_VALUE.DEFAULT_PIXEL0_INDEX PARAM_VALUE.DEFAULT_PIXEL0_INDEX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_PIXEL0_INDEX}] ${MODELPARAM_VALUE.DEFAULT_PIXEL0_INDEX}
}

proc update_MODELPARAM_VALUE.DEFAULT_PIXEL1_INDEX { MODELPARAM_VALUE.DEFAULT_PIXEL1_INDEX PARAM_VALUE.DEFAULT_PIXEL1_INDEX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_PIXEL1_INDEX}] ${MODELPARAM_VALUE.DEFAULT_PIXEL1_INDEX}
}

proc update_MODELPARAM_VALUE.DEFAULT_PIXEL2_INDEX { MODELPARAM_VALUE.DEFAULT_PIXEL2_INDEX PARAM_VALUE.DEFAULT_PIXEL2_INDEX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_PIXEL2_INDEX}] ${MODELPARAM_VALUE.DEFAULT_PIXEL2_INDEX}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 { MODELPARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 PARAM_VALUE.DEFAULT_POINT0_FREQUENCY0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT0_FREQUENCY0}] ${MODELPARAM_VALUE.DEFAULT_POINT0_FREQUENCY0}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 { MODELPARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 PARAM_VALUE.DEFAULT_POINT0_FREQUENCY1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT0_FREQUENCY1}] ${MODELPARAM_VALUE.DEFAULT_POINT0_FREQUENCY1}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 { MODELPARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 PARAM_VALUE.DEFAULT_POINT1_FREQUENCY0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT1_FREQUENCY0}] ${MODELPARAM_VALUE.DEFAULT_POINT1_FREQUENCY0}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 { MODELPARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 PARAM_VALUE.DEFAULT_POINT1_FREQUENCY1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT1_FREQUENCY1}] ${MODELPARAM_VALUE.DEFAULT_POINT1_FREQUENCY1}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 { MODELPARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 PARAM_VALUE.DEFAULT_POINT2_FREQUENCY0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT2_FREQUENCY0}] ${MODELPARAM_VALUE.DEFAULT_POINT2_FREQUENCY0}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 { MODELPARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 PARAM_VALUE.DEFAULT_POINT2_FREQUENCY1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT2_FREQUENCY1}] ${MODELPARAM_VALUE.DEFAULT_POINT2_FREQUENCY1}
}

proc update_MODELPARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION { MODELPARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION PARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION}] ${MODELPARAM_VALUE.DEFAULT_FREQUENCY_DEVIATION}
}

proc update_MODELPARAM_VALUE.CLOCK_FREQUENCY { MODELPARAM_VALUE.CLOCK_FREQUENCY PARAM_VALUE.CLOCK_FREQUENCY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLOCK_FREQUENCY}] ${MODELPARAM_VALUE.CLOCK_FREQUENCY}
}

proc update_MODELPARAM_VALUE.DEFAULT_THRESHOLD_VALUE { MODELPARAM_VALUE.DEFAULT_THRESHOLD_VALUE PARAM_VALUE.DEFAULT_THRESHOLD_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_THRESHOLD_VALUE}] ${MODELPARAM_VALUE.DEFAULT_THRESHOLD_VALUE}
}

proc update_MODELPARAM_VALUE.TAP_DARK_PIXELS_COUNT { MODELPARAM_VALUE.TAP_DARK_PIXELS_COUNT PARAM_VALUE.TAP_DARK_PIXELS_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TAP_DARK_PIXELS_COUNT}] ${MODELPARAM_VALUE.TAP_DARK_PIXELS_COUNT}
}

proc update_MODELPARAM_VALUE.TAP_COLOR_PIXELS_COUNT { MODELPARAM_VALUE.TAP_COLOR_PIXELS_COUNT PARAM_VALUE.TAP_COLOR_PIXELS_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TAP_COLOR_PIXELS_COUNT}] ${MODELPARAM_VALUE.TAP_COLOR_PIXELS_COUNT}
}

proc update_MODELPARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS { MODELPARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS PARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS}] ${MODELPARAM_VALUE.DEFAULT_POINT_WIDTH_PIXELS}
}

