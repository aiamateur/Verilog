Concepts Covered :

•	Illustrate the writing of test bench for a simple full adder, showing the simulation output and also the timing diagrams. 
•	Illustrate the writing of test bench for a shift register circuit. 
•	Illustrate the writing of test bench for a binary counter. 
•	Illustrate how a test bench can automatically verify the simulation outputs. 
•	Illustrate how random patterns can be generated as test stimuli in test bench. 

//Example 1
//Full Adder

module full_adder(s, co, a, b, c);
  input a, b, c;
  output s, co;
  
  assign s = a ^ b ^ c;
  assign co = (a & b) | (b & c) | (a & c);
endmodule

module testbench;
  reg a, b, c;
  wire sum, cout;
  
  full_adder FA(.s(sum), .co(cout), .a(a), .b(b), .c(c));
  
  initial
    begin
      $monitor($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
      #5 a=0; b=0; c=1;
      #5 b=1;
      #5 a=1;
      #5 a=0; b=0; c=0;
      #5 $finish;
    end
endmodule

//Results
                   0 a=x, b=x, c=x, sum=x, cout=x 
                   5 a=0, b=0, c=1, sum=1, cout=0 
                  10 a=0, b=1, c=1, sum=0, cout=1 
                  15 a=1, b=1, c=1, sum=1, cout=1 
                  20 a=0, b=0, c=0, sum=0, cout=0 

  
  
  
  
  

  
