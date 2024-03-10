module counter(
    input clk,
    input reset,
    input a,
    output c
);

reg[3:0] counter;
reg [7:0] temp;
always @(posedge clk)begin
    if(reset)
        counter <= 0;
    else  
        counter <= (counter == 10) ? counter : counter + 1//if counter is 10, then counter = counter, else counter = counter + 1
end
always @(posedge clk) begin
    if(reset)
        temp <= 0;
    else if(counter < 10)
        temp <= temp + counter;
end
endmodule