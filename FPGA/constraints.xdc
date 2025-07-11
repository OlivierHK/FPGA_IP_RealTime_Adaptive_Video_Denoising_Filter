##########################################################################################
##c onstraints set for synth, and implementation. Targeting Vivado IDE.
## Module is set as an IO or Out-Of-Context for lone implementation and simulation.
##########################################################################################



##########################################################################################
#input clock constraint. Need create clock of 100MHz.
create_clock -period 10.000 -name clk [get_ports clk]
set_input_jitter [get_clocks -of_objects [get_ports clk]] 0.000


## input delay of the signals
set_input_delay  -clock [get_clocks clk] 5 [get_ports rst]

set_input_delay  -clock [get_clocks clk] 5 [get_ports in_stream0]
set_input_delay  -clock [get_clocks clk] 5 [get_ports in_stream1]
set_input_delay  -clock [get_clocks clk] 5 [get_ports in_stream2]
set_input_delay  -clock [get_clocks clk] 5 [get_ports in_stream3]
set_input_delay  -clock [get_clocks clk] 5 [get_ports in_stream4]

## output delsy of the signals
set_output_delay -clock [get_clocks clk] 5 [get_ports pixel     ]
set_output_delay -clock [get_clocks clk] 5 [get_ports controle  ]