module indexofone

#(parameter BW = 8)
(
input clk, rst_b,
input in_vld,
input [BW-1:0] in1,
output logic out_vld,
output logic [$clog2(BW)-1:0] index

);

//1. sliding pointer to move to next index with one 
//2. based on current pointer set one hot vector
//3. use that one hot vector to give out the index, may be using simple encoder
// not optimized logic

typedef enum logic {s0 = 1'b0, s1 = 1'b1} state_t;

state_t state;

logic [BW-1:0] in1_reg, onehotvec;
logic [$clog2(BW)-1:0] index_pre;

always_ff @(posedge clk or negedge rst_b) begin
	if (!rst_b) begin
		state <= s0;
		out_vld <= 1'b0;
	end
	else begin
		case (state) 
		s0: begin
			if (in_vld) begin
				state <= s1;
				in1_reg <= in1;
			end
		end
		s1: begin
			in1_reg[index_pre] <= 1'b0;
			index <= index_pre;
			out_vld <= 1'b1;
            if (!(|onehotvec)) begin
				state <= s0;
				out_vld <= 1'b0;
			end
		end
		default: begin 
			state <= s0; out_vld <= 1'b0;
		end
		endcase
	end
end

genvar i;

generate
	assign onehotvec[0] = in1_reg[0];
	for ( i = 1; i < BW; i++) begin
		assign	onehotvec[i] = in1_reg[i] & (!(|in1_reg[i-1:0]));
	end
endgenerate

always_comb begin
	index_pre = '0;
	for (int j = 0; j < BW; j++) begin
		if (onehotvec[j]) 
			index_pre = j;
	end
end


endmodule //indexofone
