module width_convert_hi2lo_rdy_val
#(parameter DW = 16)
( 

input logic clk, rst_b,

//Tx side

input logic          tx_valid,
input logic [DW-1:0] tx_data,
output logic         bx_rdy,

//Rx side

input logic              rx_rdy,
output logic             bx_valid,
output logic [(DW/2)-1:0] bx_data
);


logic [DW-1:0] tx_dataR;

//TX side


//Rx side


endmodule //
