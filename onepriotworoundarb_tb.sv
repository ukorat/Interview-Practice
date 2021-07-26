
module onepriotworoundarb_tb
();

logic clk, rst_b;
logic [2:0] req;
logic [2:0] gnt;

onepriotworoundarb
uut
(.*);

initial begin
    clk <= 1'b0;
    forever #5 clk <= ~clk;
end

always @(negedge clk) begin
    if (!rst_b)
        req <= 3'b000;
    else
        req <= $random;
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
