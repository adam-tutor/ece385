module mux2_1
	#(parameter width = 17)
	 (input  logic [width-1:0] d0, d1,
	  input  logic s, 
	  output logic [width-1:0] y);
	 
	 always_comb 
	 begin
			unique case(s)
			1'b0: y = d0;
			1'b1: y = d1;
			endcase
	 end
endmodule