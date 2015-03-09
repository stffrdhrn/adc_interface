/**
 * The max module scans the input every for a for a value and outputs
 * a new value every n clock cycles. The max value is latched to the max 
 * output when the cycle is up. 
 */
module max 
    (input  [11:0]  din,
     output [11:0]  max,
     input          rst,
     input          dclk);

endmodule
