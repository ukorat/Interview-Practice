module onepriotworoundarb

(
input logic clk, rst_b,
input logic [2:0] req, //req[2] highest priority
output logic [2:0] gnt
);

logic [1:0] gnt_r;

always_ff @(posedge clk or negedge rst_b) begin
	if (!rst_b) begin
		gnt <= 3'b000;
	end
	else begin
		if (req[2]) begin
			gnt <= 3'b100;
		end
		else begin
			gnt <= {1'b0, gnt_r};
		end
	end
end



always_comb begin
	if (^req[1:0]) begin
		gnt_r = req[1:0];
	end
	else if (&req[1:0]) begin
		if (gnt[0])
			gnt_r <= 2'b10;
		else 
			gnt_r <= 2'b01;
	end
	else begin
		gnt_r = 2'b00;
	end
end

endmodule
