`timescale 1ns/100ps
module testbench;
    // input
    reg clk;
    reg reset;
    reg [7:0] a;
    reg [7:0] b;
    //output
    wire [7:0] c;
    adder uut(
        // 左邊的clk是adder裡面宣告input的clk，而括弧內的clk為testbench所產生的clk
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),  
        .c(c)  
    );
    // This block executes once at the beginning of the simulation
    // initial execute from top to bottom
    initial begin
        clk = 0;
        reset = 0;
        a = 0;
        b = 0;
        // #10 means 10 time unit passed
        #10;
        reset = 1;
        #10;
        reset = 0;
        // test case at 100 s 
        #100;
        a = 4;
        b = 7;
        #10;
        a = 8;
        b = 17;
    end
    initial begin // need for vvp to generate wcd wave file
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);
    end
    // reverse clk every 5 time unit
    always #5 clk = ~clk;
endmodule
