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

             
             
