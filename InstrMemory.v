module instr_memory #(parameter WIDTH=32, DEPTH=64)
(
	input wire [WIDTH-1:0] addr,		// address i/p
	output reg [WIDTH-1:0] instr		// o/p instruction 
);

reg [WIDTH-1:0] mem [0:DEPTH-1];		// memory 64×32 bits

always @(*) begin
	instr = mem[addr[7:2]];				// Read instruction from memory o/p at specified address from 2 to 7 bits, as we have 64 locations, so we need 6 bits to address them, and the lower 2 bits are ignored since we are reading 32-bit words
end
endmodule
