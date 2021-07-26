module indexofone_tb
();

parameter BW = 8;

logic clk, rst_b;
logic in_vld;
logic [BW-1:0] in1;
logic out_vld;
logic [$clog2(BW)-1:0] index;

indexofone
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
repeat (5) @(posedge clk);
@(negedge clk) in_vld <= 1'b1; in1 <= 8'b10001001;
@(negedge clk) in_vld <= 1'b0;
repeat(200) @(posedge clk);
$stop;


end
endmodule
