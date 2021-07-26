module bubble_sort_tb();


parameter BW = 8;
parameter N = 4;

logic clk, rstn;
logic [N*BW-1:0] inNum;
logic [N*BW-1:0] outNum;

bubble_sort
#(.N(N))
uut (.*);

initial begin
    clk <= 1'b0;
    forever #5 clk <= ~clk;
end

always @(negedge clk) begin
    inNum <= {$random, $random, $random, $random};
end

initial begin
    repeat (50) @(posedge clk);
    $stop;
end

endmodule
