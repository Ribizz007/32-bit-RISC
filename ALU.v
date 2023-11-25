`timescale 1ns / 1ps

module ALU(clk, a, b, alufn, otp, zero, overflow);
    // Inputs
    input wire clk;
    input wire [31:0] a;
    input wire [31:0] b;
    input wire [5:0] alufn; // 6-bit operation code
    // Outputs
    output reg [31:0] otp;
    output reg zero;       // Set if the output of the ALU is 0
    output reg overflow;   // Overflow flag
    // Internal wires for temporary results and flags
    wire [31:0] tempAuRes, tempLuRes, tempSuRes;
    wire tempAuZero, tempAuOverflow;
    wire tempLuZero, tempLuOverflow;
    wire tempSuZero, tempSuOverflow;

    // ALU operation selection based on the operation code (alufn)
    always @(a or b or alufn)
    begin
        casex(alufn)
            // Arithmetic operations
            6'b0000xx: begin
                if (alufn[1:0] == 2'b00) begin // ADD
                    otp = a + b;
                    zero = (otp == 0) ? 1 : 0;
                    overflow = ((a >= 0 && b >= 0 && otp < 0) || (a < 0 && b < 0 && otp >= 0)) ? 1 : 0;
                end
                else if (alufn[1:0] == 2'b01) begin // SUB
                    otp = a - b;
                    zero = (otp == 0) ? 1 : 0;
                    overflow = ((a >= 0 && b < 0 && otp < 0) || (a < 0 && b >= 0 && otp > 0)) ? 1 : 0;
                end
                else if (alufn[1:0] == 2'b10) begin // MUL
                    otp = a * b;
                    zero = (otp == 0) ? 1 : 0;
                    overflow = 0;
                end
            end
            // Logical operations
            6'b0001xx: begin
                case (alufn[1:0])
                    2'b00: otp = a & b; // AND
                    2'b01: otp = a | b; // OR
                    2'b10: otp = a ^ b; // XOR
                endcase
                zero = (otp == 0) ? 1 : 0;
                overflow = 0;
            end
            // Shift and comparison operations
            6'b0010xx: begin
                case (alufn[1:0])
                    2'b00: otp = a << b; // SHIFTLEFT
                    2'b01: otp = a >> b; // SHIFTRIGHT
                    2'b11: otp = (a < b) ? 1 : 0; // SLT
                endcase
                zero = (otp == 0) ? 1 : 0;
                overflow = 0;
            end
            default: otp = {32{1'b0}}; // Default case
        endcase
        $display("a%h - b%h - otp %h alufn %b", a, b, otp, alufn);
    end

endmodule

// Separate modules for ArithmeticUnit, LogicalUnit, and ShiftUnit

module ArithmeticUnit(a, b, alufn, otp, zero, overflow);
    // Similar structure as the corresponding section in the ALU module
    // Handles arithmetic operations
endmodule

module LogicalUnit(a, b, otp, alufn, zero, overflow);
    // Similar structure as the corresponding section in the ALU module
    // Handles logical operations
endmodule

module ShiftUnit(a, b, otp, alufn, zero, overflow);
    // Similar structure as the corresponding section in the ALU module
    // Handles shift and comparison operations
endmodule
