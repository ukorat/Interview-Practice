module max2bitsetseq_optim_tb
();

parameter N = 4;

logic clk;
logic rst_b;
logic [N-1:0] outnum;

max2bitsetseq_optim
uut
(.*);

initial begin
    clk <= 1'b0;
    forever #5 clk <= ~clk;
end

initial begin

rst_b <= 1'b0;
repeat (5) @(posedge clk);
rst_b <= 1'b0;
repeat (5) @(posedge clk);
@(negedge clk) rst_b <= 1'b1;

repeat(200) @(posedge clk);
$stop;


end

endmodule
