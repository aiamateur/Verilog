
// Copyright (c) 2017 ABC123!@#
// ---------------------------------------------- 
// FILE NAME: counter.v 
// TYPE: module 
// DEPARTMENT: xxx
// AUTHOR: aiamateur
// AUTHOR’S EMAIL: xyz@abc.com
//------------------------------------------------ 
// Release history 
// VERSION DATE AUTHOR DESCRIPTION 
// 1.0 10/08/2016 xyz Initial version 
// 2.0 12/07/2017 vbn Updated version with clear 
// 2.1 16/08/2017 xyz Asynchronous clear 
//------------------------------------------------ 
// KEYWORDS:  binary counter, asynchronous clear 
//------------------------------------------------ 
// PURPOSE:   16-bit binary counter 

module counter (data, clear, clock); 
 output reg [15:0] data;  // The 16-bit count value 
 input  clear;            // Asynchronous clear 
 input clock;             // Counter clock   
 // 16-bit binary counter with asynchronous clear 
 always @(posedge clock or negedge clear)   
   if (!clear)     data <= 16’b0000000000000000;  // Clear counter   
   else     data <= data + 1; 
 endmodule 
