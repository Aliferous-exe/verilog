`timescale 1ns / 1ps // Defines the time unit and precision for the simulation.

module tb_shift_register_4bit;

    // Testbench signals
    reg clk;      // Clock signal to be generated
    reg rst_n;    // Reset signal to be generated
    reg data_in;  // Data input to drive the DUT
    wire data_out; // Data output to be monitored from the DUT

    // Instantiate the Design Under Test (DUT)
    shift_register_4bit dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation block
    // Creates a clock with a 10ns period (5ns high, 5ns low).
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5ns
    end

    // Main stimulus block
    initial begin
        // VCD (Value Change Dump) file generation
        $dumpfile("dump.vcd"); // Specifies the output VCD filename
        $dumpvars(0, tb_shift_register_4bit); // Dumps all variables in this module and below

        // 1. Initialize signals
        rst_n = 1'b1; // De-assert reset initially
        data_in = 1'b0;
        #10; // Wait for a moment

        // 2. Apply reset
        $display("T=%0t: Applying reset...", $time);
        rst_n = 1'b0; // Assert active-low reset
        #15; // Hold reset for 1.5 clock cycles
        rst_n = 1'b1; // De-assert reset
        $display("T=%0t: Releasing reset.", $time);
        #5;

        // 3. Drive data sequence: 1101
        $display("T=%0t: Starting data transmission: 1101", $time);

        // Send bit 1
        @(posedge clk);
        data_in = 1'b1;
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        // Send bit 0
        @(posedge clk);
        data_in = 1'b0;
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        // Send bit 1
        @(posedge clk);
        data_in = 1'b1;
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        // Send bit 1
        @(posedge clk);
        data_in = 1'b1;
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        // 4. Drive a few more clocks to see the data shift out
        @(posedge clk);
        data_in = 1'b0; // Drive 0 to flush out the register
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        @(posedge clk);
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        @(posedge clk);
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        @(posedge clk);
        $display("T=%0t: Driving data_in = %b, Register = %b, data_out = %b", $time, data_in, dut.shift_reg, data_out);

        // 5. End simulation
        #20;
        $display("T=%0t: Simulation finished.", $time);
        $finish;
    end

endmodule
