module bubble_sort
#(
parameter BW = 8,
parameter N = 8
)
(input clk, rstn,
 input [N*BW-1:0] inNum,
 output logic [N*BW-1:0] outNum);
 
 logic [BW-1:0] array [N-1:0];
 logic [BW-1:0] temp [N-1:0];

 logic [BW-1:0] temp_val;
 
always @(posedge clk) begin
	for (int i = 0; i < N; i++) begin
		array[i] <= inNum[i*BW +: BW];
	end
end

always @(*) begin

for (int j = 0; j < N; j++) begin
	temp[j] = array[j];
end

for (int k = 0; k < N; k++) begin
	for (int l = 0; l < (N-1)-k; l++) begin
		if (temp[l] > temp[l+1]) begin
			temp_val = temp[l];
			temp[l] = temp[l+1];
			temp[l+1] = temp_val;
		end
	end
end

end

always @(posedge clk) begin
	for (int i= 0; i<N; i++) begin
		outNum[i*BW +: BW] <= temp[i];
	end
end

endmodule
