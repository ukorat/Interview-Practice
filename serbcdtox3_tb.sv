module serbcdtox3_tb
();

logic clk;
logic rst_b;
logic inval, in;
logic outval, out;
logic [3:0] x3code;

serbcdtox3
uut
(.*);

initial begin
    clk <= 1'b0;
    forever begin
        #5 clk <= !clk;
    end
end

initial begin
rst_b <= 1'b0;
inval <= 1'b0;

repeat (10) @(posedge clk);
@(negedge clk) rst_b <= 1'b1;
repeat (5) @(posedge clk);
@(negedge clk) inval <= 1'b1; in <= 1'b1;
@(negedge clk) inval <= 1'b1; in <= 1'b0;
@(negedge clk) inval <= 1'b0; in <= 1'bx;
@(negedge clk) inval <= 1'b1; in <= 1'b0;
@(negedge clk) inval <= 1'b1; in <= 1'b1;
@(negedge clk) inval <= 1'b1; in <= 1'b0;

repeat(200) @(posedge clk);
$stop;

end

endmodule
