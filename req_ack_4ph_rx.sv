module req_ack_4ph_rx
	# ( parameter DW = 8)
(
	input				clk_rx,
	input				rst_b,

	input				rdy,
	output logic			val,
	input [DW-1:0]		din,

	output logic			ack,
	input				req,	
  output logic [DW-1:0]	dout
);

//Synchronize req with clk_rx

  logic [1:0] req_r;
  
  always_ff @(posedge clk_rx or negedge rst_b) begin
    if (!rst_b) req_r <= 2'b00;
    else        req_r <= {req_r[0], req};
  end
  
  assign req_s = req_r[1]; //Synchronized req
  
  //val generation
  always_ff @(posedge clk_rx or negedge rst_b) begin
    if (!rst_b)             val <= 1'b0;
    else if (req_s && !ack) val <= 1'b1; //!ack is necessary to make sure that val goes high only until ack is not received
    else if (val && rdy)    val <= 1'b0; 
		else                    val <= val;
  end
	
  always_ff @(posedge clk_rx or negedge rst_b) begin
    if (!rst2_b)             ack <= '0;
    else if (!req_s)         ack <= '0; //
    else if (val && rdy)     ack <= '1;
    else                     ack <= ack;
  end
  
 always_ff @(posedge clk_rx)
   dout <= din;
	
endmodule
