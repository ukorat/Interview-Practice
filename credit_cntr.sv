module credit_cntr
#(parameter BW = 4)
(

input logic       clk,
input logic       rst_b,
input logic       load_first_credits,
input logic [BW-1:0] first_credits,
input logic       credit_in,
input logic       credit_out,

output logic      no_credits
);


logic [BW-1:0] credit_reg;
logic [BW-1:0] max_credit;

logic credit_in_pre;
logic credit_out_pre;

assign credit_in_pre  = credit_in && (credit_reg != max_credit) ; 
assign credit_out_pre = credit_out && (credit_reg != '0 );

assign no_credits = (credit_reg == '0) ;


always_ff @(posedge clk or negedge rst_b) begin
    unique casez ({!rst_b, load_first_credits})
        2'b1? : max_credit <= '0;
        2'b01 : max_credit <= load_first_credits;
        2'b00 : max_credit <= max_credit;
        default : max_credit <= 'x;
    endcase 
end

always_ff @(posedge clk or negedge rst_b) begin
    unique casez ({(!rst_b | (max_credit == '0)), credit_out_pre, credit_in_pre})
        3'b1?? : credit_reg <= '0;
        3'b010 : credit_reg <= credit_reg - 1'b1;
        3'b001 : credit_reg <= credit_reg + 1'b1;
        3'b000, 
        3'b011 : credit_reg <= credit_reg;
        default : credit_reg <= 'x;
    endcase
end

endmodule //credit_cntr
