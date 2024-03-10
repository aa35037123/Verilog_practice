module always_behavior(
    input clk,

    input [7:0]a,
    input [7:0]b,

    output reg[7:0]c,
    output reg[7:0]d
);
    always@(posedge clk)begin
        c <= a + b;
    end
    always @(a or b) begin
        d = a + b;
    end
    endmodule