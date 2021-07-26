// counter with skipped muliple of 3

module skippedmul3count
#(parameter BW = 8)
(
input clk, rstn,
output logic [BW-1:0] countout
);

logic add2;

always_ff @(posedge clk, negedge rstn) begin
	if (!rstn) begin
		add2 <= 1'b0;
	end
	else begin
		if (countout == '0) begin
			add2 <= 0;
		end 
		else begin
			add2 <= ~add2;
		end
    end
end

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		countout <= '0;
	end
	else begin
		countout <= countout + 1'b1 + add2;
	end
end

endmodule
