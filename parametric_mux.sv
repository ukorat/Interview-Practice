
module parametric_mux
#(
    parameter WORD_COUNT = 8,
    parameter BIT_WIDTH = 8
)

(
    input        [$clog2(WORD_COUNT)-1:0] sel,
    input        [(WORD_COUNT*BIT_WIDTH)-1:0] words_in,
    output logic [BIT_WIDTH-1:0] word_out
);

always_comb word_out = words_in[BIT_WIDTH*sel +: BIT_WIDTH];

endmodule
