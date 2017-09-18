//write the verilog modules to implement 8-bit multiplexer
module bus_multiplex(OUTBUS, A, B, C, D, SEL);
  input [7:0] A, B, C, D;
  input [1:0] SEL;
  output reg [7:0] OUTBUS;
  
  always @(*)
    begin
      case(SEL)
        2'b00: OUTBUS = A;
        2'b01: OUTBUS = B;
        2'b10: OUTBUS = C;
        2'b11: OUTBUS = D;
        default: OUTBUS = 8'b00000000;
      endcase
    end
endmodule
        
  
  
  
module bus_multiplex_tb;
		reg [7:0] a, b, c, d;
		reg [1:0] s;
		wire [7:0] out;
		
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		bus_multiplex  bm(out, a, b, c, d, s);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 0;
					end
   				1:    	begin
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 3;
        					end
   				2:    	begin
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 2;
					end
   				3:	begin
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 1;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			if ( (s==0 && out == a) || (s==1 && out == b) || (s==2 && out == c) || (s==3 && out == d) )
        				pass();
			else
 					fail();
		end


 		task fail; 	begin
    					$display("Fail: for A = %1d, B = %2d, C = %3d, D = %3d and SEL = %b, OUTBUS = %3d is WRONG",a, b, c, d, s, out);
  				end
  		endtask

  		task pass; 	begin
    					$display("Pass: for A = %1d, B = %2d, C = %3d, D = %3d and SEL = %b, OUTBUS = %3d",a, b, c, d, s, out);
	    				
  				end
  		endtask

	endmodule
