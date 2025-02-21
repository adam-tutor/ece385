module pacman_board_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [8];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0}; //Black
	palette[01] = {4'h0, 4'h0, 4'hB}; //Blue
	palette[02] = {4'hF, 4'hE, 4'h0}; //Yellow
	palette[03] = {4'hF, 4'hE, 4'hF}; //White
	palette[04] = {4'hE, 4'h0, 4'h2}; //Red
	palette[05] = {4'h0, 4'h0, 4'h0}; //Black
	palette[06] = {4'h0, 4'h0, 4'h0}; //Black	
	palette[07] = {4'h0, 4'h0, 4'h0}; //Black
end

endmodule
