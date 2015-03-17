# _ADC Interface_

_Description: This project provides a serial (SPI) to memory mapped interface for the TI 
[ADC128S022](http://www.ti.com/lit/ds/symlink/adc128s022.pdf) analog to digital 
converter (ADC) chip as on the terasic De0 Nano._ 

The ADC chip has a 16 clock SPI protocol for making analog readings. Internally this 
verilog implementation holds a count of the current clock cycle.  When the clock cycle is
2,3,4 it sends the address bits on the DOUT SPI interface.  When the clock cycles 
are 4-15.

This implementation will read the analog reading into a shift register. 

Once all 12 bits of data are read it will store the reading into internal 
memory with 8 addresses, which can be read by another module. 

## Project Status/TODO
 - [x] Compiles
 - [ ] simulated
 - [x] confirmed in De0 Nano

## Project Setup
This project has been developed with quartus II. 

## License
BSD
