module collision(input logic [9:0] Ghost_X, Ghost_Y, Ghost_X2, Ghost_Y2, 
												Ghost_X3(GX3), Ghost_Y3, Ghost_X4, Ghost_Y4,
												Pac_X, Pac_Y,
						output logic kill
					 );
				
		int Px, Py, Gx, Gy, Gx2, Gy2, Gx3, Gy3, Gx4, Gy4;
		int distance1, distance2, distance3, distance4;
		assign Px = Pac_X;
		assign Py = Pac_y;
		assign Gx = Ghost_X;
		assign Gy = Ghost_Y;
		assign Gx2 = Ghost_X2;
		assign Gy2 = Ghost_Y2;
		assign Gx3 = Ghost_X3;
		assign Gy3 = Ghost_Y3;
		assign Gx4 = Ghost_X4;
		assign Gy4 = Ghost_Y4;
		
		parameter [9:0] DistX = 10'd16;
		parameter [9:0] DistY = 10'd28;
		
		always_comb begin
					
			distance1 = ((Px-Gx)*(Px - Gx)) + ((Py - Gy)*(Py - Gy));
			distance2 = ((Px-Gx2)*(Px - Gx2)) + ((Py - Gy2)*(Py - Gy2));
			distance3 = ((Px-Gx3)*(Px - Gx3)) + ((Py - Gy3)*(Py - Gy3));
			distance4 = ((Px-Gx4)*(Px - Gx4)) + ((Py - Gy4)*(Py - Gy4));

			if((distance1 < 64) || (distance2 < 64) || (distance3 < 64) || (distance4 < 64)) begin
				kill <= 1;
			end
		end
