module clkdiv (
  input clk_in,
  output clk_out,
  input rst
);

/* div by 16 * 4 = 64 
   div by = 2 ^ (bits - 1)

*/
  // 1 bit - no delay
  // 2 bit - div by 2
  // 3 bit - div by 4
  // 4 bit - div by 8
  // 5 bit - div by 16
  // 6 bit - div by 32
  // 7 bit - div by 64
  
reg [6:0] div_counter;

assign clk_out = div_counter[6];

always @ (posedge clk_in or posedge rst)
 if (rst)
   div_counter <= 7'b0;
 else
   div_counter <= div_counter + 1'b1;
 
endmodule