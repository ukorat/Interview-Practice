module skippedmul3count_tb();

parameter BW = 8;

logic        clk, rstn;
logic [BW-1:0] countout;

skippedmul3count
uut
(.*);

initial begin
    clk <= 1'b0;
    forever #5 clk <= ~clk;
end

initial begin

rstn <= 1'b1;
repeat (5) @(posedge clk);
rstn <= 1'b0;
repeat (5) @(posedge clk);
@(negedge clk) rstn <= 1'b1;

repeat(200) @(posedge clk);
$stop;
end

endmodule
