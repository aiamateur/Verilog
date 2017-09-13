Concepts Covered:
•	Illustrates a multiplexer design using blocking assignment. 
•	Illustrates a up/down counter and parameterized N-bit counter using non-blocking assignment. 
•	Illustrates how to use more than one clock, or both the edges of the same clock, to trigger events in the same module. 
•	Illustrates the design of a ring counter using both blocking and non-blocking assignments. 
       
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

//Example 3 Parameterized design: an N-bit counter

module counter(clear, clk, count);
       parameter N = 7;
       input clear, clk;
       output reg [0:N] count;

       always @(negedge clk)
         begin
           if (clear)     count <= count+1;
           else           count <= count-1;
         end
endmodule

//Example 4 - Using more than one clock in a module
//Both always blocks using clk1, clk2 operate concurrently
module multiple_clk(a, b, f);
       input a, b;
       output reg f, t;

       always @(posedge clk1)
         f1 <= a&b;
       always @(negedge clk2)
         f2 <= b^c;

endmodule

//Example 5 - Using multiple edges on the same clock

module multi_edge_clk(a, b, f, clk);
       input a, b, clk;
       output reg f;
       reg t;

       always @(posedge clk)
         f <= t&b;
       always @(negedge clk)
         t <= a|b;

endmodule
       
//Example 6 - Using multiple edges on the same clk - another example      
module multi_edge_clk1(a, b, c, d, f, clk);
       input clk;
       input [7:0] a, b, c, d;
       output reg [7:0] f;
       reg [7:0] t;
       //reg t;

       always @(posedge clk)
         t <= a+b;
       always @(negedge clk)
         f <= t-d;

endmodule
   
//Example 7: Ring counter wrong design using blocking assignments
module ring_counter(clk, init, count);
       input clk, init;
       output reg [7:0] count;
       
       always @(posedge clk)
         begin
           if(init) count = 8'b10000000;
           else
             begin
               count = count << 1;   //Wrong Design - Count is updated first, losing left most bit
               count[0] = count[7];  //original left most bit is gone, so new bit 7 goes to bit 0
             end
         end
endmodule

//Example 8: Ring counter right design using non-blocking assignments
module ring_counter(clk, init, count);
       input clk, init;
       output reg [7:0] count;
       
       always @(posedge clk)
         begin
           if(init) count = 8'b10000000;
           else
             begin
               count <= count << 1;   //Right Design - Count is shifted left using initial count
               count[0] <= count[7];  //Count original's left most bit(7) is used to rotate into bit 0
             end
         end
endmodule
       
//Example 9: Ring counter right design using blocking assignments       
module ring_counter2(clk, init, count);
       input clk, init;
       output reg [7:0] count;
       
       always @(posedge clk)
         begin
           if(init) count = 8'b10000000;
           else
             begin
               count = {count[6:0], count[7]}; 
               //Correct as the assignment is happening from old value of count
             end
         end
endmodule

       
          
           

           


           
