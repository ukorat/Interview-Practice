
module streamInverse_tb;

reg clk;
reg rst = 1'b0;
reg [31:0] in1;

wire [31:0] out;
wire valid, ready;

streamInverse
uut (.*);

initial begin
    clk <= 1'b0;
    forever #5 clk <= ~clk;
end

initial begin

in1 <= 32'd0;
repeat (10) @(posedge clk); 
@(negedge clk) rst <= 1'b1; in1 <= 32'd1;
@(negedge clk) rst <= 1'b1; in1 <= 32'd2;
@(negedge clk) rst <= 1'b1; in1 <= 32'd3;
@(negedge clk) rst <= 1'b1; in1 <= 32'd4;
@(negedge clk) rst <= 1'b1; in1 <= 32'd5;
@(negedge clk) rst <= 1'b1; in1 <= 32'd6;
@(negedge clk) rst <= 1'b1; in1 <= 32'd7;
@(negedge clk) rst <= 1'b1; in1 <= 32'd8;
@(negedge clk) rst <= 1'b1; in1 <= 32'd9;
@(negedge clk) rst <= 1'b1; in1 <= 32'd10;
@(negedge clk) rst <= 1'b1; in1 <= 32'd11;
@(negedge clk) rst <= 1'b1; in1 <= 32'd12;

$finish();
end

endmodule
