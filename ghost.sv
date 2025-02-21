module  ghost ( input Reset, frame_clk, vga_clk,
						input logic [9:0] DrawX,
						input logic [11:0]  Score,
						output logic [9:0]  GhostX, GhostY,
						output logic [9:0]  GhostX2, GhostY2,
						output logic [9:0]  GhostX3, GhostY3,
						output logic [9:0]  GhostX4, GhostY4,
						input logic Pon, G1on, G2on, G3on, G4on
					 );
  
    int Ghost_X_Pos, Ghost_X_Motion, Ghost_Y_Pos, Ghost_Y_Motion, Ball_Size;
	 int Ghost_X_Pos2, Ghost_X_Motion2, Ghost_Y_Pos2, Ghost_Y_Motion2;
	 int Ghost_X_Pos3, Ghost_X_Motion3, Ghost_Y_Pos3, Ghost_Y_Motion3;
	 int Ghost_X_Pos4, Ghost_X_Motion4, Ghost_Y_Pos4, Ghost_Y_Motion4;
	 logic stop;
	 logic [3:0] Enable;
	 logic [1:0] Random, rand2, rand3, rand4;
	 
	 parameter [9:0] Ghost_X_Center =305;
	 parameter [9:0] Ghost_Y_Center =205; 
	
	 parameter [9:0] Ghost_X_Center2 =326;
	 parameter [9:0] Ghost_Y_Center2 =205;
	
	 parameter [9:0] Ghost_X_Center3 =305;
	 parameter [9:0] Ghost_Y_Center3 =234; 
	
	 parameter [9:0] Ghost_X_Center4 =326;
	 parameter [9:0] Ghost_Y_Center4 =234;	

    assign Ball_Size = 14;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign Random = DrawX;
	 assign rand2 = DrawX + 2'd3;
	 assign rand3 = DrawX - 2'd1;
	 assign rand4 = DrawX - 2'd3;
	 
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////	 
	 
	 logic [15:0] Border_rom_address;
	 logic [1:0] select;
	 logic [2:0] Brom_q;	//CHANGE
	 int Up, Down, Left, Right; 
	 logic [9:0] Y_rom, X_rom;
	 logic Direction;
	 
	 mux4_1 #(10) XMUX(.d0(Ghost_X_Pos), .d1(Ghost_X_Pos), .d2(Left), .d3(Right), .s(select), .y(X_rom));
	 mux4_1 #(10) YMUX(.d0(Up), .d1(Down), .d2(Ghost_Y_Pos), .d3(Ghost_Y_Pos), .s(select), .y(Y_rom));
	
	always_comb begin
		Up = Ghost_Y_Pos - 10'd16;
		Down = Ghost_Y_Pos + 10'd16;
		Left = Ghost_X_Pos - 10'd12;
		Right = Ghost_X_Pos + 10'd10;
		Border_rom_address = ((X_rom)*320/640) + ((Y_rom)*120/480 * 320);
	end
 
	pacman_board_rom Borderrom(.clock(vga_clk), .address(Border_rom_address), .q(Brom_q));
	
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////	 
	
	 logic [15:0] Border_rom_address2;
	 logic [1:0] select2;
	 logic [2:0] Brom_q2;
	 int Up2, Down2, Left2, Right2; 
	 logic [9:0] Y_rom2, X_rom2;
	 logic Direction2;
	 
	 mux4_1 #(10) XMUX2(.d0(Ghost_X_Pos2), .d1(Ghost_X_Pos2), .d2(Left2), .d3(Right2), .s(select2), .y(X_rom2));
	 mux4_1 #(10) YMUX2(.d0(Up2), .d1(Down2), .d2(Ghost_Y_Pos2), .d3(Ghost_Y_Pos2), .s(select2), .y(Y_rom2));
	
	always_comb begin
		Up2 = Ghost_Y_Pos2 - 10'd16;
		Down2 = Ghost_Y_Pos2 + 10'd16;
		Left2 = Ghost_X_Pos2 - 10'd12;
		Right2 = Ghost_X_Pos2 + 10'd10;
		Border_rom_address2 = ((X_rom2)*320/640) + ((Y_rom2)*120/480 * 320);
	end
 
	pacman_board_rom Borderrom2(.clock(vga_clk), .address(Border_rom_address2), .q(Brom_q2));

	/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////	 
 
	 logic [15:0] Border_rom_address3;
	 logic [1:0] select3;
	 logic [2:0] Brom_q3;
	 int Up3, Down3, Left3, Right3;
	 logic [9:0] Y_rom3, X_rom3;
	 logic Direction3;
	 
	 mux4_1 #(10) XMUX3(.d0(Ghost_X_Pos3), .d1(Ghost_X_Pos3), .d2(Left3), .d3(Right3), .s(select3), .y(X_rom3));
	 mux4_1 #(10) YMUX3(.d0(Up3), .d1(Down3), .d2(Ghost_Y_Pos3), .d3(Ghost_Y_Pos3), .s(select3), .y(Y_rom3));
	
	always_comb begin
		Up3 = Ghost_Y_Pos3 - 10'd16;
		Down3 = Ghost_Y_Pos3 + 10'd16;
		Left3 = Ghost_X_Pos3 - 10'd12;
		Right3 = Ghost_X_Pos3 + 10'd10;
		Border_rom_address3 = ((X_rom3)*320/640) + ((Y_rom3)*120/480 * 320);
	end
 
	pacman_board_rom Borderrom3(.clock(vga_clk), .address(Border_rom_address3), .q(Brom_q3));

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////	 
 
	 logic [15:0] Border_rom_address4;
	 logic [1:0] select4;
	 logic [2:0] Brom_q4;
	 int Up4, Down4, Left4, Right4; 
	 logic [9:0] Y_rom4, X_rom4;
	 logic Direction4;
	 
	 mux4_1 #(10) XMUX4(.d0(Ghost_X_Pos4), .d1(Ghost_X_Pos4), .d2(Left4), .d3(Right4), .s(select4), .y(X_rom4));
	 mux4_1 #(10) YMUX4(.d0(Up4), .d1(Down4), .d2(Ghost_Y_Pos4), .d3(Ghost_Y_Pos4), .s(select4), .y(Y_rom4));
	
	always_comb begin
		Up4 = Ghost_Y_Pos4 - 10'd16;
		Down4 = Ghost_Y_Pos4 + 10'd16;
		Left4 = Ghost_X_Pos4 - 10'd12;
		Right4 = Ghost_X_Pos4 + 10'd10;
		Border_rom_address4 = ((X_rom4)*320/640) + ((Y_rom4)*120/480 * 320);
	end
 
	pacman_board_rom Borderrom4(.clock(vga_clk), .address(Border_rom_address4), .q(Brom_q4));
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
	
	always_comb begin
		
		if(Score > 10'd300) begin  
		Enable = 4'b1111;
		end
		else if(Score > 10'd200) begin  
		Enable = 4'b0111;
		end
		else if(Score > 10'd100) begin  
		Enable = 4'b0011;
		end
		else if(Score > 10'd0) begin 
		Enable = 4'b0001; 
		end
		else begin
		Enable = 4'b0000;
		end
	end

always_comb begin
	if((Ghost_Y_Motion == 10'd0) && (Ghost_X_Motion == 10'd0)) begin
		if (Random == 2'b00) begin 
			//A
			select = 2'd2;
		end
		else if (Random == 2'b01) begin 
			//D
			select = 2'd3;
		end
		else if (Random == 2'b10) begin 
			//S
			select = 2'd1;
		end
		else if (Random == 2'b11) begin 
			//W
			select = 2'd0;
		end
		else begin
			select = 2'd0;
		end
	end
	else if (Ghost_Y_Motion == 10'd1)begin
		select = 2'd1; //DOWN
	end
	else if (Ghost_Y_Motion == (-10'd1))begin
		select = 2'd0; //UP
	end
	else if (Ghost_X_Motion == 10'd1)begin
		select = 2'd3; //RIGHT
	end
	else if (Ghost_X_Motion == (-10'd1))begin
		select = 2'd2; //LEFT
	end
	else begin
	select = 2'd0;
	end
	
	if((Ghost_Y_Motion2 == 10'd0) && (Ghost_X_Motion2 == 10'd0)) begin
		if (rand2 == 2'b00) begin 
			//A
			select2 = 2'd2;
		end
		else if (rand2 == 2'b01) begin 
			//D
			select2 = 2'd3;
		end
		else if (rand2 == 2'b10) begin 
			//S
			select2 = 2'd1;
		end
		else if (rand2 == 2'b11) begin 
			//W
			select2 = 2'd0;
		end
		else begin
			select2 = 2'd0;
		end
	end
	else if (Ghost_Y_Motion2 == 10'd1)begin
		select2 = 2'd1; //DOWN
	end
	else if (Ghost_Y_Motion2 == (-10'd1))begin
		select2 = 2'd0; //UP
	end
	else if (Ghost_X_Motion2 == 10'd1)begin
		select2 = 2'd3; //RIGHT
	end
	else if (Ghost_X_Motion2 == (-10'd1))begin
		select2 = 2'd2; //LEFT
	end
	else begin
	select2 = 2'd1;
	end
	
	if((Ghost_Y_Motion3 == 10'd0) && (Ghost_X_Motion3 == 10'd0)) begin
		if (rand3 == 2'b00) begin 
			//A
			select3 = 2'd2;
		end
		else if (rand3 == 2'b01) begin 
			//D
			select3 = 2'd3;
		end
		else if (rand3 == 2'b10) begin 
			//S
			select3 = 2'd1;
		end
		else if (rand3 == 2'b11) begin 
			//W
			select3 = 2'd0;
		end
		else begin
			select3 = 2'd0;
		end
	end
	else if (Ghost_Y_Motion3 == 10'd1)begin
		select3 = 2'd1; //DOWN
	end
	else if (Ghost_Y_Motion3 == (-10'd1))begin
		select3 = 2'd0; //UP
	end
	else if (Ghost_X_Motion3 == 10'd1)begin
		select3 = 2'd3; //RIGHT
	end
	else if (Ghost_X_Motion3 == (-10'd1))begin
		select3 = 2'd2; //LEFT
	end
	else begin
	select3 = 2'd0;
	end
	
	if((Ghost_Y_Motion4 == 10'd0) && (Ghost_X_Motion4 == 10'd0)) begin
		if (rand4 == 2'b00) begin 
			//A
			select4 = 2'd2;
		end
		else if (rand4 == 2'b01) begin 
			//D
			select4 = 2'd3;
		end
		else if (rand4 == 2'b10) begin 
			//S
			select4 = 2'd1;
		end
		else if (rand4 == 2'b11) begin 
			//W
			select4 = 2'd0;
		end
		else begin
			select4 = 2'd0;
		end
	end
	else if (Ghost_Y_Motion4 == 10'd1)begin
		select4 = 2'd1; //DOWN
	end
	else if (Ghost_Y_Motion4 == (-10'd1))begin
		select4 = 2'd0; //UP
	end
	else if (Ghost_X_Motion4 == 10'd1)begin
		select4 = 2'd3; //RIGHT
	end
	else if (Ghost_X_Motion4 == (-10'd1))begin
		select4 = 2'd2; //LEFT
	end
	else begin
	select4 = 2'd0;
	end
end

    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				
				Ghost_X_Motion <= 10'd0;
				Ghost_Y_Motion <= 10'd0;
				Ghost_X_Pos <= Ghost_X_Center;
				Ghost_Y_Pos <= Ghost_Y_Center;
				
				Ghost_X_Motion2 <= 10'd0;
				Ghost_Y_Motion2 <= 10'd0;
				Ghost_X_Pos2 <= Ghost_X_Center2;
				Ghost_Y_Pos2 <= Ghost_Y_Center2;
				
				Ghost_X_Motion3 <= 10'd0;
				Ghost_Y_Motion3 <= 10'd0;
				Ghost_X_Pos3 <= Ghost_X_Center3;
				Ghost_Y_Pos3 <= Ghost_Y_Center3;
				
				Ghost_X_Motion4 <= 10'd0;
				Ghost_Y_Motion4 <= 10'd0;
				Ghost_X_Pos4 <= Ghost_X_Center4;
				Ghost_Y_Pos4 <= Ghost_Y_Center4;
    
        end
        else 
        begin 
				 case (Random)
					2'b00 : begin
								if(Brom_q == 2'd1) begin
									Ghost_X_Motion <= 10'd0;//A
									Ghost_Y_Motion<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion == 10'd0 && Ghost_Y_Motion == 10'd0 && Enable[0]) begin
										Ghost_X_Motion <=  - 10'd1;//A
									   Ghost_Y_Motion<= 10'd0;
									end
									else begin
										Ghost_X_Motion <= Ghost_X_Motion;
										Ghost_Y_Motion <= Ghost_Y_Motion;
									end
								end
								
							  end
					        
					2'b01 : begin
								if(Brom_q == 2'd1) begin
									Ghost_X_Motion <= 10'd0;//D
									Ghost_Y_Motion<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion == 10'd0 && Ghost_Y_Motion == 10'd0 && Enable[0]) begin
										Ghost_X_Motion <= 10'd1;//D
									   Ghost_Y_Motion<= 10'd0;
									end
									else begin
										Ghost_X_Motion <= Ghost_X_Motion;
										Ghost_Y_Motion <= Ghost_Y_Motion;
									end
								end
								
							  end
							  
					2'b10 : begin
							  if(Brom_q == 2'd1) begin
									Ghost_X_Motion <= 10'd0;//S
									Ghost_Y_Motion<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion == 10'd0 && Ghost_Y_Motion == 10'd0 && Enable[0]) begin
										Ghost_X_Motion <= 10'd0;//S
									   Ghost_Y_Motion<= 10'd1;
									end
									else begin
										Ghost_X_Motion <= Ghost_X_Motion;
										Ghost_Y_Motion <= Ghost_Y_Motion;
									end
								end
							
							 end
							 
					2'b11 : begin
							  if(Brom_q == 2'd1) begin
									Ghost_X_Motion <= 10'd0;//W
									Ghost_Y_Motion<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion == 10'd0 && Ghost_Y_Motion == 10'd0 && Enable[0]) begin
										Ghost_X_Motion <= 10'd0;//W
									   Ghost_Y_Motion<= - 10'd1;
									end
									else begin
										Ghost_X_Motion <= Ghost_X_Motion;
										Ghost_Y_Motion <= Ghost_Y_Motion;
									end
								end
								end	  
					default: ;
			   endcase
				case (rand2)
					2'b00 : begin
								if(Brom_q2 == 2'd1) begin
									Ghost_X_Motion2 <= 10'd0;//A
									Ghost_Y_Motion2<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion2 == 10'd0 && Ghost_Y_Motion2 == 10'd0 && Enable[1] ) begin
										Ghost_X_Motion2 <=  - 10'd1;//A
									   Ghost_Y_Motion2<= 10'd0;
									end
									else begin
										Ghost_X_Motion2 <= Ghost_X_Motion2;
										Ghost_Y_Motion2 <= Ghost_Y_Motion2;
									end
								end
								
							  end
					        
					2'b01 : begin
								if(Brom_q2 == 2'd1) begin
									Ghost_X_Motion2 <= 10'd0;//D
									Ghost_Y_Motion2<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion2 == 10'd0 && Ghost_Y_Motion2 == 10'd0 && Enable[1] ) begin
										Ghost_X_Motion2 <= 10'd1;//D
									   Ghost_Y_Motion2<= 10'd0;
									end
									else begin
										Ghost_X_Motion2 <= Ghost_X_Motion2;
										Ghost_Y_Motion2 <= Ghost_Y_Motion2;
									end
								end
								
							  end
							  
					2'b10 : begin
							  if(Brom_q2 == 2'd1) begin
									Ghost_X_Motion2 <= 10'd0;//S
									Ghost_Y_Motion2<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion2 == 10'd0 && Ghost_Y_Motion2 == 10'd0 && Enable[1]) begin
										Ghost_X_Motion2 <= 10'd0;//S
									   Ghost_Y_Motion2<= 10'd1;
									end
									else begin
										Ghost_X_Motion2 <= Ghost_X_Motion2;
										Ghost_Y_Motion2 <= Ghost_Y_Motion2;
									end
								end
							
							 end
							 
					2'b11 : begin
							  if(Brom_q2 == 2'd1) begin
									Ghost_X_Motion2 <= 10'd0;//W
									Ghost_Y_Motion2<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion2 == 10'd0 && Ghost_Y_Motion2 == 10'd0 && Enable[1] ) begin
										Ghost_X_Motion2 <= 10'd0;//W
									   Ghost_Y_Motion2<= - 10'd1;
									end
									else begin
										Ghost_X_Motion2 <= Ghost_X_Motion2;
										Ghost_Y_Motion2 <= Ghost_Y_Motion2;
									end
								end
								end	  
					default: ;
			   endcase
				case (rand3)
					2'b00 : begin
								if(Brom_q3 == 2'd1) begin
									Ghost_X_Motion3 <= 10'd0;//A
									Ghost_Y_Motion3<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion3 == 10'd0 && Ghost_Y_Motion3 == 10'd0 && Enable[2] ) begin
										Ghost_X_Motion3 <=  - 10'd1;//A
									   Ghost_Y_Motion3<= 10'd0;
									end
									else begin
										Ghost_X_Motion3 <= Ghost_X_Motion3;
										Ghost_Y_Motion3 <= Ghost_Y_Motion3;
									end
								end
								
							  end
					        
					2'b01 : begin
								if(Brom_q3 == 2'd1) begin
									Ghost_X_Motion3 <= 10'd0;//D
									Ghost_Y_Motion3<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion3 == 10'd0 && Ghost_Y_Motion3 == 10'd0 && Enable[2] ) begin
										Ghost_X_Motion3 <= 10'd1;//D
									   Ghost_Y_Motion3<= 10'd0;
									end
									else begin
										Ghost_X_Motion3 <= Ghost_X_Motion3;
										Ghost_Y_Motion3 <= Ghost_Y_Motion3;
									end
								end
								
							  end
							  
					2'b10 : begin
							  if(Brom_q3 == 2'd1) begin
									Ghost_X_Motion3 <= 10'd0;//S
									Ghost_Y_Motion3<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion3 == 10'd0 && Ghost_Y_Motion3 == 10'd0 && Enable[2] ) begin
										Ghost_X_Motion3 <= 10'd0;//S
									   Ghost_Y_Motion3<= 10'd1;
									end
									else begin
										Ghost_X_Motion3 <= Ghost_X_Motion3;
										Ghost_Y_Motion3 <= Ghost_Y_Motion3;
									end
								end
							
							 end
							 
					2'b11 : begin
							  if(Brom_q3 == 2'd1) begin
									Ghost_X_Motion3 <= 10'd0;//W
									Ghost_Y_Motion3<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion3 == 10'd0 && Ghost_Y_Motion3 == 10'd0 && Enable[2] ) begin
										Ghost_X_Motion3 <= 10'd0;//W
									   Ghost_Y_Motion3<= - 10'd1;
									end
									else begin
										Ghost_X_Motion3 <= Ghost_X_Motion3;
										Ghost_Y_Motion3 <= Ghost_Y_Motion3;
									end
								end
								end	  
					default: ;
			   endcase
				case (rand4)
					2'b00 : begin
								if(Brom_q4 == 2'd1) begin
									Ghost_X_Motion4 <= 10'd0;//A
									Ghost_Y_Motion4<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion4 == 10'd0 && Ghost_Y_Motion4 == 10'd0 && Enable[3] ) begin
										Ghost_X_Motion4 <=  - 10'd1;//A
									   Ghost_Y_Motion4<= 10'd0;
									end
									else begin
										Ghost_X_Motion4 <= Ghost_X_Motion4;
										Ghost_Y_Motion4 <= Ghost_Y_Motion4;
									end
								end
								
							  end
					        
					2'b01 : begin
								if(Brom_q4 == 2'd1) begin
									Ghost_X_Motion4 <= 10'd0;//D
									Ghost_Y_Motion4<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion4 == 10'd0 && Ghost_Y_Motion4 == 10'd0 && Enable[3] ) begin
										Ghost_X_Motion4 <= 10'd1;//D
									   Ghost_Y_Motion4<= 10'd0;
									end
									else begin
										Ghost_X_Motion4 <= Ghost_X_Motion4;
										Ghost_Y_Motion4 <= Ghost_Y_Motion4;
									end
								end
								
							  end
							  
					2'b10 : begin
							  if(Brom_q4 == 2'd1) begin
									Ghost_X_Motion4 <= 10'd0;//S
									Ghost_Y_Motion4<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion4 == 10'd0 && Ghost_Y_Motion4 == 10'd0 && Enable[3] ) begin
										Ghost_X_Motion4 <= 10'd0;//S
									   Ghost_Y_Motion4<= 10'd1;
									end
									else begin
										Ghost_X_Motion4 <= Ghost_X_Motion4;
										Ghost_Y_Motion4 <= Ghost_Y_Motion4;
									end
								end
							
							 end
							 
					2'b11 : begin
							  if(Brom_q4 == 2'd1) begin
									Ghost_X_Motion4 <= 10'd0;//W
									Ghost_Y_Motion4<= 10'd0;
								end
								else begin
									if (Ghost_X_Motion4 == 10'd0 && Ghost_Y_Motion4 == 10'd0 && Enable[3] ) begin
										Ghost_X_Motion4 <= 10'd0;//W
									   Ghost_Y_Motion4<= - 10'd1;
									end
									else begin
										Ghost_X_Motion4 <= Ghost_X_Motion4;
										Ghost_Y_Motion4 <= Ghost_Y_Motion4;
									end
								end
								end	  
					default: ;
			   endcase
				 
				 Ghost_X_Pos <= (Ghost_X_Pos + Ghost_X_Motion);
				 Ghost_Y_Pos <= (Ghost_Y_Pos + Ghost_Y_Motion);
				 
				 Ghost_X_Pos2 <= (Ghost_X_Pos2 + Ghost_X_Motion2);
				 Ghost_Y_Pos2 <= (Ghost_Y_Pos2 + Ghost_Y_Motion2);
				 
				 Ghost_X_Pos3 <= (Ghost_X_Pos3 + Ghost_X_Motion3);
				 Ghost_Y_Pos3 <= (Ghost_Y_Pos3 + Ghost_Y_Motion3);
				 
				 Ghost_X_Pos4 <= (Ghost_X_Pos4 + Ghost_X_Motion4);
				 Ghost_Y_Pos4 <= (Ghost_Y_Pos4 + Ghost_Y_Motion4);
				 
				 	
		end  
    end		
       
    assign GhostX = Ghost_X_Pos;
   
    assign GhostY = Ghost_Y_Pos;
	 
	 assign GhostX2 = Ghost_X_Pos2;
   
    assign GhostY2 = Ghost_Y_Pos2;
	 
	 assign GhostX3 = Ghost_X_Pos3;
   
    assign GhostY3 = Ghost_Y_Pos3;
	 
	 assign GhostX4 = Ghost_X_Pos4;
   
    assign GhostY4 = Ghost_Y_Pos4;
    
endmodule
