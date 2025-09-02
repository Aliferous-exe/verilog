module GCD_datapath(
    output gt,
    output lt,
    output eq,
    output [15:0] Aout,
    output [15:0] Bout,
    input ldA,
    input ldB,
    input selA_sub,
    input selB_sub,
    input [15:0] data_in,
    input clk
);

    reg [15:0] A;
    reg [15:0] B;
    wire [15:0] subAB = A - B;
    wire [15:0] subBA = B - A;

    always @(posedge clk) begin
        if (ldA) A <= (selA_sub ? subAB : data_in);
        if (ldB) B <= (selB_sub ? subBA : data_in);
    end

    assign Aout = A;
    assign Bout = B;
    assign lt = (A < B);
    assign gt = (A > B);
    assign eq = (A == B);

endmodule
