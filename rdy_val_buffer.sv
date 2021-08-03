
module rdy_val_buffer
#(parameter BW = 8)

(
input                clk, rst_b
input logic          t_val,
input logic [BW-1:0] t_data,
output logic         b_rdy,

input logic           r_rdy,
output logic          b_val,
output logic [BW-1:0] b_data
);

logic full;
logic [BW-1:0] buf_data;

logic b_valid_pre;
logic [BW-1:0] b_data_pre;

always_comb b_rdy = !full;

always_comb b_val = full | b_valid_pre;
always_comb b_data = full ? buf_data : b_data_pre;

always @(posedge clk or negedge rst_b) begin
	if (!rst_b) begin
		full <= 1'b0;
	end
	else begin
		if (b_rdy) begin
			b_valid_pre <= t_val;
			b_data_pre <= t_data;
			if (!r_rdy) begin
				buf_data <= b_data_pre;
				full <= b_valid_pre;
			end
		end
		if (r_rdy) begin
			full <= 1'b0;
		end
	end
end

endmodule
