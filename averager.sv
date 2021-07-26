// N number averager, N number comes one by one at clock, give output after N cycles
//Asumming N is power of 2, else we can store look up table values for reciprocal of N (may be Fixed point implementation, rather than integer)


module averager
#(parameter N = 4,
  parameter BW = 4)
  
(
 input clk, rstn,
 input inval,
 input [BW-1:0] in1,
 
 output logic [BW-1:0] out,
 output logic outval
);

logic [$clog2(N)+BW-1:0] accum;
logic accumdone;

logic [$clog2(N)-1:0] counter;

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		accum <= {($bits(accum)){1'b0}};
		accumdone <= 1'b0; 
	end
	else begin
		if (inval) begin
			if (counter < N) begin
				accum <= accum + in1;
				counter <= counter + 1'b1;
				if (counter == N-1) begin
					accumdone <= 1'b1;
				end
			end
		end
		else begin
			if (outval) begin
				counter <= {($clog2(N)){1'b0}};
				accum <= {($clog2(N)+BW){1'b0}};
				accumdone <= 1'b1;
			end
		end
	end
end

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		outval <= 1'b0;
	end
	else begin
		if (accumdone) begin
			out <= accum >> $clog2(N);
			outval <= 1'b1;
		end
		else begin
			outval <= 1'b0;
		end
	end
end

endmodule
