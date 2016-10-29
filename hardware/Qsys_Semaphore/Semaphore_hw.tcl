# TCL File Generated by Component Editor 13.0sp1
# Sat Oct 29 14:21:14 BRST 2016
# DO NOT MODIFY


# 
# Semaphore "Semaphore" v1.0
#  2016.10.29.14:21:14
# Semaphore for thread synchronization
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module Semaphore
# 
set_module_property DESCRIPTION "Semaphore for thread synchronization"
set_module_property NAME Semaphore
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "OS Components"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME Semaphore
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL Qsys_Semaphore
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file avalon_adapter.vhd VHDL PATH semaphore/avalon_adapter.vhd
add_fileset_file fifo.vhd VHDL PATH semaphore/fifo.vhd
add_fileset_file Qsys_Semaphore.vhd VHDL PATH semaphore/Qsys_Semaphore.vhd TOP_LEVEL_FILE
add_fileset_file Semaphore.vhd VHDL PATH semaphore/Semaphore.vhd


# 
# parameters
# 
add_parameter MAX_SEMAPHORES INTEGER 8
set_parameter_property MAX_SEMAPHORES DEFAULT_VALUE 8
set_parameter_property MAX_SEMAPHORES DISPLAY_NAME MAX_SEMAPHORES
set_parameter_property MAX_SEMAPHORES TYPE INTEGER
set_parameter_property MAX_SEMAPHORES UNITS None
set_parameter_property MAX_SEMAPHORES ALLOWED_RANGES -2147483648:2147483647
set_parameter_property MAX_SEMAPHORES HDL_PARAMETER true
add_parameter SEM_FIFO_SIZE INTEGER 4
set_parameter_property SEM_FIFO_SIZE DEFAULT_VALUE 4
set_parameter_property SEM_FIFO_SIZE DISPLAY_NAME SEM_FIFO_SIZE
set_parameter_property SEM_FIFO_SIZE TYPE INTEGER
set_parameter_property SEM_FIFO_SIZE UNITS None
set_parameter_property SEM_FIFO_SIZE ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SEM_FIFO_SIZE HDL_PARAMETER true
add_parameter COUNTER_WIDTH INTEGER 8
set_parameter_property COUNTER_WIDTH DEFAULT_VALUE 8
set_parameter_property COUNTER_WIDTH DISPLAY_NAME COUNTER_WIDTH
set_parameter_property COUNTER_WIDTH TYPE INTEGER
set_parameter_property COUNTER_WIDTH UNITS None
set_parameter_property COUNTER_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property COUNTER_WIDTH HDL_PARAMETER true
add_parameter ADDRESS_WIDTH INTEGER 32
set_parameter_property ADDRESS_WIDTH DEFAULT_VALUE 32
set_parameter_property ADDRESS_WIDTH DISPLAY_NAME ADDRESS_WIDTH
set_parameter_property ADDRESS_WIDTH TYPE INTEGER
set_parameter_property ADDRESS_WIDTH UNITS None
set_parameter_property ADDRESS_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ADDRESS_WIDTH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock
set_interface_property avalon_slave associatedReset reset_n
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave read read Input 1
add_interface_port avalon_slave write write Input 1
add_interface_port avalon_slave chipselect chipselect Input 1
add_interface_port avalon_slave address address Input 2
add_interface_port avalon_slave writedata writedata Input address_width
add_interface_port avalon_slave readdata readdata Output address_width
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clock clk Input 1


# 
# connection point reset_n
# 
add_interface reset_n reset end
set_interface_property reset_n associatedClock clock
set_interface_property reset_n synchronousEdges DEASSERT
set_interface_property reset_n ENABLED true
set_interface_property reset_n EXPORT_OF ""
set_interface_property reset_n PORT_NAME_MAP ""
set_interface_property reset_n SVD_ADDRESS_GROUP ""

add_interface_port reset_n resetn reset_n Input 1


# 
# connection point led_conduit
# 
add_interface led_conduit conduit end
set_interface_property led_conduit associatedClock clock
set_interface_property led_conduit associatedReset reset_n
set_interface_property led_conduit ENABLED true
set_interface_property led_conduit EXPORT_OF ""
set_interface_property led_conduit PORT_NAME_MAP ""
set_interface_property led_conduit SVD_ADDRESS_GROUP ""

add_interface_port led_conduit Led_export export Output 10


# 
# connection point display_conduit
# 
add_interface display_conduit conduit end
set_interface_property display_conduit associatedClock clock
set_interface_property display_conduit associatedReset reset_n
set_interface_property display_conduit ENABLED true
set_interface_property display_conduit EXPORT_OF ""
set_interface_property display_conduit PORT_NAME_MAP ""
set_interface_property display_conduit SVD_ADDRESS_GROUP ""

add_interface_port display_conduit Q_export export Output address_width

