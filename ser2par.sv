module ser2par

#(parameter W = 8)

(input clk, 
 input rstn,
 input ser_din,
 input ser_din_valid,
 output reg [W-1:0] par_dout,
 output reg par_dout_valid
 );
 
 logic [$clog2(W)-1:0] counter;
 
 always @(posedge clk, negedge rstn) begin
	if (!rstn) begin
		counter <= '0;
	end 
	else begin
		if (ser_din_valid) begin
			par_dout <= {par_dout[W-2 : 0], ser_din};
			counter <= counter + 1'b1;
			if (counter == W-1)
				counter <= '0;
		end
	end
end

always @(posedge clk, negedge rstn) begin
	if (!rstn) begin
		par_dout_valid <= 1'b0;
	end
	else begin
		if (counter == W-1) begin
			par_dout_valid <= 1'b1;
		end
		else begin
			par_dout_valid <= 1'b0;
		end
	end
end

endmodule 
