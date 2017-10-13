//Example 2: Single-port RAM with synchronous read/write
module ram_1(addr, data, clk, rd, wr, cs);
  input [9:0] addr;
  input clk, rd, wr, cs;
  inout [7:0] data;
  
  reg [7:0] mem[1023:0];
  reg [7:0] d_out;
  
  assign data = (cs && rd) ? d_out : 8'bz;
  
  always @(posedge clk)
    if (cs && wr && !rd) mem[addr] = data; 
    
  always @(posedge clk)
    if (cs && rd && !wr) d_out = mem[addr]; 
endmodule

//Example 3: Single-port RAM with asynchronous read/write
module ram_2(addr, data, clk, rd, wr, cs);
  input [9:0] addr;
  input clk, rd, wr, cs;
  inout [7:0] data;
  
  reg [7:0] mem[1023:0];
  reg [7:0] d_out;
  
  assign data = (cs && rd) ? d_out : 8'bz;
  
  always @(addr or data or cs or wr or rd)
    if (cs && wr && !rd) mem[addr] = data; 
    
  always @(addr or data or cs or wr or rd)
    if (cs && rd && !wr) d_out = mem[addr]; 
endmodule

//Example 4: A ROM/EPROM
module rom(addr, data, rd_en, cs);
  input [2:0] addr;
  input rd_en, cs;
  
  output reg [7:0] data;
  
  always @(addr or rd_en or cs)
    case (addr)
      0: data = 22;
      1: data = 45;
      2: data = 212;
      3: data = 435;
      4: data = 282;
      5: data = 435;
      6: data = 220;
      7: data = 4005;
    endcase
endmodule

//Example 5: ram_3
module ram_3(data_out, data_in, addr, wr, cs);
  parameter addr_size = 10, word_size = 8, memory_size = 1024;
  
  input [addr_size-1 : 0] addr;
  input [word_size-1 : 0] data_in;  
  input wr, cs;
  output [word_size-1 : 0] data_out;  
  
  reg [word_size-1 : 0] mem[memory_size-1:0];
  
  assign data_out = mem[addr];
  
  always @(wr or cs)
    if(wr) mem[addr] = data_in;
endmodule

//Simple Test Bench using ram_3
module RAM_test;
  reg [9:0] address;
  wire [7:0] data_out;
  reg [7:0] data_in;
  reg write, select;
  integer k, myseed;
  
  ram_3 RAM(data_out, data_in, address, write, select);
  
  initial
    begin
      for(k = 0; k <= 1023; k = k+1)
        begin
          address = k;
          data_in = (k + k) % 256;
          //read = 0;
          write = 1;
          select = 1;
          #2 write = 0; select = 0;
        end
      repeat(20)
        begin
          #2 address = $random(myseed) % 1024;
          write = 0;
          select = 1;
          $display("Address : %5d, Data : %4d", address, data_out);
          #2 select = 0;
        end
    end
    
  initial
    myseed = 35;
endmodule
