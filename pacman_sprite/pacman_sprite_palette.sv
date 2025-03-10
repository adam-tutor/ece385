module pacman_sprite_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hE, 4'h0, 4'hF}; //BACKGROUND
	palette[01] = {4'hE, 4'hE, 4'h0}; //YELLOW
	palette[02] = {4'hE, 4'hA, 4'hF}; //PINK
	palette[03] = {4'hE, 4'h1, 4'h1}; //RED
	palette[04] = {4'h0, 4'h9, 4'hE}; //CYAN
	palette[05] = {4'hE, 4'h7, 4'h1}; //ORANGE
	palette[06] = {4'h1, 4'h1, 4'hB}; //BLUE
	palette[07] = {4'hF, 4'hE, 4'hF}; //WHITE
end

endmodule
