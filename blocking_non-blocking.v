//Hardware Modeling using Verilog
//Week4: Lecture 16: Blocking and Non-Blocking Assignments

//Example 1
module blocking_example;
    reg X, Y, Z;
    reg [31:0] A, B;
    integer sum;
    
    initial 
      begin
      X = 1'b0;                   //At time = 0
      Y = 1'b0;                   //At time = 0
      Z = 1'b1;                   //At time = 0
      
      sum = 1;                    //At time = 0
      A = 31'b0;                  //At time = 0
      B = 31'habababab;           //At time = 0
      #5  A[5] = 1'b1;            //At time = 5
      #10 B[31:29] ={X, Y, Z};    //At time = 15
      sum = sum + 5;              //At time = 15
      end
endmodule

//Simulation of An Example
//Example 2
module blocking_assign;
    integer a, b, c, d;
    always @(*)
      repeat (4)
        begin
          #5 a = b+c;
          #5 d = a-3;
          #5 b = d+10;
          #5 c = c+1;
        end
    
    initial
      begin
        $monitor($time, "a=%4d, b=%4d, c=%4d, d=%4d", a, b, c, d);
        a=30; b=20; c=15; d=5;
        #100 $finish;
      end
endmodule

/*
                   0a=  30, b=  20, c=  15, d=   5
                   5a=  35, b=  20, c=  15, d=   5
                  10a=  35, b=  20, c=  15, d=  32
                  15a=  35, b=  42, c=  15, d=  32
                  20a=  35, b=  42, c=  16, d=  32
                  25a=  58, b=  42, c=  16, d=  32
                  30a=  58, b=  42, c=  16, d=  55
                  35a=  58, b=  65, c=  16, d=  55
                  40a=  58, b=  65, c=  17, d=  55
                  45a=  82, b=  65, c=  17, d=  55
                  50a=  82, b=  65, c=  17, d=  79
                  55a=  82, b=  89, c=  17, d=  79
                  60a=  82, b=  89, c=  18, d=  79
                  65a= 107, b=  89, c=  18, d=  79
                  70a= 107, b=  89, c=  18, d= 104
                  75a= 107, b= 114, c=  18, d= 104
                  80a= 107, b= 114, c=  19, d= 104
                  */
