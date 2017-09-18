//write the verilog modules here to compute 16-bit gcd of two numbers
module GCD (RESULT, INPUT1, INPUT2);
  input [15:0] INPUT1, INPUT2;
  output reg [15:0] RESULT;
  
  reg [15:0] inp1, inp2;
  
  always @(*)
    begin
      inp1 = INPUT1;
      inp2 = INPUT2;
    //end

    //begin
      while(inp2 != 0)
        begin
          if(inp1 > inp2)
            begin
              inp1 = inp1 - inp2;
            end
          else
            begin
              inp2 = inp2 - inp1;
            end
        end
      RESULT = inp1;
    end
endmodule

  
module gcd_tb;
		reg [15:0] a, b;
		wire [15:0] res;
		
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		GCD gcd1(res, a, b);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{a} = 56; {b} = 8; 
					end
   				1:    	begin
						{a} = 278; {b} = 15;
        					end
   				2:    	begin
						{a} = 738; {b} = 251;
					end
   				3:	begin
						{a} = 1536; {b} = 512;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			if ( (testid==0 && res == 8) || (testid==1 && res == 1) || (testid==2 && res == 1) || (testid==3 && res == 512) )
        				pass();
			else
 					fail();
		end


 		task fail; 	begin
    					$display("Fail: for INPUT1 = %4d and INPUT2 = %4d, RESULT = %4d is WRONG",a, b, res);
  				end
  		endtask

  		task pass; 	begin
    					$display("Pass: for INPUT1 = %4d, INPUT2 = %4d and RESULT = %4d",a, b, res);
  				end
  		endtask

	endmodule
