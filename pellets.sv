module  pellet ( input Reset, frame_clk,
					input logic [2:0] Brom_q,
					input logic [9:0] initial_X, initial_Y,
					output pellet_count
					);
					
logic [9:0] Pellet_X, Pellet_Y, Pellet_Size
logic [9:0] Pellet_X_Center
logic [9:0] Pellet_Y_Center

always_ff @ (posedge Reset or posedge frame_clk )
    begin: check_pellet
		if(Reset)
			Pellet_X <= initial_Y;
			Pellet_Y <= initial_X;
			pellet_count <= 0;
		end
		else if(ball_on = 1'b1 && Brom_q == 3'd2) begin
			pellet_count <= 1;
			end
		else begin
			pellet_count <= pellet_count;
			end
		end
	
endmodule
