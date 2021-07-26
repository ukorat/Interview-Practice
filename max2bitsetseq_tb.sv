module max2bitsetseq_tb();

parameter N = 4;

logic clk;
logic rstn;
logic [N-1:0] outseq;

max2bitsetseq
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
