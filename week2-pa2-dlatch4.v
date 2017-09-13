//Write the verilog modules for D-latch here and  
//keep the name of 4-bit D-latch "dlatch4"
 
module dlatch4(D, En, Q);
  input[3:0] D;
  input En;
  output[3:0] Q;
  
  and G0(Q[0], D[0], En);
  and G1(Q[1], D[1], En);
  and G2(Q[2], D[2], En);
  and G3(Q[3], D[3], En);
endmodule
  
	module dlatch4_tb;
		reg [3:0] d;
		reg en;
		wire [3:0] q;
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		dlatch4  dl4( d, en, q);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{d} = 2; en = 1;
					end
   				1:    	begin
   						{d} = 6; en = 1;
        				end
   				2:    	begin
						{d} = 6; en = 1;
					end
   				3:	begin
						{d} = 4; en = 1;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			
			if (d==q && en == 1)
        			pass();
			else
 				fail();
		end


 		task fail; 	begin
    					$display("Fail: for e == %b,  %b != %b",en,d,q);
  				end
  		endtask

  		task pass; 	begin
	    				$display("Pass: for e == %b,  %b == %b",en,d,q);
  				end
  		endtask

	endmodule
