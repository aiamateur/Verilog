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

module testbench1;
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

module testbench2;
  reg a, b, c;
  wire sum, cout;
  
  full_adder FA(.s(sum), .co(cout), .a(a), .b(b), .c(c));
  
  initial
    begin
      a=0; b=0; c=1; #5;
      $display($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
      b=1; #5;
      $display($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
      a=1; #5;
      $display($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
      a=0; b=0; c=0; #5;
      $display($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
      #5 $finish;
    end
endmodule

//Results
                   5 a=0, b=0, c=1, sum=1, cout=0 
                  10 a=0, b=1, c=1, sum=0, cout=1 
                  15 a=1, b=1, c=1, sum=1, cout=1 
                  20 a=0, b=0, c=0, sum=0, cout=0 

module testbench3;
  reg a, b, c;
  wire sum, cout;
  integer i;
  
  full_adder FA(.s(sum), .co(cout), .a(a), .b(b), .c(c));
  
  initial
    begin
      for (i = 0; i < 8; i++)
        begin
          {a, b, c} = i; #5;
          $display($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
        end
      #5 $finish;
    end
endmodule

//Results
                   5 a=0, b=0, c=0, sum=0, cout=0 
                  10 a=0, b=0, c=1, sum=1, cout=0 
                  15 a=0, b=1, c=0, sum=1, cout=0 
                  20 a=0, b=1, c=1, sum=0, cout=1 
                  25 a=1, b=0, c=0, sum=1, cout=0 
                  30 a=1, b=0, c=1, sum=0, cout=1 
                  35 a=1, b=1, c=0, sum=0, cout=1 
                  40 a=1, b=1, c=1, sum=1, cout=1 

module testbench4;
  reg a, b, c;
  wire sum, cout;
  integer i;
  
  full_adder FA(.s(sum), .co(cout), .a(a), .b(b), .c(c));
  
  initial
    begin
      $dumpfile("fulladder.vcd");
      $dumpvars(0, testbench4);
      for (i = 0; i < 8; i++)
        begin
          {a, b, c} = i; #5;
          $display($time, " a=%b, b=%b, c=%b, sum=%b, cout=%b ", a, b, c, sum, cout );
        end
      #5 $finish;
    end
endmodule

//Results
VCD info: dumpfile fulladder.vcd opened for output.
                   5 a=0, b=0, c=0, sum=0, cout=0 
                  10 a=0, b=0, c=1, sum=1, cout=0 
                  15 a=0, b=1, c=0, sum=1, cout=0 
                  20 a=0, b=1, c=1, sum=0, cout=1 
                  25 a=1, b=0, c=0, sum=1, cout=0 
                  30 a=1, b=0, c=1, sum=0, cout=1 
                  35 a=1, b=1, c=0, sum=0, cout=1 
                  40 a=1, b=1, c=1, sum=1, cout=1 
  
//Example 2
//4-bit shift register

module shiftreg_4bit(clock, clear, A, E);
  input clock, clear, A;
  output reg E;
  
  reg B, C, D;
  
  always @(posedge clock or negedge clear)
    begin
      if(!clear) 
        begin
          B <= 0;
          C <= 0;
          D <= 0;
          E <= 0;
        end
      else
        begin
          E <= D;
          D <= C;
          C <= B;
          B <= A;
        end
    end
endmodule

module shift_test;
  reg clk, clr, in;
  wire out;
  integer i;
  
  shiftreg_4bit SR(.clock(clk), .clear(clr), .A(in), .E(out));
  
  initial
    begin
      clk = 1'b0;
      #2 clr = 1'b0;
      #5 clr = 1'b1;
    end
    
  always 
    begin
      #5 clk = ~clk;
    end
  
  initial 
    begin
      #2;
      repeat (2);
        begin
          #10 in = 0;
          #10 in = 0;
          #10 in = 1;
          #10 in = 1;
        end
    end
    
  initial 
    begin
      $dumpfile("shifter.vcd");
      $dumpvars(0, shift_test);
      #200 $finish;
    end
endmodule

//Results
VCD info: dumpfile shifter.vcd opened for output.

  
  


  
  
  
  
  

  
