module pacman_mapper (
	input logic [9:0] DrawX, DrawY, BallXs, BallYs, Ball_Size, Ghost_Xs, Ghost_Ys, Ghost_X2s, Ghost_Y2s, Ghost_X3s, Ghost_Y3s, Ghost_X4s, Ghost_Y4s,
	input logic vga_clk, blank, switch, Clk, Reset,
	output logic [3:0] Red, Green, Blue,
	output logic [11:0] score,
	output logic [20:0] stop,
	output logic Pon, G1on, G2on, G3on, G4on
);

logic [16:0] rom_address;
logic [3:0] in;
logic ld;
logic [3:0] rom_q;
logic [3:0] palette_red, palette_green, palette_blue;
logic [9:0] BallX, BallY, Ghost_X, Ghost_Y, Ghost_X2, Ghost_Y2, Ghost_X3, Ghost_Y3, Ghost_X4, Ghost_Y4;

always_ff @ (posedge vga_clk) begin
	if (stop != 1'd0) begin
		BallX <= BallX;
		BallY <= BallY;
		Ghost_X <= Ghost_X;
		Ghost_Y <= Ghost_Y;
		Ghost_X2 <= Ghost_X2;
		Ghost_Y2 <= Ghost_Y2;
		Ghost_X3 <= Ghost_X3;
		Ghost_Y3 <= Ghost_Y3;
		Ghost_X4 <= Ghost_X4;
		Ghost_Y4 <= Ghost_Y4;
	end
	else begin
		BallX <= BallXs;
		BallY <= BallYs;
		Ghost_X <= Ghost_Xs;
		Ghost_Y <= Ghost_Ys;
		Ghost_X2 <= Ghost_X2s;
		Ghost_Y2 <= Ghost_Y2s;
		Ghost_X3 <= Ghost_X3s;
		Ghost_Y3 <= Ghost_Y3s;
		Ghost_X4 <= Ghost_X4s;
		Ghost_Y4 <= Ghost_Y4s;
	end
end

always_ff @ (posedge vga_clk) begin
	if (Pon && (G1on || G2on || G3on || G4on)) begin
		stop <= stop + 1'd1;
	end
	else begin
		stop <= 1'd0;
	end
end




always_comb begin
rom_address = (DrawX*320/640) + (DrawY*120/480 * 320);
end

always_ff @ (posedge vga_clk) begin //change
	Red <= 4'h0;
	Green <= 4'h0;
	Blue <= 4'h0;

	if (blank) begin
		if ((ball_on == 1'b1)) begin 
			if(Gred == 4'hE && Ggreen == 4'h0 && Gblue == 4'hF) begin //Background
				if(rom_q == 2'd2)begin
				Red <= 4'h0;
				Green <= 4'h0;
				Blue <= 4'h0;
				end
				else begin
            Red <= palette_red;
            Green <= palette_green;
            Blue <= palette_blue;
				end
			end
			else begin
				Red <= Gred; 
            Green <= Ggreen;
            Blue <= Gblue;
			end
		end
		else if(ghost_on == 1'b1)begin
			if(Gred == 4'hE && Ggreen == 4'h0 && Gblue == 4'hF) begin
           if(rom_q == 2'd2)begin
				Red <= 4'h0;
				Green <= 4'h0;
				Blue <= 4'h0;
				end
				else begin
            Red <= palette_red;
            Green <= palette_green;
            Blue <= palette_blue;
				end
			end
			else begin
				Red <= Gred; 
            Green <= Ggreen;
            Blue <= Gblue;
			end
		end	
		else if(ghost_on2 == 1'b1)begin
			if(Gred == 4'hE && Ggreen == 4'h0 && Gblue == 4'hF) begin
            if(rom_q == 2'd2)begin
				Red <= 4'h0;
				Green <= 4'h0;
				Blue <= 4'h0;
				end
				else begin
            Red <= palette_red;
            Green <= palette_green;
            Blue <= palette_blue;
				end
			end
			else begin
				Red <= Gred; 
            Green <= Ggreen;
            Blue <= Gblue;
			end
		end
		else if(ghost_on3 == 1'b1)begin
			if(Gred == 4'hE && Ggreen == 4'h0 && Gblue == 4'hF) begin
           if(rom_q == 2'd2)begin
				Red <= 4'h0;
				Green <= 4'h0;
				Blue <= 4'h0;
				end
				else begin
            Red <= palette_red;
            Green <= palette_green;
            Blue <= palette_blue;
				end
			end
			else begin
				Red <= Gred; 
            Green <= Ggreen;
            Blue <= Gblue;
			end
		end
		else if(ghost_on4 == 1'b1)begin
			if(Gred == 4'hE && Ggreen == 4'h0 && Gblue == 4'hF) begin
            if(rom_q == 2'd2)begin
				Red <= 4'h0;
				Green <= 4'h0;
				Blue <= 4'h0;
				end
				else begin
            Red <= palette_red;
            Green <= palette_green;
            Blue <= palette_blue;
				end
			end
			else begin
				Red <= Gred; 
            Green <= Ggreen;
            Blue <= Gblue;
			end
		end		
		else begin 
			if(DrawX < 419 && DrawX > 209) begin
            Red <= palette_red; 
            Green <= palette_green;
            Blue <= palette_blue;
			end
			else begin
				Red <= 4'h0;
				Green <= 4'h0;
				Blue <= 4'h0;
			end      
		end 
	end
end

pacman_board_rom_write pacman_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.D			(in),
	.Load 	(ld),
	.q       (rom_q)
);

pacman_board_palette pacman_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
	 logic ball_on;
    int Size, SizeX, DistY_Ball, DistX_Ball;
	 always_comb begin
		Size = Ball_Size;
		SizeX = Ball_Size - 10'd6;
		DistX_Ball = BallX-SizeX;
		DistY_Ball = BallY-Size;
	 end
	 
    always_comb
    begin:Ball_on_proc
        if ((((DistX_Ball) <= DrawX && DrawX <= (BallX+SizeX))) && (((DistY_Ball) <= DrawY && DrawY <= (BallY+Size))))
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
    end

	 int DistX, DistY, Size_Sphere;
	 logic sphere_on;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size_Sphere = 10'd6;
	  
    always_comb
    begin:Sphere_On_Proc
        if ( ( DistX*DistX + DistY*DistY) <= (Size_Sphere * Size_Sphere) ) 
            sphere_on = 1'b1;
        else 
            sphere_on = 1'b0;
     end 	 
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
	logic ghost_on, ghost_on2, ghost_on3, ghost_on4;
	logic [9:0] GhostX, GhostY;	
   logic [3:0] Gred, Ggreen, Gblue;
	int DistY_G, DistX_G, DistY_G2, DistX_G2, DistY_G3, DistX_G3, DistY_G4, DistX_G4;
	assign DistY_G = Ghost_Y-Size;
	assign DistX_G = Ghost_X-SizeX;
	assign DistY_G2 = Ghost_Y2-Size;
	assign DistX_G2 = Ghost_X2-SizeX;
	assign DistY_G3 = Ghost_Y3-Size;
	assign DistX_G3 = Ghost_X3-SizeX;
	assign DistY_G4 = Ghost_Y4-Size;
	assign DistX_G4 = Ghost_X4-SizeX;

    always_comb
    begin:ghost_on_proc
        if ((((DistX_G) <= DrawX && DrawX <= (Ghost_X+SizeX))) && (((DistY_G) <= DrawY && DrawY <= (Ghost_Y+Size))))
            ghost_on = 1'b1;
        else 
            ghost_on = 1'b0;
		  if ((((DistX_G2) <= DrawX && DrawX <= (Ghost_X2+SizeX))) && (((DistY_G2) <= DrawY && DrawY <= (Ghost_Y2+Size))))
            ghost_on2 = 1'b1;
        else 
            ghost_on2 = 1'b0;
		  if ((((DistX_G3) <= DrawX && DrawX <= (Ghost_X3+SizeX))) && (((DistY_G3) <= DrawY && DrawY <= (Ghost_Y3+Size))))
            ghost_on3 = 1'b1;
        else 
            ghost_on3 = 1'b0;
		  if ((((DistX_G4) <= DrawX && DrawX <= (Ghost_X4+SizeX))) && (((DistY_G4) <= DrawY && DrawY <= (Ghost_Y4+Size))))
            ghost_on4 = 1'b1;
        else 
            ghost_on4 = 1'b0;
    end 

mux5_1_5 #(10) GHOSTXMUX(.d0(Ghost_X), .d1(Ghost_X2), .d2(Ghost_X3), .d3(Ghost_X4), .d4(BallX), .s({ball_on, ghost_on4, ghost_on3, ghost_on2, ghost_on}), .y(GhostX));

mux5_1_5 #(10) GHOSTYMUX(.d0(Ghost_Y), .d1(Ghost_Y2), .d2(Ghost_Y3), .d3(Ghost_Y4), .d4(BallY), .s({ball_on, ghost_on4, ghost_on3, ghost_on2, ghost_on}), .y(GhostY));

mux5_1_5 #(10) GHOSTYSPRITEMUX(.d0(10'd203), .d1(10'd244), .d2(10'd285), .d3(10'd325), .d4(10'd5), .s({ball_on, ghost_on4, ghost_on3, ghost_on2, ghost_on}), .y(Ysprite));

int GXcoord, GYcoord, GTLX, GTLY, Gadd, Ysprite;
logic [16:0] Grom_address;
logic [3:0] Grom_q;
	 
pacman_sprite_rom GR(
	.clock   (vga_clk),
	.address (Grom_address),
	.q       (Grom_q)
);

pacman_sprite_palette GC(
	.index (Grom_q),
	.red   (Gred),
	.green (Ggreen),
	.blue  (Gblue)
);

mux2_1 MUXG(.d0(10'd442), .d1(10'd422), .s(switch), .y(Gadd));
always_comb begin
GTLX = GhostX - 10'd8;
GTLY = GhostY - Ball_Size;
GXcoord = DrawX - GTLX; 
GYcoord = DrawY - GTLY;
Grom_address = ((GXcoord + Gadd)*320/640) + (((GYcoord + Ysprite))*120/480 * 320);
end

always_comb begin
	if(sphere_on == 1'b1 && rom_q == 2'd2) begin
		ld = 1'b1;
		in = 3'd0;
	end
	else begin
		ld = 1'b0;
		in = 3'd0;
	end
					
end

//logic [17:0] testscore;

always_ff @ (posedge vga_clk)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if((ld == 1'b1) && (in == 3'd0))
					score <= score + 1'd1;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else 
					score <= score;
		end

		/*
always_ff @ (posedge Clk) begin
	if((testscore > 18'd100) && sphere_on == 1'b1 && rom_q == 2'd2) begin
	score <= score + 1'd1;
	testscore <= 18'd0;
	end
	else begin
	score <= score;
	end
end
*/
assign Pon = ball_on;
assign G1on = ghost_on;
assign G2on = ghost_on2;
assign G3on = ghost_on3;
assign G4on = ghost_on4;

endmodule

