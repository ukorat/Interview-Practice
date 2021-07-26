module ringcounter_jerky_tb
();

parameter BW = 8;

logic clk;
logic rst_b;
logic [BW-1:0] out;

ringcounter_jerky
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
repeat(5) @(posedge clk);
@(negedge clk) rst_b <= 1'b1;
repeat(200) @(posedge clk);
$stop;

end

endmodule
