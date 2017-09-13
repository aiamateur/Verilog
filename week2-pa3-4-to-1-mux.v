//Write the verilog modules for 4-to-1 multiplexer here and
//keep the module name of 4-to-1 multiplexer "mux4x1"
module mux4x1 (A, Sel, Aout);
  input[3:0] A;
  input[1:0] Sel;
  output Aout;
  
  wire Aout0, Aout1, Aout2, Aout3, Or0, Or1, Or2, Or3, Or01, Or23;
  
 
  and G1(Aout0, ~Sel[0], ~Sel[1]);
  and G2(Or0, Aout0, A[0]);
  and G3(Aout1, Sel[0], ~Sel[1]);
  and G4(Or1, Aout1, A[1]);
  and G5(Aout2, ~Sel[0], Sel[1]);
  and G6(Or2, Aout2, A[2]);
  and G7(Aout3, Sel[0], Sel[1]);
  and G8(Or3, Aout3, A[3]);
  or G9(Or01, Or0, Or1);
  or G10(Or23, Or2, Or3);
  or G11(Aout, Or01, Or23);
  
  
endmodule

  
	module rcadder4_tb;
		reg [3:0] a;
		reg [1:0] s;
		wire out;
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		mux4x1  M4x1( a, s, out);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{a} = 1; {s} = 0;
					end
   				1:    	begin
   						{a} = 2; {s} = 0;
        				end
   				2:    	begin
						{a} = 2; {s} = 1;
					end
   				3:	begin
						{a} = 4; {s} = 2;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			if ( (s==0 && out == a[0]) || (s==1 && out == a[1]) || (s==2 && out == a[2]) || (s==3 && out == a[3]) )
        				pass();
			else
 					fail();
		end


 		task fail; 	begin
    					$display("Fail: for s = %b and a = %b, out = %b is WRONG",s,a,out);
  				end
  		endtask

  		task pass; 	begin
	    				$display("Pass: for s = %b and a = %b out = %b",s,a,out);
  				end
  		endtask

	endmodule
