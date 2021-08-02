module req_ack_4ph_tx
	# ( parameter DW = 8)
(
	input				clk_tx, //tx_clock
	input				rst_b,	

	input	logic 			val,
	output logic			rdy,
	input logic [DW-1:0]		din,

	output logic req,
	input	 logic		ack,	
	output logic [DW-1:0]	dout
);

  logic [1:0] ack_r;
	
//Synchronzing ack with Tx clock
  always_ff @(posedge clk_tx or negedge rst_b) begin
    if (!rst_b) ack_r <= 2'b00; //used 2 FF chained sync cell
    else ack_r <= {ack_r[0], ack};
  end
	
  always_ff @(posedge clk_tx or negedge rst_b) begin
    if (!rst_b)         req <= 1'b0;
    else if (val & rdy) req <= 1'b1;
    else if (ack) 	req <= 1'b0;
    else                req <= req;
    
    assign rdy = ! (req | acq);

    always_ff @(posedge clk_tx)
      if (val & rdy) 	dout <= din;
	
endmodule
