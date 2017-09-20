primitive ffjk (Q, J, K, set, reset, Clk);
          input J, K, Clk, reset, set;
          output Q;
          reg Q;
          
          initial
            Q = 0;   //This is optional
            
          table
          // j  k  clk   set  reset  : q : q_new
             ?  ?  ?     1    1      : ? : -;        //ignore .. no change
             ?  ?  (10)  ?    ?      : ? : -;        //ignore .. no change 
             0  0  (01)  0    0      : ? : -;        //no change
             0  1  (01)  0    0      : ? : 0;        //reset condition            
             1  0  (01)  0    0      : ? : 1;        //set condition                         
             1  1  (01)  0    0      : 0 : 1;        //toggle condition                  
             1  1  (01)  0    0      : 1 : 0;        //toggle condition 
          endtable
endprimitive
