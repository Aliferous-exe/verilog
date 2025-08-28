module traffic_lights(clk, reset, lights);
    input clk, reset;
    output reg [2:0] lights;

    // State encoding
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

    // Light encoding
    parameter RED = 3'b100, GREEN = 3'b101, YELLOW = 3'b001;

    reg [1:0] state, next_state;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next State and Output Logic
    always @(*) begin
        case (state)
            S0: begin
                lights = RED;
                next_state = S1;
            end
            S1: begin
                lights = GREEN;
                next_state = S2;
            end
            S2: begin
                lights = YELLOW;
                next_state = S0;
            end
            default: begin
                lights = RED;
                next_state = S0;
            end
        endcase
    end
endmodule

