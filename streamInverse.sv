//Q: Design a module that reverses the order of every N inputs from the input stream.
//1, 2 ,3 > 3, 2 ,1
//N is a static parameter

module streamInverse

#(parameter N = 4)

(
 input clk, rst,
 input [31:0] in1,
 output logic [31:0] out,
 output logic valid,
 output logic ready
);

logic [31:0] tempReg [N-1:0]; 

//typedef enum logic {s0, s1} state_t;

//state_t curState, nxtState;

localparam s0 = 1'b0;
localparam s1 = 1'b1;

logic curState;

logic [$clog2(N)-1:0] counter;

//always_ff @(posegde clk) begin
always @(posedge clk) begin
if (!rst) begin
	out <= '0;
	curState <= s0;
	ready <= 1'b1;
    valid <= 1'b0;
    counter <= '0;
end
else begin

    case (curState)

s0 : begin
	if (counter < N-1) begin
	    tempReg[counter] <= in1;
	    counter <= counter + 1'b1; 
        valid <=0;

	end 
    else begin
        tempReg[counter] <= in1;
	    curState <= s1;
	    ready <= 0;
    end
end

s1 : begin
	if (counter == 0) begin
        curState <= s0;
        ready <= 1'b1;
    end
     else begin
//        curState <= s0;
//        valid <= 1'b0;
//        ready <= 1'b1;
        counter <= counter - 1'b1;
    end
    out <= tempReg[counter];
    valid <=1;
end

default : curState <= 'X;
    
    endcase

end
end

endmodule //
