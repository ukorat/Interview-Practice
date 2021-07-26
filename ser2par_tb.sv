module ser2par_tb;

parameter W = 8;

reg          clk;
reg          rstn = 1'b0;
reg          ser_din;
reg          ser_din_valid;
wire [W-1:0] par_dout;
wire par_dout_valid;

ser2par
uut (.*);

initial begin
    clk <= 1'b0;
    forever #10 clk <= ~clk;
end

initial begin

repeat (15) @(posedge clk);

ser_din_valid <= 1'b0; ser_din <= 1'b0;

@(posedge clk) rstn <= 1'b1;

repeat (10) @(posedge clk);

@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b0;
@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b1;
@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b1;
@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b1;

@(posedge clk) ser_din_valid <= 1'b0; ser_din <= 1'b0;

@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b0;
@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b0;
@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b0;
@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b1;

@(posedge clk) ser_din_valid <= 1'b0;

@(posedge clk) ser_din_valid <= 1'b1; ser_din <= 1'b1;

@(posedge clk) ser_din_valid <= 1'b0;

repeat (15) @(posedge clk);

end

endmodule 
