module alu_8bit(
    input clk,
    input reset,
    input in_valid,
    input [7:0] in1,
    input [7:0] in2,
    input [1:0] alu_op,
    output reg out_valid,
    output reg[7:0] result
);
    // Temporary register to store the intermediate result
    reg [16:0] temp_result;

    always @(posedge clk) begin
        if(reset) begin
            result <= 0;
            out_valid <= 0;
        end
        else if(in_valid) begin
            case(alu_op)
                2'b00: temp_result = in1 + in2; //Addition
                2'b01: temp_result = in1 - in2; //Substraction
                2'b10: temp_result = in1 * in2; //multiplication
                2'b11: temp_result = in1 / in2; //division
                default: temp_result = 16'bx; // x stands for "unknown" in Verilog
            endcase
            // Set result with the lower 8 bits of the computation
            result <= temp_result[7:0];
            // Set the validity of the output
            out_valid <= 1'b1;
        end
        else begin
            // Clear out_valid when input is not valid
            out_valid <= 1'b0; 
        end
    end
endmodule