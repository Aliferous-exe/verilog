module booth_controller(
 input clk,
 input start,
 input q0,
 input qm1,
 input eqz,
 output reg ldM,
 output reg ldQ,
 output reg ldA,
 output reg clrA,
 output reg clrQ,
 output reg clr_q1,
 output reg shift,
 output reg addsub,
 output reg decr,
 output reg ldcnt,
 output reg done
);
 reg [2:0] state;
 parameter IDLE=3'b000, LOAD=3'b001, CHECK=3'b010, ADD=3'b011, SUB=3'b100, SHIFT=3'b101, DONE=3'b110;
 always @(posedge clk) begin
  case(state)
   IDLE: if(start) state <= LOAD;
   LOAD: state <= CHECK;
   CHECK: if(eqz) state <= DONE;
          else if ({q0,qm1}==2'b01) state <= ADD;
          else if ({q0,qm1}==2'b10) state <= SUB;
          else state <= SHIFT;
   ADD: state <= SHIFT;
   SUB: state <= SHIFT;
   SHIFT: state <= CHECK;
   DONE: state <= IDLE;
   default: state <= IDLE;
  endcase
 end
 always @(*) begin
  ldM=0; ldQ=0; ldA=0; clrA=0; clrQ=0; clr_q1=0; shift=0; addsub=0; decr=0; ldcnt=0; done=0;
  case(state)
   IDLE: begin clrA=1; clrQ=1; clr_q1=1; end
   LOAD: begin ldM=1; ldQ=1; ldcnt=1; end
   ADD:  begin ldA=1; addsub=1; end
   SUB:  begin ldA=1; addsub=0; end
   SHIFT: begin shift=1; decr=1; end
   DONE: done=1;
  endcase
 end
endmodule
