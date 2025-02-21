module pacman_rom_write (
	input logic clock,
	input logic [15:0] address,
	input [2:0] D,
	input Load,
	output logic [2:0] q
);

logic [2:0] memory [0:38399] /* synthesis ram_init_file = "./pacman/pacman.mif" */;

always_ff @ (posedge clock) begin
	if(Load) begin
					memory[address] <= D;
				end
	else begin
					q <= memory[address];
	end
end

endmodule