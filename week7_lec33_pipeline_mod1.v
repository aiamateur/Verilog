//Example 1
//Pipeline Modelling

module pipe_ex(F, A, B, C, D, clk);
  parameter N = 10;
  
  input [N-1:0] A, B, C, D;
  input clk;
  output [N-1:0] F;
  
  reg [N-1:0] L12_x1, L12_x2, L12_D, L23_x3, L23_D, L34_F;
  
  assign F = L34_F;
  
  always @(posedge clk)
    begin
      L12_x1 <= #4 A + B;
      L12_x2 <= #4 C - D;
      L12_D  <= D;                   // ** STAGE 1 **
      
      L23_x3 <= #4 L12_x1 + L12_x2;  
      L23_D  <= D;                   // ** STAGE 2 **
      
      L34_F  <= #6 L23_x3 * L23_D;   // ** STAGE 3 **
    end
endmodule

//Alternate way of coding:
//One stage per always block
//Code is more readable

module pipe_ex_alt(F, A, B, C, D, clk);
  parameter N = 10;
  
  input [N-1:0] A, B, C, D;
  input clk;
  output [N-1:0] F;
  
  reg [N-1:0] L12_x1, L12_x2, L12_D, L23_x3, L23_D, L34_F;
  
  assign F = L34_F;
  
  always @(posedge clk)
    begin
      L12_x1 <= #4 A + B;
      L12_x2 <= #4 C - D;
      L12_D  <= D;                   // ** STAGE 1 **
    end
    
  always @(posedge clk)
    begin
      L23_x3 <= #4 L12_x1 + L12_x2;  
      L23_D  <= D;                   // ** STAGE 2 **
    end
    
  always @(posedge clk)
    begin
      L34_F  <= #6 L23_x3 * L23_D;   // ** STAGE 3 **
    end
    
endmodule

//Pipeling Test Bench
module pipe1_test;
  parameter N = 10;

  wire [N-1:0] F;
  reg [N-1:0] A, B, C, D;
  reg clk;
  
  pipe_ex MYPIPE(F, A, B, C, D, clk);
  
  initial clk = 0;
  
  always #10 clk = ~clk;
  
  initial 
    begin
      #5  A = 10; B = 12; C = 6; D = 3;  
      #20 A = 10; B = 10; C = 5; D = 3;  
      #20 A = 20; B = 11; C = 1; D = 4;  
      #20 A = 15; B = 10; C = 8; D = 2;   
      #20 A = 8; B = 15; C = 5; D = 0;  
      #20 A = 10; B = 20; C = 5; D = 3;   
      #20 A = 10; B = 10; C = 30; D = 1;  
      #20 A = 30; B = 1; C = 2; D = 4;  
    end
    
  initial
    begin
      $dumpfile("pipe1.vcd");
      $dumpvars(0, pipe1_test);
      $monitor("Time : %d,F = %d", $time, F);
      #300 $finish;
    end
endmodule
  
  
  
      
      
  
