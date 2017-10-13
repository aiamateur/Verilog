//Example 1
// 4x32 register file

module regbank_v1(rdData1, rdData2, wrData, sr1, sr2, dr, write, clk);
  input clk, write;
  input [1:0] sr1, sr2, dr;   //Source and destination registers
  input [31:0] wrData;
  output reg [31:0] rdData1, rdData2;
  reg [31:0] R0, R1, R2, R3;
  
  always @(*)
    begin 
      case (sr1)
        0 : rdData1 = R0;
        1 : rdData1 = R1;    
        2 : rdData1 = R2;
        3 : rdData1 = R3;  
        default : rdData1 = 32'hxxxxxxxx;
      endcase
    end
    
  always @(*)
    begin 
      case (sr2)
        0 : rdData2 = R0;
        1 : rdData2 = R1;    
        2 : rdData2 = R2;
        3 : rdData2 = R3;  
        default : rdData2 = 32'hxxxxxxxx;
      endcase
    end
    
  always @(posedge clk)
    begin 
      case (sr2)
        0 : R0 = wrData;
        1 : R1 = wrData;    
        2 : R2 = wrData;
        3 : R3 = wrData;
      endcase
    end
endmodule


//Example 2
// 4x32 register file

module regbank_v2(rdData1, rdData2, wrData, sr1, sr2, dr, write, clk);
  input clk, write;
  input [1:0] sr1, sr2, dr;   //Source and destination registers
  input [31:0] wrData;
  output [31:0] rdData1, rdData2;
  reg [31:0] R0, R1, R2, R3;
  
  assign rdData1 = (sr1 == 0)? R0 :
                   (sr1 == 1)? R1 :
                   (sr1 == 2)? R2 :
                   (sr1 == 3)? R3 : 0;

  assign rdData2 = (sr2 == 0)? R0 :
                   (sr2 == 1)? R1 :
                   (sr2 == 2)? R2 :
                   (sr2 == 3)? R3 : 0;
    
  always @(posedge clk)
    begin 
      case (sr2)
        0 : R0 = wrData;
        1 : R1 = wrData;    
        2 : R2 = wrData;
        3 : R3 = wrData;
      endcase
    end
endmodule

//Example 3
// 32x32 register file 

module regbank_v3(rdData1, rdData2, wrData, sr1, sr2, dr, write, clk);
  input clk, write;
  input [4:0] sr1, sr2, dr;   //Source and destination registers
  input [31:0] wrData;
  output [31:0] rdData1, rdData2;
  
  reg [31:0] regfile[0:31];
  
  assign rdData1 = regfile[sr1] ;
  assign rdData2 = regfile[sr2] ;
    
  always @(posedge clk)
      if(write) regfile[dr] <= wrData;
endmodule

//Example 4
// 32x32 register file with reset facility

module regbank_v4(rdData1, rdData2, wrData, sr1, sr2, dr, write, reset, clk);
  input clk, write, reset;
  input [4:0] sr1, sr2, dr;   //Source and destination registers
  input [31:0] wrData;
  output [31:0] rdData1, rdData2;
  integer k;
  
  reg [31:0] regfile[0:31];
  
  assign rdData1 = regfile[sr1] ;
  assign rdData2 = regfile[sr2] ;
    
  always @(posedge clk)
      if(reset) 
        begin
          for(k = 0; k < 32; k=k+1)
            begin
              regfile[k] <= 0;
            end
        end
      else
        begin 
          if(write) regfile[dr] <= wrData;
        end
endmodule

//A test bench to verify operation of the register file
module regfile_test;
  reg [4:0] sr1, sr2, dr;
  reg [31:0] wrData;
  reg write, reset, clk;
  wire [31:0] rdData1, rdData2;
  integer k;
  
  regbank_v4 REG4(rdData1, rdData2, wrData, sr1, sr2, dr, write, reset, clk);
  
  initial clk = 0;

  always #5 clk = ~clk;
  
  initial 
    begin
      $dumpfile("regfile.vcd");
      $dumpvars(0, regfile_test);
      #1 reset = 1;
      write = 0;
      #5 reset = 0;
    end
    
  initial 
    begin
      $dumpfile("regfile.vcd");
      $dumpvars(0, regfile_test);
      #1 reset = 1;
      write = 0;
      #5 reset = 0;
    end
    
  initial
    begin
      #7
      for(k = 0; k < 32; k = k+1)
        begin
          dr = k;
          wrData = 10*k;
          write = 1;
          #10 write = 0;
        end
      
      #20
      for(k = 0; k < 32; k = k+2)
        begin
          sr1 = k;
          sr2 = k + 1;
          #5
          $display("reg[%2d] = %d, reg[%2d] = %d", sr1, rdData1, sr2, rdData2);
        end
        
      #2000
      $finish;
    end
endmodule
  
  
  
  
  
  
