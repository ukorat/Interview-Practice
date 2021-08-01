module width_convert_hi2lo_rdy_val
  #(parameter TX_DW = 16,
    parameter RX_DW = 8
   )
( 
input logic clk, rst_b,

//Tx side

input logic          tx_valid,
  input logic [TX_DW-1:0] tx_data,
output logic         bx_rdy,

//Rx side

input logic              rx_rdy,
output logic             bx_valid,
  output logic [RX_DW-1:0] bx_data
);


logic [DW-1:0] tx_dataR;
localparam TOTAL_TRANS = TX_DW/RX_DW;
 
logic [$clog2(TOTAL_TRANS)-1:0] num_transfer;


// FSM Based Logic
  typedef enum {RECEIVE, SEND} state_t;
  
  state_t state;
  
  always_ff @(posedge clk or negedge rst_b) begin
    if (rst_b) begin
      bx_rdy <= 1'b1;
      bx_valid <= 1'b0;
      state <= RECEIVE;
      num_transfer <= '0;
    end
    else begin
      unique casez (state) 
        RECEIVE : begin
          if (tx_valid && bx_rdy) begin
            tx_dataR <= tx_data;
            state <= SEND;
            bx_valid <= 1'b1;
            bx_rdy <= 1'b0;
          end
          else begin
            state <= RECEIVE;
          end
        end
        
        SEND : begin
          if (num_transfer < TOTAL_TRANS-1 && rx_rdy) begin
              num_trasfer <= num_transfer + 1'b1;
          end
          else if (num_transfer == TOTAL_TRANS-1 && rx_rdy) begin
              state <= RECEIVE;
              num_trasfer <= '0;
              bx_valid <= 1'b0;
              bx_rdy <= 1'b1;
          end
          else state <= SEND;
        end
        default : state <= RECEIVE;
      endcase
    end
    
  end
  
  always_comb bx_data = tx_dataR[RX_DW*num_transfer +: RX_DW];

endmodule //
