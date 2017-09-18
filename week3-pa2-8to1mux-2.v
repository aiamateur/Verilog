//write the verilog modules to implement 8-bit multiplexer
module bus_multiplex(OUTBUS, A, B, C, D, SEL);
  input [7:0] A, B, C, D;
  input [1:0] SEL;
  output reg [7:0] OUTBUS;
  
  wire [7:0] outwire;
  
  mux4 M0 (outwire[0], A[0], B[0], C[0], D[0], SEL);
  mux4 M1 (outwire[1], A[1], B[1], C[1], D[1], SEL);
  mux4 M2 (outwire[2], A[2], B[2], C[2], D[2], SEL);
  mux4 M3 (outwire[3], A[3], B[3], C[3], D[3], SEL);
  mux4 M4 (outwire[4], A[4], B[4], C[4], D[4], SEL);
  mux4 M5 (outwire[5], A[5], B[5], C[5], D[5], SEL);
  mux4 M6 (outwire[6], A[6], B[6], C[6], D[6], SEL);
  mux4 M7 (outwire[7], A[7], B[7], C[7], D[7], SEL);
  
  always @(*)
    OUTBUS = outwire;
  
endmodule

module mux4(out, a, b,  c, d, sel);
  input a, b, c, d;
  input [1:0] sel;
  output reg out;
  
  always @(*)
    begin
      case(sel)
        2'b00: out = a;
        2'b01: out = b;
        2'b10: out = c;
        2'b11: out = d;
        default: out = 1'b0;
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
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 2;
					end
   				1:    	begin
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 3;
        					end
   				2:    	begin
						{a} = 0; {b} = 15; {c} = 240; {d} = 255; {s} = 0;
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
