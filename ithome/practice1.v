module practice1 (
    input clk,
    input reset,
    input a,
    input b,
    output c
);
  wire tamp1;
    wire tamp2;

    reg tamp3;
    assign tamp1 = a & b;
    assign tamp2 = a | b;
    assign c = tamp3;
    // D Flip-Flop with active-high reset
    always @ (posedge clk) begin
        if(reset) // if reset is 1, set tamp3 to 0
            tamp3 <= 0;
        else
            tamp3 <= ~(tamp1 ^ tamp2); // xnor
    end  
endmodule
