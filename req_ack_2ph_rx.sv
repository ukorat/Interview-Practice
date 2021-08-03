module req_ack_2ph_rx
  #(
    parameter DW = 16
  )
  (
    input logic clk_rx, rst_b,
    
    input  logic          rdy,
    output logic          val,
    output logic [DW-1:0] dout,
    
    input  logic          req,
    output logic          ack,
    input  logic [DW-1:0] din
  );
  
  //Synchronized req
  logic [2:0] req_r;
  logic       req_pulse;
  
  always_ff @(posedge clk_rx or negedge rst_b) begin
    if (!rst_b) req_r <= 3'b000;
    else req_r[2:0] <= {req_r[1:0], req};
  end
  
  assign req_pulse = ^req_r[2:1];
  
  always_ff @(posedge clk_rx or negedge rst_b) begin
    if (!rst_b)           val <= 1'b0;
    else if (req_pulse)   val <= 1'b1;
    else if (val && rdy)  val <= 1'b0;
    else                  val <= val;
  end
  
  always_ff @(posedge clk_rx or negedge rst_b) begin
    if (!rst_b)           ack <= 1'b0;
    else if (val && rdy)  ack <= ~ack;
    else                  ack <= ack;
  end
  
endmodule
  
