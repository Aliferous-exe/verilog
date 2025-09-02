module controller(
    input clk,
    input reset,
    input start,
    input lt,
    input gt,
    input eq,
    output reg ldA,
    output reg ldB,
    output reg selA_sub,
    output reg selB_sub,
    output reg done
);

    reg [2:0] state;
    parameter IDLE  = 3'b000,
              LOADA = 3'b001,
              LOADB = 3'b010,
              COMP  = 3'b011,
              SUBA  = 3'b100,
              SUBB  = 3'b101,
              DONE  = 3'b110;

    always @(posedge clk or posedge reset) begin
        if (reset) state <= IDLE;
        else begin
            case (state)
                IDLE:  if (start) state <= LOADA; else state <= IDLE;
                LOADA: state <= LOADB;
                LOADB: state <= COMP;
                COMP:  if (eq) state <= DONE;
                       else if (gt) state <= SUBA;
                       else state <= SUBB;
                SUBA:  state <= COMP;
                SUBB:  state <= COMP;
                DONE:  state <= DONE;
                default: state <= IDLE;
            endcase
        end
    end

    always @(*) begin
        ldA = 0;
        ldB = 0;
        selA_sub = 0;
        selB_sub = 0;
        done = 0;

        case (state)
            LOADA: begin ldA = 1; selA_sub = 0; end
            LOADB: begin ldB = 1; selB_sub = 0; end
            SUBA:  begin ldA = 1; selA_sub = 1; end
            SUBB:  begin ldB = 1; selB_sub = 1; end
            DONE:  done = 1;
            default: begin end
        endcase
    end

endmodule
