module ring_counter_8bit (
    input  wire clk,
    input  wire rst,       
    output reg  [7:0] out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            out <= 8'b00000001;
        end else begin
            
            out <= { out[6:0], out[7] };
        end
    end

endmodule
