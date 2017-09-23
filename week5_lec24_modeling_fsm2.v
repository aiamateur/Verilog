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



  
