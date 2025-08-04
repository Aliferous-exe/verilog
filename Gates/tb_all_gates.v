`timescale 1ns/1ps

module tb_all_gates();
    reg a, b;
    wire y;

    // Simple AND gate for testing VCD
    and (y, a, b);

    initial begin
        $dumpfile("gate.vcd");
        $dumpvars(0, tb_all_gates);
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $finish;
    end
endmodule

