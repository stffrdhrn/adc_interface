/* 
 * Top level module that interfaces with and ADC 
 * and outputs the result on 7 inline LEDs like a VU 
 * meter. 
 */
module signal_display (
  input        adc_sdat,  // \
  output       adc_saddr, // | - ADC interface
  output       adc_sclk,  // |
  output       adc_cs_n,  ///
  input        rst_n,
  input        clk,       // 44,000hz x 16 x 4
  output [7:0] leds
);

wire        dclk;          // divided clock (44,000hz)
wire        rst;
wire [1:0]  adc_addr;
wire [11:0] adc_data;
wire [11:0] rectified_data;
wire [11:0] max;

assign adc_sclk = clk;
assign adc_addr = 2'b00;   // always select ADC input 0
assign rst = ~rst_n;       // rst_n is usually high, reset when low
assign adc_cs_n = rst;     // rst is usually low, select adc then

// Interface with ADC 
//   - addr and data are parrallel interface 
//   - din/dout are serial interface with ADC chip
adc_interface adc_interfacei (
   .addr(adc_addr), // hard coded to 00 for now
   .data(adc_data),
   .sclk(clk),      // signal clock
   .rst(rst),
   .din(adc_sdat),
   .dout(adc_saddr));
     
// Clock divider by 64 (bring clk down to 44Khz)
clkdiv clkdivi (
  .clk_in(clk),
  .clk_out(dclk),
  .rst(rst));     

// Just output values that are above 2048 (midpoint)
rectifier rectifieri (
   .din(adc_data), 
   .dout(rectified_data));
  
// Max get the max adc value every 85hz
max maxi (
   .din(rectified_data), 
   .dclk(dclk), 
   .rst(rst), 
   .maxout(max));

// Output the max value onto 7 inline leds
led_driver led_driveri (
   .leds(leds), 
   .rst(rst), 
   .dclk(dclk), 
   .dinput(max));

endmodule