module mux5_1_5
	#(parameter width = 17)
	 (input  logic [width-1:0] d0, d1, d2, d3, d4,
	  input  logic [4:0] s, 
	  output logic [width-1:0] y);
	 
	 always_comb 
	 begin
			unique case(s)
			5'b00001 : y = d0;
			5'b00010 : y = d1;
			5'b00100 : y = d2;
			5'b01000 : y = d3;
			5'b10000 : y = d4;
			endcase
	 end
endmodule