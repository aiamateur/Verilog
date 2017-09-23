//Example 2: version 1 parity_gen, test_parity
module parity_gen1(x, clk, z);
  input x, clk;
  output reg z;
  
  reg even_odd; //The machine state
  
  parameter EVEN=0, ODD=1;
  
  always @(posedge clk)
    case (even_odd)
      EVEN : begin
               z <= x ? 1 : 0;
               even_odd <= x ? EVEN : ODD;
             end
      ODD  : begin
               z <= x ? 0 : 1;
               even_odd <= x ? ODD : EVEN;
             end
      default: begin
                 even_odd <= EVEN;
               end
    endcase
endmodule

//This design will cause the sysnthesis tool to generate a latch for the output "z"

module test_parity;
  reg x, clk;
  wire z;
  
  parity_gen1 PAR(x, clk, z);
  
  initial
    begin
      $dumpfile("parity.vcd");
      $dumpvars(0, test_parity);
      clk = 1'b0;
    end
    
  always
    #5 clk = ~clk;
    
  initial
    begin
      #2  x = 0; #10 x = 1; #10 x = 1; #10 x = 1;
      #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
      #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
      #10 $finish;
    end
    
endmodule

//Example 2: version 2 parity_gen
module parity_gen2(x, clk, z);
  input x, clk;
  output reg z;
  
  reg even_odd; //The machine state
  
  parameter EVEN=0, ODD=1;
  
  always @(posedge clk)
    case (even_odd)
      EVEN : begin
               even_odd <= x ? EVEN : ODD;
             end
      ODD  : begin
               even_odd <= x ? ODD : EVEN;
             end
      default: begin
                 even_odd <= EVEN;
               end
    endcase
    
  always @(even_odd)
    case (even_odd)
      EVEN : begin
               z = 1;
             end
      ODD  : begin
               z = 0;
             end
    endcase
endmodule
//This design will not cause the synthesis tool to generate a latch for the output "z"

//Example 3: Sequence detector for pattern "0110"
//This is not compiling

module seq_detector(x, clk, reset, z);
  input x, clk, reset;
  output reg z;

  parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
  reg [0:1] PS, NS;
  
  always @(posedge clk or posedge reset)
    if(reset) PS <= S0;
    else      PS <= NS;
    
  always @(PS, x)
    case (PS)
      S0 : begin
             z  = x ? 0 : 0;
             NS = x ? S0 : S1;
           end
      S1 : begin
             z  = x ? 0 : 0;
             NS = x ? S2 : S1;
           end 
      S2 : begin
             z  = x ? 0 : 0;
             NS = x ? S3 : S1;
           end
      S3 : begin
             z  = x ? 0 : 1;
             NS = x ? S0 : S1;
           end
    endcase
endmodule

module test_sequence;
  reg x, clk, reset;
  wire z;
  
  seq_detector SEQ(x, clk, reset, z);
  
  initial
    begin
      $dumpfile("sequence.vcd");
      $dumpvars(0, test_sequence);
      clk = 1'b0; reset = 1'b1;
      #15 reset = 1'b0; 
    end
    
  always
    #5 clk = ~clk;
    
  initial
    begin
      #12 x = 0; #10 x = 0; #10 x = 1 ; #10 x = 1;
      #10 x = 0; #10 x = 1; #10 x = 1 ; #10 x = 0;
      #10 x = 0; #10 x = 1; #10 x = 1 ; #10 x = 0;
      #10 $finish;
    end
    
endmodule
  




  
