module pacman_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0}; //black
	palette[01] = {4'hF, 4'hB, 4'hF}; //pink
	palette[02] = {4'h0, 4'hA, 4'hE}; //cyan
	palette[03] = {4'hF, 4'h7, 4'h1}; //orange
	palette[04] = {4'h0, 4'h1, 4'hB}; //blue
	palette[05] = {4'hF, 4'hF, 4'hF}; //white
	palette[06] = {4'hF, 4'hF, 4'h0}; //yellow
	palette[07] = {4'hE, 4'h0, 4'h1}; //red
end

endmodule
