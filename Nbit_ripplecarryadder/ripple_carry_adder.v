module ripple_carry_adder #(parameter N = 8) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire cin,
    output wire [N-1:0] sum,
    output wire cout
);

    wire [N:0] carry;
    assign carry[0] = cin;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : FA_LOOP
            full_adder FA (
                .a   (a[i]),
                .b   (b[i]),
                .cin (carry[i]),
                .sum (sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[N];

endmodule