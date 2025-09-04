`timescale 1ns/1ps
module booth_tb;
 reg clk;
 reg start;
 reg signed [15:0] M_in;
 reg signed [15:0] Q_in;
 wire [15:0] A;
 wire [15:0] Q;
 wire [15:0] M;
 wire q_minus1;
 wire eqz;
 wire done;
 wire ldM, ldQ, ldA, clrA, clrQ, clr_q1, shift, addsub, decr, ldcnt;
 booth_datapath DP(
  .clk(clk), .ldM(ldM), .ldQ(ldQ), .ldA(ldA), .clrA(clrA), .clrQ(clrQ),
  .clr_q1(clr_q1), .shift(shift), .addsub(addsub), .decr(decr), .ldcnt(ldcnt),
  .M_in(M_in), .Q_in(Q_in), .A(A), .Q(Q), .M(M), .q_minus1(q_minus1), .eqz(eqz)
 );
 booth_controller CU(
  .clk(clk), .start(start), .q0(Q[0]), .qm1(q_minus1), .eqz(eqz),
  .ldM(ldM), .ldQ(ldQ), .ldA(ldA), .clrA(clrA), .clrQ(clrQ), .clr_q1(clr_q1),
  .shift(shift), .addsub(addsub), .decr(decr), .ldcnt(ldcnt), .done(done)
 );
 initial clk = 0;
 always #5 clk = ~clk;
 initial begin
  $dumpfile("booth.vcd");
  $dumpvars(0, booth_tb);
  run_test(3,2,1);
  run_test(-4,5,2);
  run_test(7,-3,3);
  run_test(-6,-2,4);
  run_test(8,0,5);
  $finish;
 end
 task run_test;
  input signed [15:0] m;
  input signed [15:0] q;
  input integer id;
  integer timeout;
  begin
   M_in = m;
   Q_in = q;
   start = 1;
   @(posedge clk);
   start = 0;
   timeout = 0;
   while (!done && timeout < 1000) begin @(posedge clk); timeout = timeout + 1; end
   if (timeout >= 1000) $display("TEST %0d TIMEOUT M=%0d Q=%0d", id, m, q);
   else begin
    @(posedge clk);
    $display("TEST %0d M=%0d Q=%0d PRODUCT(dec)=%0d PRODUCT(hex)=%h", id, m, q, $signed({A,Q}), {A,Q});
   end
  end
 endtask
endmodule

