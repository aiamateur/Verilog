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
  
  //Example 3: 7-bit binary counter
module counter(clear, clock, count);
  parameter N = 7;
  input clear, clock;
  output reg [0:N] count;
  
  always @(negedge clock)
    if(clear)
      count <= 0;
    else
      count = count+1;
endmodule

module test_counter;
  reg clk, clr;
  wire [7:0] out;
  
  counter CNT(.clock(clk), .clear(clr), .count(out));
  
  initial clk = 1'b0;
  
  always #5 clk = ~clk;
  
  initial
    begin
      clr = 1'b1;
      #15 clr = 1'b0;
      #200 clr = 1'b1;
      #10 $finish;
    end
    
  initial
    begin
      $dumpfile("counter.vcd");
      $dumpvars(0, test_counter);
      $monitor($time, " Count = %d ", out);
    end
    
endmodule

//Results
VCD info: dumpfile counter.vcd opened for output.
                   0 Count =   0 
                  20 Count =   1 
                  30 Count =   2 
                  40 Count =   3 
                  50 Count =   4 
                  60 Count =   5 
                  70 Count =   6 
                  80 Count =   7 
                  90 Count =   8 
                 100 Count =   9 
                 110 Count =  10 
                 120 Count =  11 
                 130 Count =  12 
                 140 Count =  13 
                 150 Count =  14 
                 160 Count =  15 
                 170 Count =  16 
                 180 Count =  17 
                 190 Count =  18 
                 200 Count =  19 
                 210 Count =  20 
                 220 Count =   0 

//Example 4: Automatic Verification of output
module fulladder(s, co, a, b, c);
  input a, b, c;
  output s, co;
  
  assign s = a ^ b ^ c;
  assign co = (a & b) | (b & c) | (a & c);
endmodule

module fulladder_test;
  reg a, b, c;
  wire s, cout;
  integer correct;
  
  fulladder FA(.s(s), .co(cout), .a(a), .b(b), .c(c));
  
  initial 
    begin
      correct = 1;
      #5 a = 1; b = 1; c = 0; #5;
      if ((s != 0) || (cout != 1))
        correct = 0;
        
      #5 a = 1; b = 1; c = 1; #5;
      if ((s != 1) || (cout != 1))
        correct = 0;
        
      #5 a = 0; b = 1; c = 0; #5;
      if ((s != 1) || (cout != 0))
        correct = 0;
        
      #5 $display("%d", correct);
    end
endmodule

//Results
1 //Shall display 1 if outputs are correct; and display 0 otherwise

//Example 5: Generating random test vectors
module adder(out, cout, a, b);
  input [7:0] a, b;
  output [7:0] out;
  output cout;
  
  assign #5 {cout, out} = a+b;
endmodule

module test_adder;
  reg [7:0] a, b;
  wire [7:0] sum;
  wire cout;
  
  integer myseed;
  
  adder ADD(.out(sum), .cout(cout), .a(a), .b(b));
  
  initial
    myseed = 15;
    
  initial
    begin
      repeat (5)
        begin
          a = $random(myseed);
          b = $random(myseed); #10;
          $display(" T = %3d, a = %h, b = %h, sum = %h", $time, a, b, sum);
        end
    end
endmodule

//Results
 T =  10, a = 00, b = 52, sum = 52
 T =  20, a = ca, b = 08, sum = d2
 T =  30, a = 0c, b = 6a, sum = 76
 T =  40, a = b1, b = 71, sum = 22
 T =  50, a = 23, b = df, sum = 02
    
  
  

  




  
  


  
  
  
  
  

  
