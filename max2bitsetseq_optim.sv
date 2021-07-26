module max2bitsetseq_optim

#(parameter BW_NUM = 4)
( 
input clk, rst_b,
  output logic [3:0] outnum
);

localparam BW_SHLOC = $clog2(BW_NUM);

logic [BW_SHLOC-1:0] left, right;
logic [BW_SHLOC-1:0] left_next, right_next;


logic [1:0] left, right;
logic [1:0] left_next, right_next;

always_comb right_next = (right == left-1) ? 2'b00 : right + 1'b1;
always_comb left_next =  (right == left-1) ? (left == BW_NUM-1) ? 2'b01 : left + 1'b1 
                                           : left;


always @(posedge clk or negedge rst_b) begin
	if (!rst_b) begin
		left <= 2'b01;
		right <= 2'b00;
	end
	else begin
        left <= left_next;
        right <= right_next;
    end
end


always_comb outnum = (1 << left) | (1 << right);

endmodule //max2bitsetseq_optim.sv
