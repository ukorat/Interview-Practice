//shift add multiplier

module shiftaddmul

#(parameter BW = 4)

(
input clk, rstn,
input inval,
input [BW-1:0] inA,
input [BW-1:0] inB,
output logic [2*BW-1 :0] mulout,
output logic outval,
output logic mulStarted
);

// initialize pprod with multiplier
// based on the LSB, add Multiplicand and PP, then shift it 
// loop back based on BW
logic [BW:0] temp_reg;
logic [2*BW-1:0] temp_reg2;
logic [$clog2(BW)-1:0] counter;

logic [BW-1:0] inA_reg;

always_comb begin
	temp_reg = inA_reg + mulout[2*BW-1 : BW];
	if (mulout[0]) begin
		temp_reg2 = {temp_reg, mulout[(BW)-1:1]};
	end
	else begin
		temp_reg2 = {1'b0, mulout[2*BW-1:1]};
	end
end

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		mulout <= '0;
        outval <= 1'b0;
		mulStarted <= 1'b0;
		counter <= {(BW){1'b0}};
	end
	else begin
		if (inval && !mulStarted) begin
			mulout <= {{(BW/2){1'b0}}, inB};
			inA_reg <= inA;
			counter <= '0;
			mulStarted <= 1'b1;
			outval <= 1'b0;
		end
		else if (mulStarted) begin
			mulout <= temp_reg2;
			counter <= counter + 1'b1;
			if (counter == BW-1) begin
				outval <= 1'b1;
				counter <= {(BW){1'b0}};
				mulStarted <= 1'b0;
			end
		end
		else outval <= 1'b0;
	end
end

endmodule //shiftaddmul

