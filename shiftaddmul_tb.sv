module shiftaddmul_tb
();

parameter BW = 4;

logic clk, rstn;
logic inval;
logic [BW-1:0] inA, inB;
logic [2*BW-1:0] mulout;
logic outval;
logic mulStarted;

shiftaddmul
#(.BW(BW))
uut
(.*);

initial begin
    clk <= 1'b0;
    forever begin
        #5 clk <= ~clk;
    end
end

always @(negedge clk) begin
    if (!rstn) begin
        inval <= 1'b0;
//        inA, inB <= {'x, 'x};
    end
    else if (!mulStarted) begin
        inval <= 1'b1;
        {inA, inB} <= {$random, $random};
    end
    else begin
        inval <= 1'b0;
//        inA, inB <= {'x, 'x};
    end
end

initial begin

rstn <= 1'b0;

repeat (10) @(posedge clk);
@(negedge clk) rstn <= 1'b1;
repeat (5) @(posedge clk);

repeat(200) @(posedge clk);
$stop;

end

endmodule
