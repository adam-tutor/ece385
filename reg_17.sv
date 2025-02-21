module reg_17 ( input						Clk, Load,
					input						[16:0] D,
					output logic 			[16:0] Data_Out);
					
		always_ff @ (posedge Clk)
		begin
				// Setting the output Q[16..0] of the register to zeros as Reset is pressed
				if(Load)
					Data_Out <= D;
				else begin
					Data_Out <= Data_Out;
				end
		end
		
endmodule