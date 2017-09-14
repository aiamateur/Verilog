Concepts Covered:
•	Explain with illustrative examples how the use of blocking or non-blocking assignment statements can influence the synthesis tool. 
•	Illustrates what are the proper ways to model a shift register using both blocking and non-blocking assignments. 

//Example 6: 4 bit Shift register. Assignment using blocking statements in the correct order resulting in intended behaviour
//Hence a 4 bit shift register is generated
module shiftreg_4bit(clock, clear, A, E);
       input A, clock, clear;
       output reg E;
       reg B, C, D;
       
       always @(posedge clock or negedge clear)
         begin
           if (!clear)
              begin
                B=0;
                C=0;
                D=0;
              end
           else
              begin
                E = D;
                D = C;
                C = B;
                B = A;
              end
         end
endmodule

//Example 6a: 4 bit Shift register. Assignment using blocking statements in the incorrect order resulting in unintended behaviour
#Hence a 1-bit Flip-Flop is generated, where E gets the value of A
module shiftreg_4bit(clock, clear, A, E);
       input A, clock, clear;
       output reg E;
       reg B, C, D;
       
       always @(posedge clock or negedge clear)
         begin
           if (!clear)
              begin
                B=0;
                C=0;
                D=0;
              end
           else
              begin
                B = A;
                C = B;
                D = C;
                E = D;
              end
         end
endmodule

//Example 6b: 4 bit Shift register. Assignment using non-blocking statements in any order resulting in intended behaviour 
//since original values of inputs are used, no matter what order the outputs are assigned
//Hence a 4 bit shift register is generated
module shiftreg_4bit(clock, clear, A, E);
       input A, clock, clear;
       output reg E;
       reg B, C, D;
       
       always @(posedge clock or negedge clear)
         begin
           if (!clear)
              begin
                B<=0;
                C<=0;
                D<=0;
              end
           else
              begin
                E <= D;
                D <= C;
                C <= B;
                B <= A;
              end
         end
endmodule
       
