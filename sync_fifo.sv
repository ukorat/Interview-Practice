module sync_fifo
	#(parameter DEPTH = 32,
  parameter DW = 8
  )
  
 (input logic clk, rst_b,
  input logic wren,
  input logic [DW-1:0] datain,
  input logic rden,
  output logic [DW-1:0] dataout,
  output logic full,
  output logic empty
  );
  

localparam AW = $clog2(DEPTH);

logic [AW:0] wrptr, rdptr;

logic [DW-1:0] mem [AW-1:0];

always @(posedge clk or negedge rst_b) begin
	if (!rst_b) begin
		wrptr <= '0;
	end
	else begin
		unique casez({full, wren})
			2'b1?, 2'b00 : wrptr <= wrptr;
			2'b01 : wrptr <= wrptr + 1'b1;
			default : wrptr <= 'x;
		endcase
	end
end


always @(posedge clk) begin
	if (!full && wren)
		mem[wrptr[AW-1:0]] <= datain;
end

always @(posedge clk or negedge rst_b) begin
	if (!rst_b) begin
		rdptr <= '0;
	end
	else begin
		unique casez ({empty, rden})
			2'b00, 2'b1? : rdptr <= rdptr;
			2'b01 : rdptr <= rdptr + 1'b1;
		default : rdptr <= 'x;
		endcase
	end
end

always @(posedge clk) begin
	if (!empty && rden)
		dataout <= mem[rdptr[AW-1:0]];
end

always_comb full  = (wrptr[AW] != rdptr[AW]) && (wrptr[AW-1:0] == rdptr[AW-1:0]);
always_comb empty = wrptr == rdptr;

endmodule


/*


module sync_fifo
#()
();


always_comb full =  {wraddr_ff[W-1], wraddr_ff[W-2:0]} == {!rdaddr_ff[W-1], rdaddr_ff[W-2:0]};
always_comb empty = wraddr_ff == rdaddr_ff;

// If not power of 2 depth
/*

logic [2:0] fifo_count, fifo_count_ff;

always_comb begin
unique casez ({rd_en, wr_en})
  2'b00 : fifo_count = fifo_count_ff;
  2'b01 : fifo_count = (fifo_count_ff == 3'b111) ? 3'b111
                       : (fifo_count_ff + 3'b001);
  2'b10 : fifo_count = (fifo_count_ff == 3'b0) ? 3'b0
                       : (fifo_count_ff - 3'b001);
  2'b11 : fifo_count = fifo_count_ff;
endcase
end

always_ff @(posedge clk or negedge reset) begin
if(!reset)
  fifo_count_ff <= 3'b0;
else
  fifo_count_ff <= fifo_count;
end

assign fifo_full  = (fifo_count == 3'b111);
assign fifo_empty = (fifo_count == 3'b0);

*/

/*
//Write address
always_comb begin
	if (!full & wr_en)
		wraddr = wraddr_ff + 1'b1;
	else
		wraddr = wraddr_ff;
end

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn)
		wraddr_ff <= '0;
	else if (wr_en)
		wraddr_ff <= wraddr;
end


always_ff @(posedge clk)
	if (wr_en & !full)
		mem[wraddr_ff] <= data_in;

//read address
always_comb begin
	if (!empty & rd_en)
		rdaddr = rdaddr_ff + 1'b1;
	else
		rdaddr = rdaddr_ff + 1'b1;
end

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn)
		rdaddr_ff <= '0;
	else if (wr_en)
		rdaddr_ff <= wraddr;
end

always_ff @(posedge clk)
	if (rd_en & !empty)
		data_out <= mem[rdaddr_ff];

endmodule


*/
