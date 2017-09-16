// Example 1: Full adder sum generation using UDP
primitive udp_sum (sum, a, b, c);
          input a, b, c;
          output sum;
          
          table
          // a b c : sum
             0 0 0 : 0;
             0 0 1 : 1;
             0 1 0 : 1;
             0 1 1 : 0;
             1 0 0 : 1;
             1 0 1 : 0;
             1 1 0 : 0;
             1 1 1 : 1;
          endtable
endprimitive

// Example 2: Full adder carry generation using UDP
primitive udp_cy (cout, a, b, c);
          input a, b, c;
          output cout;
          
          table
          // a b c : sum
             0 0 0 : 0;
             0 0 1 : 0;
             0 1 0 : 0;
             0 1 1 : 1;
             1 0 0 : 0;
             1 0 1 : 1;
             1 1 0 : 1;
             1 1 1 : 1;
          endtable
endprimitive

// Example 3: Full adder carry generation using UDP
// using dont care ("?")
primitive udp_cyx (cout, a, b, c);
          input a, b, c;
          output cout;
          
          table
          // a b c : sum
             0 0 ? : 0;
             0 ? 0 : 0;
             ? 0 0 : 0;
             1 1 ? : 1;
             1 ? 1 : 1;
             ? 1 1 : 1;
          endtable
endprimitive

//Example 4: Instantiating UDP
//A full adder description
module full_Adder (sum, cout, a, b, c);
       input a, b, c;
       output sum, cout;
       
       udp_sum SUM (sum, a, b, c);
       udp_cy  CARRY (cout, a, b, c);
endmodule

// Example 5: A 4-input AND function
// using dont care ("?")
primitive udp_and4 (f, a, b, c, d);
          input a, b, c, d;
          output f;
          
          table
          // a b c d : f
             0 ? ? ? : 0;
             ? 0 ? ? : 0;
             ? ? 0 ? : 0;
             ? ? ? 0 : 0;
             1 1 1 1 : 1;
          endtable
endprimitive

// Example 6: A 4-input OR function
// using dont care ("?")
primitive udp_or4 (f, a, b, c, d);
          input a, b, c, d;
          output f;
          
          table
          // a b c d : f
             1 ? ? ? : 1;
             ? 1 ? ? : 1;
             ? ? 1 ? : 1;
             ? ? ? 1 : 1;
             0 0 0 0 : 0;
          endtable
endprimitive

// Example 7:  4-to-1 multiplexer
// using dont care ("?")
primitive udp_mux41 (f, s0, s1, i0, i1, i2, i3);
          input s0, s1, i0, i1, i2, i3, i4;
          output f;
          
          table
          // s0 s1 i0 i1 i2 i3 : f
             0  0  0  ?  ?  ?  : 0;
             0  0  1  ?  ?  ?  : 1;
             0  1  ?  0  ?  ?  : 0;
             0  1  ?  1  ?  ?  : 1;
             1  0  ?  ?  0  ?  : 0;
             1  0  ?  ?  1  ?  : 1;
             1  1  ?  ?  ?  0  : 0;
             1  1  ?  ?  ?  1  : 1;
          endtable
endprimitive

// Example 8: A level-sensitive D-type latch
primitive Dlatch (q, d, clk, clr);
          input d, clk, clr;
          output reg q;
          
          initial
            begin
              q = 0;   //This is optional
            end
            
          table
          // d clk clr : q : q_new
             ? ?   1   : ? : 0;        //latch is cleared
             0 1   0   : ? : 0;        //latch is reset
             1 1   1   : ? : 1;        //latch is set
             ? 0   0   : ? : -;        //retains previous state
          endtable
endprimitive

// Example 9; A T flip-flop
primitive TFF (q, clk, clr);
          input clk, clr;
          output reg q;
          
          initial
            q = 0;   //This is optional
            
          table
          // clk   clr  : q : q_new
             ?     1    : ? : 0;        //FF is cleared
             ?     (10) : ? : -;        //ignore negative edge of "clr"
             (10)  0    : 1 : 0;        //FF toggles at negative edge of "clk"
             (10)  0    : 0 : 1;        //-do-
             (0?)  0    : ? : -;        //ignore positive edge of "clk"
          endtable
endprimitive

//Example 10: onstructing a 6-bit ripple counter using T Flip-Flops

module ripple_counter (count, clk, clr):
       input clk, clr;
       output [5:0] count;
       
       TFF F0 (count[0], clk, clr);
       TFF F1 (count[1], count[0], clr);
       TFF F2 (count[2], count[1], clr);
       TFF F3 (count[3], count[2], clr);
       TFF F4 (count[4], count[3], clr);  
       TFF F5 (count[5], count[4], clr);
endmodule

             
// Example 11: A negative edge sensitive of a JK Flip-Flop
primitive JKFF (q, j, k, clk, clr);
          input j, k, clk, clr;
          output reg q;
          
          initial
            q = 0;   //This is optional
            
          table
          // j  k  clk   clr  : q : q_new
             ?  ?  ?     1    : ? : 0;        //clear
             ?  ?  ?     (10) : ? : -;        //ignore .. no change             
             0  0  (10)  0    : ? : -;        //no change                
             0  1  (10)  0    : ? : 0;        //reset condition               
             1  0  (10)  0    : ? : 1;        //set condition             
             1  1  (10)  0    : 0 : 1;        //toggle condition                  
             1  1  (10)  0    : 1 : 0;        //toggle condition 
             ?  ?  (01)  0    : ? : -;        //no change
          endtable
endprimitive

// Example 12: A positive edge sensitive of a SR Flip-Flop
primitive SRFF (q, s, r, clk, clr);
          input s, r, clk, clr;
          output reg q;
          
          initial
            q = 0;   //This is optional
            
          table
          // s  r  clk   clr  : q : q_new
             ?  ?  ?     1    : ? : 0;        //clear
             ?  ?  ?     (10) : ? : -;        //ignore .. no change             
             0  0  (01)  0    : ? : -;        //no change                
             0  1  (01)  0    : ? : 0;        //reset condition               
             1  0  (01)  0    : ? : 1;        //set condition             
             1  1  (01)  0    : ? : x;        //invalid condition                  
             ?  ?  (10)  0    : ? : -;        //ignore .. no change 
          endtable
endprimitive


             
