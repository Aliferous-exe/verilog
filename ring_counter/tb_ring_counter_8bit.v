`timescale 1ns/1ps
module tb_ring_counter_8bit;
    reg clk;
    reg rst;
    wire [7:0] out;

    // DUT
    ring_counter_8bit dut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("ringcounter8bit.vcd");
        $dumpvars(0, tb_ring_counter_8bit);

        
        rst = 1; #12;
        rst = 0;

        
        #200;

        $finish;
    end

    initial begin
        $monitor("%0t  clk=%b  rst=%b  out=%b", $time, clk, rst, out);
    end
endmodule
