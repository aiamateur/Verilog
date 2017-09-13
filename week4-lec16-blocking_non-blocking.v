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

//Example 3
module non_blocking_example;
    integer a, b, c;
    
    initial 
      begin
        a = 10;
        b = 20;
        c = 15;
      end
      
    initial
      begin
        a <= #5 b+c;     //a is assigned 35 at t= 5
        b <= #5 a+5;     //b is assigned 15 at t= 5
        c <= #5 a-b;     //c is assigned -5 at t= 5
      end
      
    initial
      begin
        $monitor($time, " a=%4d, b=%4d, c=%4d ", a, b, c);
        #100 $finish;
      end
      
endmodule

/*                 0 a=  10, b=  20, c=  15 
                   5 a=  35, b=  15, c= -10 
*/

//Example 4
module non_blocking_assign_tb_example;
    integer a, b, c, d;
    reg clock;
    
    always @(posedge clock)
      begin
        a <= b+c;
        d <= a-3;
        b <= d+10;
        c <= c+1;
      end
      
    initial
      begin
        $monitor($time, "a=%4d, b=%4d, c=%4d, d=%4d", a, b, c, d);
        a=30; b=20; c=15; d=5;
        clock = 0;
        forever #5 clock = ~clock;
      end
      
    initial
      begin
        #100 $finish;
      end
    
endmodule

/* Results
                   0a=  30, b=  20, c=  15, d=   5
                   5a=  35, b=  15, c=  16, d=  27
                  15a=  31, b=  37, c=  17, d=  32
                  25a=  54, b=  42, c=  18, d=  28
                  35a=  60, b=  38, c=  19, d=  51
                  45a=  57, b=  61, c=  20, d=  57
                  55a=  81, b=  67, c=  21, d=  54
                  65a=  88, b=  64, c=  22, d=  78
                  75a=  86, b=  88, c=  23, d=  85
                  85a= 111, b=  95, c=  24, d=  83
                  95a= 119, b=  93, c=  25, d= 108
 */
    
