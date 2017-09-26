Concepts Covered :
•	Illustrate with another example of GCD computation using repeated subtraction.
•	Show the data path diagram, controller FSM, and Verilog coding for the same.

//Example 2: GCD Computation
//The Data Path
module GCD_datapath(gt, lt, eq, ldA, ldB, sel1, sel2, sel_in, data_in, clk);
  input ldA, ldB, sel1, sel2, sel_in, clk;
  input [15:0] data_in;
  output gt, lt, eq;
  
  wire [15:0] Aout, Bout, X, Y, Bus, SubOut;
  
  PIPO A(Aout, Bus, ldA, clk);
  PIPO B(Bout, Bus, ldB, clk);
  MUX MUX_in1(X, Aout, Bout, sel1);
  MUX MUX_in2(Y, Aout, Bout, sel2);
  SUB SB(SubOut, X, Y);
  MUX MUX_load(Bus, SubOut, data_in, sel_in);  
  COMPARE COMP(lt, gt, eq, Aout, Bout);
endmodule

module PIPO(data_out, data_in, load, clk);
  input [15:0] data_in;
  input load, clk;
  output reg [15:0] data_out;
  
  always @(posedge clk)
    if(load) data_out <= data_in;

endmodule

module COMPARE(lt, gt, eq, data1, data2);
  input [15:0] data1, data2;
  output lt, gt, eq;
  
  assign lt = (data1 < data2);
  assign gt = (data1 > data2);  
  assign eq = (data1 == data2);
endmodule

module SUB(out, in1, in2);
  input [15:0] in1, in2;
  output reg [15:0] out;
  
  always @(*)
    out = (in1 - in2);
endmodule

module MUX(out, in0, in1, sel);
  input [15:0] in0, in1;
  input sel;
  output [15:0] out;
  
  assign out = sel ? in1 : in0;
endmodule

