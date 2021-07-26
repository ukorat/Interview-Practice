module serbcdtox3

(
input clk, rst_b,
input inval,
input in,
output logic out,
output logic outval,
output logic [3:0] x3code
);

logic [1:0] count;
logic carry;

always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        outval <= 1'b0;
        carry <= 1'b0;
        count <= 2'b11;
    end
    else begin
        if (inval) begin
            outval <= 1'b1;
            {carry, out} <= in + carry + count[1];
            x3code[3-count] <= in + carry + count[1];
            count <= count - 1'b1;
        end
        else begin
            outval <= 1'b0;
        end
    end
end

endmodule

