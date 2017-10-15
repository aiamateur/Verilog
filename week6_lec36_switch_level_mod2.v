//Example 5 : CMOS 4x1 Multiplexer using "tran" switches

module mux_4to1(out, s0, s1, i0, i1, i2, i3);
  input s0, s1, i0, i1, i2, i3;
  output out;
  
  wire t0, t1, t2, t3;
  
  tranif0(i0, t0, s0);
  tranif0(t0, out, s1);
  tranif0(i1, t1, s0);
  tranif1(t1, out, s1);
  tranif1(i2, t2, s0);
  tranif0(t2, out, s1);
  tranif1(i3, t3, s0);
  tranif1(t3, out, s1);
endmodule

//Test Bench
/*module mux41_test;
  reg s0, s1, i0, i1, i2, i3;
  wire out;
  integer k;
  
  mux_4to1 MYMUX41 (out, s0, s1, i0, i1, i2, i3);
  
  initial
    begin
      for(k = 0; k < 64; k = k+1)
        begin
          #5 {s0, s1, i0, i1, i2, i3} = k;
          $display("Sel: %2b, In: %4b, Out: %b", {s0, s1}, {i0, i1, i2, i3}, out);
        end
    end
endmodule*/

//Example: Full Adder using Transistor Level Modeling
module fulladder(sum, cout, a, b, cin);
  input a, b, cin;
  output sum, cout;
  fa_sum SUM (sum, a, b, cin);
  fa_carry CARRY (cout, a, b, cin);
endmodule

module fa_carry(cout, a, b, cin);
  input a, b, cin;
  output cout;
  
  wire t1, t2, t3, t4, t5;
  
  cmosnand N1 (t1, a, b);
  cmosnand N2 (t2, a, cin);
  cmosnand N3 (t3, b, cin);
  cmosnand N4 (t4, t1, t2);
  cmosnand N5 (t5, t4, t4);
  cmosnand N6 (cout, t5, t3);
endmodule

module myxor2(out, a, b);
  input a, b;
  output out;
  
  wire t1, t2, t3, t4;
  
  cmosnand N1 (t1, a, a);
  cmosnand N2 (t2, b, b);  
  cmosnand N3 (t3, a, t2);
  cmosnand N4 (t4, b, t1);
  cmosnand N5 (t5, t3, t4);
endmodule

module fa_sum(sum, a, b, cin);
  input a, b, cin;
  output sum;
  
  wire t1, t2;
  
  myxor2 X1 (t1, a, b);
  myxor2 X2 (sum, t1, cin);
endmodule

module cmosnand(f, x, y);
  input x, y;
  output f;
  
  wire a;
  
  supply1 vdd;
  supply0 gnd;
  
  pmos p1 (f, vdd, x);
  pmos p2 (f, vdd, y);
  nmos n1 (f, a, x);
  nmos n2 (gnd, a, y);
endmodule

//Test Bench
module fulladder_test;
  reg a, b, cin;
  wire sum, cout;
  integer k;
  
  fulladder FA (sum, cout, a, b, cin);
  
  initial
    begin
      for(k = 0; k < 8; k = k+1)
        begin
          #5 {a, b, cin} = k;
          $display("Inputs: %3b, Sum: %b, Carry: %b", {a, b, cin}, sum, cout);
        end
    end
endmodule
  
