
module max2bitsetseq
#(parameter N = 4)
(
 input logic clk, 
 input logic rstn,
 output logic [N-1:0] outseq
 );

 typedef enum logic {s1, s0} state_t;

 state_t state;

 logic [N-1:0] tempx, tempx_pre;
 logic [N-1:0] tempy, tempy_pre;
/*
 always_comb tempx_pre = (state == s0) ? { {(N-2){1'b0}} , 2'b10} :
                         (state == s1) ? ( tempx < {1'b1, {(N-1){1'b0}}} ? tempx << 1 : 
                                                                            tempx );

 always_comb tempy_pre = (state == s0) ? {{(N-1){1'b0}}, 1'b1} :
                         (state == s1) ? (tempy < tempx ? tempy << 1 : 
                                                           {{(N-1){1'b0}}, 1'b1});

                                         

 always_ff @(posedge clk, negedge rstn) begin
    if (!rstn) begin
        outseq <= '0;
        state <= s0;
    end
    else begin
        case(state)
            
            s0 : begin
                    tempx <= tempx_pre;
                    tempy <= tempy_pre;
                    state <= s1;
                end
            s1: begin
                    if (tempy < tempx) begin
                        outseq <= tempx | tempy;
                        tempy <= tempy_pre;
                    end
                    else begin
                        if ( tempx < {1'b1, {(N-1){1'b0}}} ) begin
                            tempx <= tempx_pre;
                            tempy <= tempy_pre;
                        end
                        else begin
                            state <= s0;
                        end
                    end
                end
            default: state <= s0;

        endcase
    end
 end
*/

//Workign code but high latency and delay

 always_ff @(posedge clk, negedge rstn) begin
    if (!rstn) begin
        outseq <= '0;
        state <= s0;
    end
    else begin
        case(state)
            
            s0 : begin
                    tempx <= { {(N-2){1'b0}} , 2'b10};
                    tempy <= { {(N-1){1'b0}}, 1'b1};
                    state <= s1;
                end
            s1: begin
                    if (tempy < tempx) begin
                        outseq <= tempx | tempy;
                        tempy <= tempy << 1;
                    end
                    else begin
                        if ( tempx < {1'b1, {(N-1){1'b0}}} ) begin
                            tempx <= tempx << 1;
                            tempy <= { {(N-1){1'b0}}, 1'b1};
                        end
                        else begin
                            state <= s0;
                        end
                    end
                end
            default: state <= s0;

        endcase
    end
 end


endmodule
