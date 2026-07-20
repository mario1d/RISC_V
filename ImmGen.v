module imm_gen #(parameter WIDTH=32, FIELD_WIDTH=7, tens_bits=20)
(
    input wire [WIDTH-1:FIELD_WIDTH] instr,		     // instruction [31:7] bits, as we are ignoring the lower 7 bits since they are not part of the immediate value
    input wire [1:0]       imm_src,		    // control signal to select the type of immediate value to be generated (e.g., I-type, S-type, B-type, U-type, J-type)
    output reg [WIDTH-1:0] imm_out		   // o/p immediate value 
);

always @(*) begin
    case (imm_src)
        2'b00: imm_out = {{20{instr[WIDTH-1]}}, instr[WIDTH-1:tens_bits]};                                    // I-type immediate value
        2'b01: imm_out = {{20{instr[WIDTH-1]}}, instr[WIDTH-1:FIELD_WIDTH+5], instr[FIELD_WIDTH+4:FIELD_WIDTH]};        // S-type immediate value
        2'b10: imm_out = {{19{instr[WIDTH-1]}}, instr[WIDTH-1], instr[FIELD_WIDTH], instr[WIDTH-2:tens_bits], instr[FIELD_WIDTH+4:FIELD_WIDTH+1], 1'b0};  // B-type immediate value
        2'b11: imm_out = {{12{instr[WIDTH-1]}}, instr[tens_bits-1:FIELD_WIDTH+5], instr[tens_bits], instr[WIDTH-2:tens_bits+1], 1'b0};                   // J-type immediate value
        default: imm_out = 32'b0;                     // Default case to handle unexpected values of imm_src to avoid latches
    endcase
end
endmodule