module booth_datapath(
 input clk,
 input ldM,
 input ldQ,
 input ldA,
 input clrA,
 input clrQ,
 input clr_q1,
 input shift,
 input addsub,
 input decr,
 input ldcnt,
 input [15:0] M_in,
 input [15:0] Q_in,
 output reg [15:0] A,
 output reg [15:0] Q,
 output reg [15:0] M,
 output reg q_minus1,
 output eqz
);
 reg [4:0] count;
 wire [15:0] alu_out;
 reg [32:0] big_old;
 assign eqz = (count == 5'd0);
 assign alu_out = addsub ? (A + M) : (A - M);
 always @(*) big_old = {A, Q, q_minus1};
 always @(posedge clk) begin
  if (ldcnt) count <= 5'd16;
  else if (decr) count <= count - 1;
  if (ldM) M <= M_in;
  if (clrQ) Q <= 16'h0;
  else if (ldQ) Q <= Q_in;
  if (clrA) A <= 16'h0;
  else if (ldA) A <= alu_out;
  if (clr_q1) q_minus1 <= 1'b0;
  if (shift) begin
   {A, Q, q_minus1} <= {A[15], big_old[32:1]};
  end
 end
endmodule
