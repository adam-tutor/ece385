/*
module pacman_mapper (
	input logic [9:0] DrawX, DrawY, BallX, BallY, Ball_Size, Ghost_X, Ghost_Y, Ghost_X2, Ghost_Y2, Ghost_X3, Ghost_Y3, Ghost_X4, Ghost_Y4,
	input logic vga_clk, blank, switch, Clk,
	output logic [3:0] Red, Green, Blue,
	output logic [17:0] score
);

logic [16:0] rom_address;
logic [2:0] in;
logic ld;
logic [3:0] rom_q;
logic [3:0] palette_red, palette_green, palette_blue;
logic [3:0] red, green, blue;
logic [3:0] Pred, Pgreen, Pblue;

assign rom_address = (DrawX*320/640) + (DrawY*120/480 * 320);

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
	end
end

pacman_rom_write pacman_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.D			(in),
	.Load 	(ld),
	.q       (rom_q)
);

pacman_palette pacman_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
/*	 logic ball_on;
    logic [9:0] Size, SizeX;
	 always_comb begin
		Size = Ball_Size;
		SizeX = Ball_Size - 10'd6;
	 end
	 
    always_comb
    begin:Ball_on_proc
        if ((((BallX-SizeX) <= DrawX && DrawX <= (BallX+SizeX))) && (((BallY-Size) <= DrawY && DrawY <= (BallY+Size))))
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
    end      
    always_comb
    begin:RGB_Display
		if ((ball_on == 1'b1)) begin 
			if(Gred != 4'hF && Ggreen != 4'hF && Gblue != 4'h0) begin
            Red = red;
            Green = green;
            Blue = blue;
			end
			else begin
				Red = Gred; 
            Green = Ggreen;
            Blue = Gblue;
			end
		end
		else if(ghost_on == 1'b1)begin
			Red = Gred; 
			Green = Ggreen;
         Blue = Gblue;
		end	
		else if(ghost_on2 == 1'b1)begin
			Red = Gred; 
			Green = Ggreen;
         Blue = Gblue;
		end
		else if(ghost_on3 == 1'b1)begin
			Red = Gred; 
			Green = Ggreen;
         Blue = Gblue;
		end
		else if(ghost_on4 == 1'b1)begin
			Red = Gred; 
			Green = Ggreen;
         Blue = Gblue;
		end		
		else begin 
			if(DrawX < 419 && DrawX > 209) begin
            Red = red; 
            Green = green;
            Blue = blue;
			end
			else begin
				Red = 4'h0;
				Green = 4'h0;
				Blue = 4'h0;
			end      
		end 
	end 
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
/*	logic ghost_on, ghost_on2, ghost_on3, ghost_on4;
	logic [9:0] GhostX, GhostY;	
   logic [3:0] Gred, Ggreen, Gblue;

    always_comb
    begin:ghost_on_proc
        if ((((Ghost_X-SizeX) <= DrawX && DrawX <= (Ghost_X+SizeX))) && (((Ghost_Y-Size) <= DrawY && DrawY <= (Ghost_Y+Size))))
            ghost_on = 1'b1;
        else 
            ghost_on = 1'b0;
		  if ((((Ghost_X2-SizeX) <= DrawX && DrawX <= (Ghost_X2+SizeX))) && (((Ghost_Y2-Size) <= DrawY && DrawY <= (Ghost_Y2+Size))))
            ghost_on2 = 1'b1;
        else 
            ghost_on2 = 1'b0;
		  if ((((Ghost_X3-SizeX) <= DrawX && DrawX <= (Ghost_X3+SizeX))) && (((Ghost_Y3-Size) <= DrawY && DrawY <= (Ghost_Y3+Size))))
            ghost_on3 = 1'b1;
        else 
            ghost_on3 = 1'b0;
		  if ((((Ghost_X4-SizeX) <= DrawX && DrawX <= (Ghost_X4+SizeX))) && (((Ghost_Y4-Size) <= DrawY && DrawY <= (Ghost_Y4+Size))))
            ghost_on4 = 1'b1;
        else 
            ghost_on4 = 1'b0;
    end 

mux5_1_5 #(10) GHOSTXMUX(.d0(Ghost_X), .d1(Ghost_X2), .d2(Ghost_X3), .d3(Ghost_X4), .d4(BallX), .s({ball_on, ghost_on4, ghost_on3, ghost_on2, ghost_on}), .y(GhostX));

mux5_1_5 #(10) GHOSTYMUX(.d0(Ghost_Y), .d1(Ghost_Y2), .d2(Ghost_Y3), .d3(Ghost_Y4), .d4(BallY), .s({ball_on, ghost_on4, ghost_on3, ghost_on2, ghost_on}), .y(GhostY));

mux5_1_5 #(10) GHOSTYSPRITEMUX(.d0(10'd203), .d1(10'd244), .d2(10'd285), .d3(10'd325), .d4(10'd5), .s({ball_on, ghost_on4, ghost_on3, ghost_on2, ghost_on}), .y(Ysprite));

logic [9:0] GXcoord, GYcoord, GTLX, GTLY, Gadd, Ysprite;
logic [16:0] Grom_address;
logic [3:0] Grom_q;
	 
pacman_rom GR(
	.clock   (vga_clk),
	.address (Grom_address),
	.q       (Grom_q)
);

pacman_palette GC(
	.index (Grom_q),
	.red   (Gred),
	.green (Ggreen),
	.blue  (Gblue)
);

mux2_1 MUXG(.d0(10'd442), .d1(10'd424), .s(switch), .y(Gadd));
always_comb begin
GTLX = GhostX - 10'd8;
GTLY = GhostY - Ball_Size;
GXcoord = DrawX - GTLX; 
GYcoord = DrawY - GTLY;
Grom_address = ((GXcoord + Gadd)*320/640) + (((GYcoord + Ysprite))*120/480 * 320);
end

always_comb begin
	if(ball_on == 1'b1 && rom_q == 3'd5) begin
		ld = 1'b1;
		in = 3'd0;
	end
	else begin
		ld = 1'b0;
		in = 3'd0;
	end
					
end

always_ff @ (posedge vga_clk)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if(ld)
					score <= score + 1'd1;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else 
					score <= score;
		end

endmodule
*/
