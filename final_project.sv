//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module final_project (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig, X, Y, YM, XM;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;
	logic U, D, L, R;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (STOP[3:0], HEX4[6:0]);
	//assign HEX4[7] = 1'b1;
	
	//HexDriver hex_driver3 (score[14:11], HEX3[6:0]);
	//assign HEX3[7] = 1'b1;
	HexDriver hex_driver2 (STOP[11:8], HEX2[6:0]);
	HexDriver hex_driver1 (STOP[7:4], HEX1[6:0]);
	//assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (STOP[3:0], HEX0[6:0]);
	//assign HEX0[7] = 1'b1;
	
	//HexDriver hex_driver5 (D, HEX5[7:0]);
	
	//fill in the hundreds digit as well as the negative sign
	//assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	//assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[3:0];
	assign VGA_B = Blue[3:0];
	assign VGA_G = Green[3:0];
	
	
	finalproject_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		//.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );
	 
	 logic [9:0] GX, GY, GX2, GY2, GX3, GY3, GX4, GY4;
	 logic [1:0] random;
	 logic [11:0] score;
	 logic [16:0] counter; 
	 logic [12:0] switch;
	 logic P, G1, G2, G3, G4;
	 logic [20:0] STOP;
	 
	 assign LEDR[0] = P;
	 assign LEDR[1] = G1;
	 assign LEDR[2] = G2;
	 assign LEDR[3] = G3;
	 assign LEDR[4] = G4;
	 assign LEDR[5] = VGA_Clk;
	 
	 
	 always_ff @ (posedge MAX10_CLK1_50) begin
		if(counter >= 17'd130137) begin
			random <= random + 2'd1;
			switch <= switch + 1'd1;
			counter <= 20'd0;
		end
		else begin
			counter <= counter + 20'd1;
		end
	 end

vga_controller VGA(.Clk(MAX10_CLK1_50), .Reset(Reset_h), .hs(VGA_HS), .vs(VGA_VS), .pixel_clk(VGA_Clk), .blank(blank), .sync(sync), .DrawX(drawxsig), .DrawY(drawysig)); 
ball BALL(.Reset(Reset_h), .vga_clk(VGA_Clk), .frame_clk(VGA_VS), .keycode(keycode), .BallX(ballxsig), .BallY(ballysig), .BallS(ballsizesig), 
			 .D(D),
			 .Pon(P), .G1on(G1), .G2on(G2), .G3on(G3), .G4on(G4)
			 );
pacman_mapper MAZE(.Clk(VGA_Clk), .Reset(Reset_h), .DrawX(drawxsig), .DrawY(drawysig), .BallXs(ballxsig), .BallYs(ballysig), .Ball_Size(ballsizesig), .vga_clk(VGA_Clk), .blank(blank), 
					    .Red(Red), .Green(Green), .Blue(Blue), .switch(switch[5]), 
						.Ghost_Xs(GX), .Ghost_Ys(GY),
						.Ghost_X2s(GX2), .Ghost_Y2s(GY2),
						.Ghost_X3s(GX3), .Ghost_Y3s(GY3),
						.Ghost_X4s(GX4), .Ghost_Y4s(GY4), .score(score), .stop(STOP),
						.Pon(P), .G1on(G1), .G2on(G2), .G3on(G3), .G4on(G4));
ghost (.Reset(Reset_h), .vga_clk(VGA_Clk), .frame_clk(VGA_VS), .DrawX(switch[5:2]), .Score(score),
						.GhostX(GX), .GhostY(GY),
						.GhostX2(GX2), .GhostY2(GY2),
						.GhostX3(GX3), .GhostY3(GY3),
						.GhostX4(GX4), .GhostY4(GY4),
						.Pon(P), .G1on(G1), .G2on(G2), .G3on(G3), .G4on(G4)
					 );
endmodule
