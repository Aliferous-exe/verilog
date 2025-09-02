module gcd_test;
    reg clk;
    reg reset;
    reg start;
    reg [15:0] data_in;
    wire gt, lt, eq;
    wire [15:0] Aout, Bout;
    wire ldA, ldB, selA_sub, selB_sub;
    wire done;

    GCD_datapath DP (
        .gt(gt),
        .lt(lt),
        .eq(eq),
        .Aout(Aout),
        .Bout(Bout),
        .ldA(ldA),
        .ldB(ldB),
        .selA_sub(selA_sub),
        .selB_sub(selB_sub),
        .data_in(data_in),
        .clk(clk)
    );

    controller CON (
        .clk(clk),
        .reset(reset),
        .start(start),
        .lt(lt),
        .gt(gt),
        .eq(eq),
        .ldA(ldA),
        .ldB(ldB),
        .selA_sub(selA_sub),
        .selB_sub(selB_sub),
        .done(done)
    );

    initial begin
        $dumpfile("gcd.vcd");
        $dumpvars(0, gcd_test);
        clk = 0;
        reset = 1;
        start = 0;
        data_in = 16'd0;
        #7 reset = 0;
        data_in = 16'd48;
        start = 1;
        #10 start = 0;
        #10 data_in = 16'd18;
        #300 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor("t=%0t A=%0d B=%0d ldA=%b ldB=%b selA=%b selB=%b done=%b", $time, Aout, Bout, ldA, ldB, selA_sub, selB_sub, done);
    end
endmodule
