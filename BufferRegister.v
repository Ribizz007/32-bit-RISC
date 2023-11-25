`timescale 1ns / 1ps

// Define a Verilog module named BufferRegister
// This module represents a buffer register with clock, clear, hold, input, and output signals
// The width of the input and output is specified by the parameter N
module BufferRegister(
    input clk,           // Clock input
    input clear,         // Clear signal input
    input hold,          // Hold signal input
    input wire [N-1:0] in, // Input data bus (width N)
    output reg [N-1:0] out // Output data bus (width N)
);

    // Always block triggered on the positive edge of the clock
    always @(posedge clk) begin
        // Check if the clear signal is active
        if (clear)
            // If clear is active, set the output to all zeros
            out <= {N{1'b0}};
        // Check if the hold signal is active
        else if (hold)
            // If hold is active, maintain the current output value
            out <= out;
        else
            // If neither clear nor hold is active, update the output with the input value
            out <= in;
    end
endmodule
