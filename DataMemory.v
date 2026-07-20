module data_memory #(parameter WIDTH=32, DEPTH=64)
(
	input wire clk,							// clock signal
	input wire rst_n,						// active low reset signal
	input wire [WIDTH-1:0]   addr, 			// address input
	input wire [WIDTH-1:0] write_data, 		// i/p data to be written to memory
	input wire MemWrite,					// control signal to write data to memory
	input wire writeenable,  				// control signal to enable writing to memory
	input wire MemRead,						// control signal to read data from memory
	output reg [WIDTH-1:0] read_data		// o/p data read from memory
);

reg [WIDTH-1:0] mem [0:DEPTH-1]; 		// memory 64×32 bits

always @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin					// Reset memory and the read_data output to 0 
		read_data <= 0;
		mem[addr] <= 0;
	end
	else if (MemWrite && writeenable) begin
		mem[addr[7:2]] <= write_data;  // Store data in memory at the specified address, and can't be variable width, so we use addr[7:2] to index
	end
	else if (MemRead) begin				// Read data from memory o/p at specified address from 2 to 7 bits, as we have 64 locations, so we need 6 bits to address them, and the lower 2 bits are ignored since we are reading 32-bit words
		read_data <= mem[addr[7:2]];
	end
end
endmodule