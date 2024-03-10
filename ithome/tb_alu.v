`timescale 1ns/100ps
module testbench;
    // input
    reg clk;
    reg reset;
    reg [7:0] in1;
    reg [7:0] in2;
    reg in_valid;
    reg [1:0] alu_op;
    //output
    wire [7:0] result;
    wire out_valid;
    // internal parameter 
    // reg [3:0] idx;
    // This block executes once at the beginning of the simulation
    // initial execute from top to bottom
    initial begin
        clk = 0;
        reset = 0;
        in1 = 0;
        in2 = 0;
        in_valid = 0; 
        alu_op = 0;
        // #10 means 10 time unit passed
        #10;
        reset = 1;
        #20;
        reset = 0;
        // passed through 1 whole clk time
        // @(posedge clk);
        // in1 = 0;
        // in2 = 0;
        // in_valid = 1;
        case1;
        $finish; // end of testbench
    end
    initial begin // need for vvp to generate wcd wave file
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);
    end
    alu_8bit uut(
        // 左邊的clk是adder裡面宣告input的clk，而括弧內的clk為testbench所產生的clk
        .clk(clk),
        .reset(reset),
        .in_valid(in_valid),
        .in1(in1),
        .in2(in2),  
        .alu_op(alu_op),
        .out_valid(out_valid),
        .result(result)  
    );
    // reverse clk every 5 time unit
    always #5 clk = ~clk;
    // internal argument for task
    reg [3:0] idx;
    task case1; begin
        for(idx = 0; idx < 10; idx = idx + 1) begin
            @(posedge clk); // wait for the positive edge for the clock
            in1 = $random % 'd16;
            in2 = $random % 'd16 + 1;
            alu_op = $random % 'd4;
            in_valid = 1;
            @(posedge clk);
            in1 = 0;
            in2 = 0;
            in_valid = 0; 
            // wait until out_valid become 1 before moving on
            while (out_valid != 1) begin
                @(posedge clk);
            end
            $display("%d'th result = %d\n", idx, $signed(result));
        end
        repeat(5) @(posedge clk);
    end endtask
endmodule