Concepts Covered :

•	Explains the basic concept of a finite state machine. 
•	Distinguishes between Moore and Mealy type finite state machines. 
•	Illustrate the Verilog modeling of a simple Moore finite state machine, along with the test bench. 
•	Explains the recommended modeling style to be used to avoid unwanted storage elements. 

//Example 1: cyclic_lamp version 1
module cyclic_lamp1(clock, light);
  input clock;
  output reg [0:2] light; 
  
  parameter S0 = 0, S1 = 1, S2 = 2;
  parameter RED = 3'b100, GREEN=3'b010, YELLOW=3'b001;
  
  reg [0:1] state;
  
  always @(posedge clock)
    case (state)
      S0 : begin             //S0 means RED
             light <= GREEN;
             state <= S1;
           end
      S1 : begin             //S1 means GREEN
             light <= YELLOW;
             state <= S2;
           end
      S2 : begin             //S2 means YELLOW
             light <= RED;
             state <= S0;
           end
      default : begin
                  light <= RED;
                  state <= S0;
                end
    endcase
endmodule

module test_cyclic_lamp;
  reg clock;
  wire [0:2] light;
  
  cyclic_lamp1 LAMP(clock, light);
  
  always #5 clock = ~clock;
  
  initial
    begin
      clock = 1'b0;
      #100 $finish;
    end
    
  initial
    begin
      $dumpfile("cyclic.vcd");
      $dumpvars(0, test_cyclic_lamp);
      $monitor($time, " RGB : %b", light);
    end
endmodule

//Results
VCD info: dumpfile cyclic.vcd opened for output.
                   0 RGB : xxx
                   5 RGB : 100
                  15 RGB : 010
                  25 RGB : 001
                  35 RGB : 100
                  45 RGB : 010
                  55 RGB : 001
                  65 RGB : 100
                  75 RGB : 010
                  85 RGB : 001
                  95 RGB : 100


//Example 1: cyclic_lamp version 2
module cyclic_lamp2(clock, light);
  input clock;
  output reg [0:2] light; 
  
  parameter S0 = 0, S1 = 1, S2 = 2;
  parameter RED = 3'b100, GREEN=3'b010, YELLOW=3'b001;
  
  reg [0:1] state;
  
  always @(posedge clock)
    case (state)
      S0 : begin             //S0 means RED
             state <= S1;
           end
      S1 : begin             //S1 means GREEN
             state <= S2;
           end
      S2 : begin             //S2 means YELLOW
             state <= S0;
           end
      default : begin
                  state <= S0;
                end
    endcase

  always @(state)    
    case (state)
      S0 : begin             //S0 means RED
             light <= GREEN;
           end
      S1 : begin             //S1 means GREEN
             light <= YELLOW;
           end
      S2 : begin             //S2 means YELLOW
             light <= RED;
           end
      default : begin
                  light <= RED;
                end
    endcase
endmodule
  
  
