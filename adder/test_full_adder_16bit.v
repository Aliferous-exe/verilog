module test_full_adder_16bit;

    reg  [15:0] a, b;
    reg         c_in;
    wire [15:0] sum;
    wire        c_out;

    // Instantiate the DUT (Device Under Test)
    full_adder_16bit uut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );

    initial begin
        $dumpfile("adder16.vcd");
        $dumpvars(0, test_full_adder_16bit);
        $monitor("Time: %0t | a = %h, b = %h, c_in = %b | sum = %h, c_out = %b", 
                 $time, a, b, c_in, sum, c_out);

        // Test cases
        a = 16'h0001; b = 16'h0001; c_in = 0; #10;
        a = 16'hFFFF; b = 16'h0001; c_in = 0; #10;
        a = 16'h1234; b = 16'h4321; c_in = 1; #10;
        a = 16'hABCD; b = 16'h1234; c_in = 0; #10;
        a = 16'h0000; b = 16'h0000; c_in = 1; #10;

        $finish;
    end

endmodule
