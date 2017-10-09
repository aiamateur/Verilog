//Write the verilog module for a serial adder
module serialadd(a, b, s, reset, clk);
  input a, b, reset, clk;
  output reg s;
  
  parameter CARRY0 = 0, CARRY1 = 1;
  reg PS, NS;
  
  always @(posedge clk or reset)
    begin
      if(reset) PS <= CARRY0;
      else      PS <= NS;
    end
  
  always @(PS, a, b)
    case (PS)
      CARRY0 : begin
                 s  = (a ^ b);
                 NS = (a & b)? CARRY1 : CARRY0;
               end
      CARRY1 : begin
                 s  = (a & b) | ((~a) & (~b));
                 NS = ((~a) & (~b))? CARRY0 : CARRY1;
               end
    endcase
endmodule
      
  
  
  
  
   
  
   
`timescale 1ns/1ps
module tb_sadder;
  reg  a, b, reset, clk;
  reg [2:0] s_t;	
  reg [3:0] a_t, b_t;
  wire s;

  serialadd SA(a, b, s, reset, clk);

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

   initial
     begin
     	clk=1'b1;
     	forever #50 clk=~clk;  
     end
 
   initial
     begin
        ret = $fscanf(STDIN,"%d",testid);
	case(testid)
				
	0:  begin       //add 7 and 6 
    			reset = 1'b1; a = 1'b0; b = 1'b0; a_t=7; b_t=6;  
			#10; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#10; s_t[0] = s;   

                        #100; a = a_t[1]; b = b_t[1]; 
                        #10; s_t[1] = s;   

			#100; a = a_t[2]; b = b_t[2]; 
			#10; s_t[2] = s;   
                        
                        #100; a = a_t[3]; b = b_t[3]; 
        
			
	    end
   
	1:  begin     //add 5 and 9 
    			reset = 1'b1; a = 1'b0; b = 1'b0; a_t=5; b_t=9;  
			#10; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#10; s_t[0] = s;   

                        #100; a = a_t[1]; b = b_t[1]; 
                        #10; s_t[1] = s;   

			#100; a = a_t[2]; b = b_t[2]; 
			#10; s_t[2] = s;   
                        
                        #100; a = a_t[3]; b = b_t[3]; 
	    end

	2:  begin       //add 11 and 13 
    			reset = 1'b1; a = 1'b0; b = 1'b0; a_t=11; b_t=13;
			#10; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#10; s_t[0] = s;   

                        #100; a = a_t[1]; b = b_t[1]; 
                        #10; s_t[1] = s;   

			#100; a = a_t[2]; b = b_t[2]; 
			#10; s_t[2] = s;   
                        
                        #100; a = a_t[3]; b = b_t[3]; 
	    end
   
	3:  begin     //add 3 and 11 
    			reset = 1'b1; a = 1'b0; b = 1'b0; a_t=3; b_t=11; 
			#10; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#10; s_t[0] = s;   

                        #100; a = a_t[1]; b = b_t[1]; 
                        #10; s_t[1] = s;   

			#100; a = a_t[2]; b = b_t[2]; 
			#10; s_t[2] = s;   
                        
                        #100; a = a_t[3]; b = b_t[3]; 
	    end
   
	
	default: begin
			$display("Bad testcase id %d",testid);
			$finish();
		 end

       endcase 
       #10;
       if ( (testid == 0 && a_t == 7 && b_t == 6 && {s,s_t} == 13) || 
				(testid == 1 && a_t == 5 && b_t == 9 && {s,s_t} == 14) ||
				(testid ==2 && a_t == 11 && b_t == 13 && {s,s_t} == 8) || 
				(testid ==3 && a_t == 3 && b_t == 11 && {s,s_t} == 14) )
			pass();
	else
			fail();
      end 
      
      task fail; 	begin
				$display("Fail: for a (%b) + b (%b) != s (%b)", a_t, b_t, {s,s_t});
				$finish();
			end
      endtask

      task pass; 	begin
				$display("Pass: for a (%b) + b (%b) = s (%b)", a_t, b_t, {s,s_t});
				$finish();
			end
      endtask
        
endmodule
