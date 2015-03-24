/*
 * Rectifier circuit for the ADC output bits. 
 * Since the input wave ranges from 0 to 4096 
 * and is centered around 2048, we need to measure
 * how much the signal moves from the center. 
 *
 * This circuit creates a half rectifier. 
 */
parameter BUS_WIDTH = 6;

module rectifier(
  input  [BUS_WIDTH-1:0] din,
  output [BUS_WIDTH-1:0] dout
);

/* if high bit is set allow output otherwise nothing */
always @ (*)
if (din[BUS_WIDTH-1])
 dout = din;
else
 dout = {BUS_WIDTH{1'b0}};

endmodule