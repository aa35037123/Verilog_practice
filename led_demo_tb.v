`timescale 1ns/100 ps

module led_demo_tb;

parameter SYSCLK_PERIOD = 10;

reg SYSCLK;
reg NSYSRESET;

initial
begin
    SYSCLK = 1'b0; 
    NSYSRESET = 1'b0;
end
/*iverilog */
initial 
begin
    $dumpfile("wave.vcd");
    $dumpvars(0, led_demo_tb);
end
/*iverilog */
initial
begin
    // introduces a delay before executing the following statement. 
    // The delay is SYSCLK_PERIOD * 10releasing the reset condition of the system 
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b1;//releasing the reset condition of the system 
    #1000 // After setting NSYSRESET, this line introduces another delay, this time for 1000 time units
        $stop;
end

always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;

led_demo led_demo_ut0 (
    // Inputs
    .rst_n(NSYSRESET),
    .clk(SYSCLK),

    // Outputs
    .led( led)
);

endmodule