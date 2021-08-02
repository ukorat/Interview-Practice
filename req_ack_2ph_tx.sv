module req_ack_2ph_tx

  #(
    parameter DW = 16
  )
  (
    input logic clk_tx, rst_b,
    
    input logic           val,
    input logic [DW-1:0]  din,
    output logic          rdy,
    
    input logic           ack,
    output logic          req,
    output logic [DW-1:0] dout
  );
  
  //Synchronize ack
  logic [2:0] ack_r, ack_pulse;
  
  always_ff @(posedge clk_tx or negedge rst_b) begin
    if (!rst_b) ack_r <= 3'b000;
    else        ack_r <= {ack_r[1:0], ack};
  end
  
  assign ack_pulse = ^ack_r[2:1]; //use to make ready high again
  
  always_ff @(posedge clk_tx or negedge rst_b) begin
    if (!rst_b)          req <= 1'b0;
    else if (val && rdy) req <= ~req;
    else                 req <= req;
  end
  
  always_ff @(posedge clk_tx or negedge rst_b) begin
    if (!rst_b)           rdy <= 1'b1;
    else if (val && rdy)  rdy <= 1'b0;
    else if (ack_pulse)   rdy <= 1'b1;
    else                  rdy <= rdy;
  end
  
  always_ff @(posedge clk_tx) begin
    if (val && rdy) dout <= din;
  end
    
  
  
  
