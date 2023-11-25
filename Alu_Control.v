`timescale 1ns / 1ps

module Alu_Control(
    input      [31:0] instruction,  // Input instruction
    input      [2:0]  ALUOp,         // Input ALU operation code
    output reg [5:0]  ALUFn           // Output ALU function code
);

always @(instruction or ALUOp)
begin
    // ALU control logic based on ALUOp and instruction
    if (ALUOp == 3'b010) begin
        // If ALUOp is '010', use the lower 6 bits of the instruction as ALUFn
        ALUFn <= instruction[5:0];
    end else if (ALUOp == 3'b000) begin
        // If ALUOp is '000', set ALUFn to '000000' for ADD operation
        ALUFn <= 6'b000000;
    end else if (ALUOp == 3'b001) begin
        // If ALUOp is '001', set ALUFn to '000001' for SUB operation
        ALUFn <= 6'b000001;
    end else if (ALUOp == 3'b011) begin
        // If ALUOp is '011', set ALUFn to '000000' (default case)
        ALUFn <= 6'b000000;
    end else if (ALUOp == 3'b100) begin
        // If ALUOp is '100', set ALUFn to '000100' for MUL operation
        ALUFn <= 6'b000100;
    end else if (ALUOp == 3'b101) begin
        // If ALUOp is '101', set ALUFn to '000110' for logical operations (e.g., AND, OR)
        ALUFn <= 6'b000110;
    end else if (ALUOp == 3'b110) begin
        // If ALUOp is '110', set ALUFn to '001011' for shift and comparison operations
        ALUFn <= 6'b001011;
    end
end

endmodule
