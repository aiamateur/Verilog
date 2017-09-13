//write the verilog modules to implement 4-bit ripple carry adder and 
//keep the module name of 4-bit adder "rcadder_4"
module rcadder_4 (A, B, Cin, Sum, Cout);
  input[3:0] A;
  input[3:0] B;
  input Cin;
  output[3:0] Sum;
  output Cout;
  
  wire Cout0, Cout1, Cout2;
  
  FullAdder FA0(A[0], B[0], Cin, Sum[0], Cout0);
  FullAdder FA1(A[1], B[1], Cout0, Sum[1], Cout1);
  FullAdder FA2(A[2], B[2], Cout1, Sum[2], Cout2);
  FullAdder FA3(A[3], B[3], Cout2, Sum[3], Cout);
endmodule

module FullAdder (a, b, cin, s, cout);
  input a;
  input b;
  input cin;
  output s;
  output cout;
  
  wire s1, c1, c2;
  
  xor G1(s1, a, b);
  xor G2(s, s1, cin);
  xor G3(cout, c2, c1);
  and G4(c1, a, b);
  and G5(c2, s1, cin);
endmodule
  
  
  
  
  
  
	module rcadder4_tb;
		reg [3:0]a, b;
		reg cin;
		wire [3:0]sum;
		wire cout;
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		rcadder_4  RCA4( a, b, cin, sum, cout);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{a} = 0; {b} = 0; cin = 0;
					end
   				1:    	begin
   						{a} = 7; {b} = 12; cin = 1;
        					end
   				2:    	begin
						{a} = 3; {b} = 8; cin = 0;
					end
   				3:	begin
						{a}=15; {b}=1; cin = 1;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			if({cout, sum}===a+b+cin)
        				pass();
			else
 				fail();
		end


 		task fail; 	begin
    					$display("FAIL: %b + %b + %b != %b", a,b,cin,{cout,sum});
  				end
  		endtask

  		task pass; 	begin
	    				$display("PASS: %b + %b + %b = %b", a,b,cin,{cout,sum});
  				end
  		endtask

	endmodule
