module parallel_carry_adder_16bit (
    input  [15:0] a,
    input  [15:0] b,
    input         c_in,
    output reg [15:0] sum,
    output reg       c_out
);

    reg [16:0] temp; // To hold intermediate sum with carry

    always @(*) begin
        temp = a + b + c_in;  // Behavioral addition
        sum = temp[15:0];     // Lower 16 bits as sum
        c_out = temp[16];     // MSB as carry out
    end

endmodule
