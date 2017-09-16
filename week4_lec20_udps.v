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

             
             
