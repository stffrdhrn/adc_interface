/** 
 * The LED driver takes the 11:0 input as a magnitude and graphs
 * the value on an LED (like a recording mixer level display). 
 * the magnitude is update 85 times per second
 * it will output 16 PWM phases per LED
 * each PWM cycle wave will be 0 to 50% duty cycle depending on the 
 * input. 
 *
 * Because the input wave is centered at half the 12 bit dinput
 * we only need to consider the top 6 bits (assuming the bottom 
 * is a close mirror).  The 6 bits are dithered to 8 bits by the 
 * following table
 *
 */

module led_driver(leds, rst, dclk, dinput);

output [7:0] leds;
input        rst;
input        dclk;   // 44100 Hz
input  [5:0] dinput; // 85Hz (sync to 44100Hz)

reg    [7:0] leds;

wire   [2:0] din_high;

assign din_high = dinput[5:3];

always @ (posedge dclk or posedge rst)
begin
 if (rst) 
   leds <= 8'b0000_0000;
 else
   case (din_high)
     3'b000: leds <= 8'b0000_0000;
     3'b001: leds <= 8'b0000_0001;
     3'b010: leds <= 8'b0000_0011;
     3'b011: leds <= 8'b0000_0111;
     3'b100: leds <= 8'b0000_1111;
     3'b101: leds <= 8'b0001_1111;
     3'b110: leds <= 8'b0011_1111;
     3'b111: leds <= 8'b0111_1111;
   endcase
end

endmodule
