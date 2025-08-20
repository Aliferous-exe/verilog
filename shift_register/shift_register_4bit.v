module shift_register_4bit (
    // Input ports
    input wire clk,      // Clock signal
    input wire rst_n,    // Active-low synchronous reset
    input wire data_in,  // Serial data input

    // Output port
    output wire data_out // Serial data output
);

    // Internal 4-bit register to hold the shifted data.
    reg [3:0] shift_reg;

    // The core logic of the shift register.
    // This block is sensitive to the positive edge of the clock
    // and the negative edge of the reset signal.
    always @(posedge clk or negedge rst_n) begin
        // On reset (rst_n is low), clear the register to all zeros.
        if (!rst_n) begin
            shift_reg <= 4'b0000;
        end
        // On the positive edge of the clock, perform the shift operation.
        else begin
            // The new value of the register is formed by concatenating
            // the lower 3 bits of the current register value with the new data_in.
            // Example: If shift_reg is 1011 and data_in is 0,
            // the new value becomes {011, 0} -> 0110.
            shift_reg <= {shift_reg[2:0], data_in};
        end
    end

    // The output is the most significant bit (MSB) of the register.
    // As data shifts in from the right (LSB), it eventually shifts out from the left (MSB).
    assign data_out = shift_reg[3];

endmodule
