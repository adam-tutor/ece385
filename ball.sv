module  ball ( input Reset, frame_clk, vga_clk,
					input [7:0] keycode,
               output [9:0]  BallX, BallY, BallS, 
					output D,
					input logic Pon, G1on, G2on, G3on, G4on
					);
  
    int Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 logic [16:0] Border_rom_address, Border_rom_address2;
	 logic [1:0] select;
	 logic [2:0] Brom_q, Brom_q2;
	 int Up, Down, Left, Right;
	 logic [9:0] Y_rom, X_rom, Y_rom2, X_rom2;
	 logic Direction;
	 logic stop;
	 
    parameter [9:0] Ball_X_Center=318;  // Center position on the X axis //320
    parameter [9:0] Ball_Y_Center=272;  // Center position on the Y axis //272
    

    assign Ball_Size = 14;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
always_comb begin
	Up = Ball_Y_Pos - 10'd16;
	Down = Ball_Y_Pos + 10'd16;
	Left = Ball_X_Pos - 10'd11;
	Right = Ball_X_Pos + 10'd10;
	Border_rom_address = ((X_rom)*320/640) + ((Y_rom)*120/480 * 320);
	Border_rom_address2 = ((X_rom2)*320/640) + ((Y_rom2)*120/480 * 320);
end

 
pacman_board_rom Borderrom(.clock(vga_clk), .address(Border_rom_address), .q(Brom_q));
pacman_board_rom Borderrom2(.clock(vga_clk), .address(Border_rom_address2), .q(Brom_q2));

mux4_1 #(10) XMUX(.d0(Left + 10'd3), .d1(Left + 10'd3), .d2(Left), .d3(Right), .s(select), .y(X_rom));
mux4_1 #(10) YMUX(.d0(Up), .d1(Down), .d2(Up + 10'd3), .d3(Up + 10'd3), .s(select), .y(Y_rom));

mux4_1 #(10) XMUX2(.d0(Right - 10'd3), .d1(Right - 10'd3), .d2(Left), .d3(Right), .s(select), .y(X_rom2));
mux4_1 #(10) YMUX2(.d0(Up), .d1(Down), .d2(Down - 10'd3), .d3(Down - 10'd3), .s(select), .y(Y_rom2));

always_comb begin
	if((Ball_Y_Motion == 10'd0) && (Ball_X_Motion == 10'd0)) begin
		if(keycode == 8'h04) begin 
		//A
		select = 2'd2;
		end
		else if(keycode == 8'h07) begin
		//D
		select = 2'd3;
		end
		else if(keycode == 8'h16) begin
		//S
		select = 2'd1;
		end
		else if(keycode == 8'h1A) begin
		//W
		select = 2'd0;
		end
		else begin
		select = 2'd0;
		end
	end
	else if (Ball_Y_Motion == 10'd1)begin
		select = 2'd1;
	end
	else if (Ball_Y_Motion == (-10'd1))begin
		select = 2'd0;
	end
	else if (Ball_X_Motion == 10'd1)begin
		select = 2'd3;
	end
	else if (Ball_X_Motion == (-10'd1))begin
		select = 2'd2;
	end
	else begin
	select = 2'd0;
	end
end


always_comb begin
	Direction = 1'b1;
	if(Brom_q == 2'd1 || Brom_q2 == 2'd1) begin
		Direction = 1'b0;
	end
end

    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end   
        else 
        begin 
			if(Direction == 1'b0) begin 
			Ball_X_Motion <= 10'd0;
			Ball_Y_Motion <= 10'd0;
			end
				 case (keycode)
					8'h04 : begin
								if(Brom_q == 2'd1 || Brom_q2 == 2'd1) begin
								Ball_X_Motion <= 10'd0;//A
								Ball_Y_Motion<= 10'd0;
								end
								else begin
								Ball_X_Motion <= -10'd1;//A
								Ball_Y_Motion<= 10'd0;
								end
							  end
					        
					8'h07 : begin
								if(Brom_q == 2'd1 || Brom_q2 == 2'd1) begin
								Ball_X_Motion <= 10'd0;//D
								Ball_Y_Motion<= 10'd0;
								end
							  else begin
					        Ball_X_Motion <= 10'd1;//D
							  Ball_Y_Motion <= 10'd0;
							  end
							  end

							  
					8'h16 : begin
							  if(Brom_q == 2'd1 || Brom_q2 == 2'd1) begin
								Ball_X_Motion <= 10'd0;//S
								Ball_Y_Motion<= 10'd0;
								end
							  else begin
					        Ball_Y_Motion <= 10'd1;//S
							  Ball_X_Motion <= 10'd0;
							  end
							 end
							  
					8'h1A : begin
							  if(Brom_q == 2'd1 || Brom_q2 == 2'd1) begin
								Ball_X_Motion <= 10'd0;//W
								Ball_Y_Motion<= 10'd0;
								end
							  else begin
					        Ball_Y_Motion <= -10'd1;//W
							  Ball_X_Motion <= 10'd0;
							  end
							 end	  
					default: ;
			   endcase
				
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				 
			
		end  
    end	
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
	 
	 assign D = Direction;
    

endmodule
