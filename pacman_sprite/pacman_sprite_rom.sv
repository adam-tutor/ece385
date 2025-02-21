module pacman_sprite_rom (
	input logic clock,
	input logic [15:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:38399] /* synthesis ram_init_file = "./pacman_sprite/pacman_sprite.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
