module ringcounter_jerky

#(parameter BW = 8)
( input clk, rst_b,
  output logic [BW-1:0] out
  );

  logic flag;
  logic [$clog2(BW)-1:0] count;

  always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        out <= {{(BW-1){1'b0}}, 1'b1};
        flag <= 1'b0;
        count <= {{($clog2(BW)-1){1'b0}}, 1'b0};
    end
    else begin
        if (flag) begin
            out <= 1 << count;
            flag <= !flag;
        end
        else begin
            out <=  {{(BW-1){1'b0}}, 1'b1};
            count <= count + 1'b1;
            if (count == BW-1) begin
                count <= {{($clog2(BW)-1){1'b0}}, 1'b1};
            end
            flag <= !flag;
        end
    end
  end

endmodule 
