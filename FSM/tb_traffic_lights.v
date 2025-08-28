module tb_traffic_lights;
    reg clk, reset;
    wire [2:0] lights;

    traffic_lights uut (.clk(clk), .reset(reset), .lights(lights));

    initial begin
        $dumpfile("trafficlights.vcd");
        $dumpvars(0, tb_traffic_lights);

        clk = 0;
        reset = 1;
        #10 reset = 0;

        #200 $finish;
    end

    always #5 clk = ~clk;
endmodule
