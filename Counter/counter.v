module counter(out, clk, reset);
    parameter WIDTH = 8;

    output reg [WIDTH-1:0] out;
    input clk, reset;

    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            out <= out + 1;
    end
endmodule // counter
