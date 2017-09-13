//Example 1 8 to 1 mux
module mux_8to1(in, sel, out);
       input [7:0] in;
       input [2:0] sel;
       output reg out;
       
       always @(*)
         begin
           case(sel)
              3'b000: out = in[0];
              3'b001: out = in[0];
              3'b010: out = in[0];
              3'b011: out = in[0];
              3'b100: out = in[0];
              3'b101: out = in[0];
              3'b110: out = in[0];
              3'b111: out = in[0];
              default: out = 1'bx;
           endcase
         end
endmodule

//Example 2 synchronous counter
module counter(mode, clr, ld, d_in, clk, count);
       input mode, clr, ld, clk;
       input [0:7] d_in;
       output reg [7:0] count;
       
       always @(posedge clk)
         begin
           if (ld)        count <= d_in;
           else if (clr)  count <= 0;
           else if (mode) count <= count+1;
           else           count <= count-1;
         end
endmodule


           
