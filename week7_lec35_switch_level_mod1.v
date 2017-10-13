
//Example 1: CMOS Inverter
module cmosnot(x, f);
  input x;
  output f;
  supply0 gnd;
  supply1 vdd;
  
  pmos p1 (f, vdd, x);
  nmos n1 (f, gnd, x);
endmodule

//Example 2: CMOS NAND Gate
module cmosnand(x, y, f);
  input x, y;
  output f;
  supply0 gnd;
  supply1 vdd;
  wire a;
  
  pmos p1 (f, vdd, x);
  pmos p2 (f, vdd, y);
  
  nmos n1 (f, a, x);
  nmos n2 (a, gnd, y);
endmodule

module cmosnandtest;
  reg in1, in2;
  wire out;
  
  integer k;
  
  cmosnand MYNAND2 (in1, in2, out);
  
  initial
    begin
      for(k = 0; k < 4; k = k+1)
        begin
          #5 {in1, in2} = k;
          $display("In1 : %b, In2 : %b, Out : %b", in1, in2, out);
        end
    end
endmodule

//Example 3: Pseudo-NMOS NOR Gate
module pseudonor(x, y, f);
  input x, y;
  output f;
  supply0 gnd;
  
  nmos nx (f, gnd, x);
  nmos ny (f, gnd, y);
  pullup(f);
endmodule

module pseudonor_test;
  reg in1, in2;
  wire out;
  integer k;
  
  pseudonor MYNOR2(in1, in2, out);
  
  initial
    begin
      for(k = 0; k < 4; k = k+1)
        begin
          #5 {in1, in2} = k;
          $display("In1 : %b, In2 : %b, Out : %b", in1, in2, out);
        end
    end
endmodule

//Example 4: CMOS 2x1 Multiplexer
module cmosmux_2to1(out, s, i0, i1);
  input s, i0, i1;
  output out;
  
  wire sbar;
  
  not(sbar, s);
  
  cmos cmos_a (out, i0, sbar, s);
  cmos cmos_b (out, i1, s, sbar);
endmodule

module cmosmux_test;
  reg sel, in0, in1;
  wire out;
  integer k;
  
  cmosmux_2to1 MUX21 (out, sel, in0, in1);
  
  initial
    begin
      for(k = 0; k < 8; k = k+1)
        begin
          #5 {sel, in0, in1} = k;
          $display("Sel: %b, In0 : %b, In1 : %b, Out : %b", sel, in0, in1, out);
        end
    end
endmodule


  
  

  
