`timescale 1ns/1ps
module tb_ripple_carry_adder;
    parameter N = 8;
    reg  [N-1:0] a, b;
    reg  cin;
    wire [N-1:0] sum;
    wire cout;

    ripple_carry_adder #(N) dut (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout)
    );

    initial begin
        $dumpfile("ripplecarryadder.vcd");
        $dumpvars(0, tb_ripple_carry_adder);

        // Test cases
        a = 8'b00001111; b = 8'b00000001; cin = 0; #10;
        a = 8'b11110000; b = 8'b00001111; cin = 0; #10;
        a = 8'b10101010; b = 8'b01010101; cin = 1; #10;
        a = 8'b11111111; b = 8'b00000001; cin = 0; #10;

        $finish;
    end

    initial begin
        $monitor("%0t: a=%b b=%b cin=%b | sum=%b cout=%b",
                 $time, a, b, cin, sum, cout);
    end
endmodule