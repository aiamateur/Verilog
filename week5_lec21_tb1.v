Concepts Covered :

•	Explains the basic function of a test bench in simulation. 
•	Explains the various simulator directives that are used for writing test benches. 
•	Illustrate the writing of test bench with a complete example. 

//A simple Example
//Github example 1
module example(A, B, C, D, E, F, Y);
  input A, B, C, D, E, F;
  output Y;
  wire t1, t2, t3, Y;
  
  nand #1 G1 (t1, A, B);
  and  #2 G2 (t2, C, ~B, D);
  nor  #1 G3 (t3, E, F);  
  nand #1 G4 (Y, t1, t2, t3);
endmodule

module testbench;
  reg A,  B, C, D, E, F;
  wire Y;
  example DUT(A, B, C, D, E, F, Y);
  
  initial
    begin
      $monitor($time, " A=%b, B=%b, C=%b, D=%b, E=%b, F=%b, Y=%b", A, B, C, D, E, F, Y);
      #5 A=1; B=0; C=0; D=1; E=0; F=0;
      #5 A=0; B=0; C=1; D=1; E=0; F=0;  
      #5 A=1; C=0;
      #5 F=1;
      #5 $finish;
    end
endmodule

//Example 2
//A complete example :: 2 bit equality checker
module comparator(x, y, z);
  input [1:0] x, y;
  output z;
  
  assign z = (~x[0] & ~y[0] & ~x[1] & ~y[1]) | (x[0] & y[0] & ~x[1] & ~y[1]) | (~x[0] & ~y[0] & x[1] & y[1]) | (x[0] & y[0] & x[1] & y[1]);
endmodule

`timescale 1ns/100ps
module testbench;
  reg [1:0] x, y;
  wire z;
  
  comparator C2 (.x(x), .y(y), .z(z));
  
  initial 
  begin
    $dumpfile("comp.vcd");
    $dumpvars(0, testbench);
    x = 2'b01; y = 2'b00; 
    #10 x = 2'b10; y = 2'b10;   
    #10 x = 2'b01; y = 2'b11; 
  end
    initial
      begin 
        $monitor($time, " x=%b, y=%b, z=%d", x, y, z);
      end
endmodule


    
