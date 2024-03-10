module test(    
    input a,
    input reset,
    input clk,
    output c
);
reg counter;
reg[31:0] matrix[8:0];
reg idx;
always @(posedge clk) begin
    if(reset)
        for(idx =0; idx < 9;idx = idx +1 )begin
            matrix[idx] <= 0;
        end
end

always @(posedge clk) begin
    if(reset)begin
        counter <= 0;
    end
    else begin
        case(a) // put variable a in case statement
            0: counter <= counter + 1;
            1: counter <= counter - 1;
            default: counter <= 0;
        endcase
    end
end
endmodule
