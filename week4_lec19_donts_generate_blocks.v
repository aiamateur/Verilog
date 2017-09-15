Concepts Covered:
•	Discusses the pitfalls of mixing blocking and non-blocking statements inside the same procedural block. 
•	Explain how Verilog code can be generated dynamically using the “generate” blocks. 
•	Illustrate some typical usages of “generate” blocks to generate iterative structures in hardware. 

#Example 1 for xor_bitwise using generate for instanatiating multiple modules
module xor_bitwise (f, a, b);
       parameter N = 16;
       input [N-1:0] a, b;
       output [N-1:0] f;
       genvar p;
       
       generate 
            for (p = 0; p < N; p = p+1)
                begin: xorlp
                  xor XG (f[p], a[p], b[p]);
                end
       endgenerate
endmodule

module generate_test;
       reg [15:0] x, y;
       wire [15:0] out;
       
       xor_bitwise G (.f(out), .a(x), .b(y));
       
       initial
         begin
           $monitor("x = %b, y = %b, out = %b", x, y, out);
           x = 16'haaaa; y = 16'h00ff;
           #10 x = 16'h0f0f; y = 16'h3333;
           #20 $finish;
         end
endmodule
       
#Simulation Results
x = 1010101010101010, y = 0000000011111111, out = 1010101001010101
x = 0000111100001111, y = 0011001100110011, out = 0011110000111100
       
#Example 2 Design of N-bit Ripple Carry Adder
//Structural gate level description of a full adder
module full_adder(a, b, c, sum, cout);
       input a, b, c;
       output sum, cout;
       
       wire t1, t2, t3;
       
       
       xor G1 (t1, a, b);
       xor G2 (sum, t1, c);       
       and G3 (t2, a, b);
       and G4 (t3, t1, c);
       or  G5 (cout, t2, t3);
endmodule

 //Both these versions are not compiling, although I believe using full_adder(abstract) and not the full (repeated) description of full
//adder is kind of the purpose of hierarchical description 
       
//Prof's version of N-bit adder
module RCA(carry_out, sum, a, b, carry_in);
       parameter N = 8;
       input [N-1:0] a, b;
       input carry_in;         //input carry_in
       
       output [N-1:0] sum;
       output carry_out;       //output carry_out
       
       wire [N:0] carry;      //carry[N] is carry out
       
       assign carry[0] = carry_in;
       assign carry_out = carry[N];
       
       genvar i;
       
       generate
         for (i = 0; i < N; i++)
           begin: fa_loop
             wire t1, t2, t3;
             xor G1 (t1, a[i], b[i]);
             xor G2 (sum[i], t1, carry[i]);       
             and G3 (t2, a[i], b[i]);
             and G4 (t3, t1, carry[i]);
             or  G5 (carry[i+1], t2, t3);
           end
       endgenerate
endmodule      
       
       
//My version of N-bit adder       
module RCA(carry_out, sum, a, b, carry_in);
       parameter N = 8;
       input [N-1:0] a, b;
       input carry_in;         //input carry_in
       
       output [N-1:0] sum;
       output carry_out;       //output carry_out
       
       wire [N:0] carry;      //carry[N] is carry out
       
       assign carry[0] = carry_in;
       assign carry_out = carry[N];
       
       genvar i;
       
       generate
         for (i = 0; i < N; i++)
           begin: fa_loop
             //wire t1, t2, t3;
             //xor G1 (t1, a[i], b[i]);
             //xor G2 (sum[i], t1, carry[i]);       
             //and G3 (t2, a[i], b[i]);
             //and G4 (t3, t1, carry[i]);
             //or  G5 (carry[i+1], t2, t3);
             full_adder FA (a[i], b[i], c[i], sum[i], carry[i+1])
           end
       endgenerate
endmodule
           
           
