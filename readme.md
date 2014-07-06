# _ADC Interface_

_Description: This project provides a memory mapped interface for the TI 
ADC128S022 analog to digital converter chip._ 

The chip has a 16 clock phase for making analog readings. Internally the
interface holds a count of the current clock cycle.  When the clock cycle is
2,3,4 it sends the address bits on the DOUT SPI interface.  When the clock cycles 
are 4-15 we read the analog reading into a shift register from DIN. 

We then store the reading into internal memory, which can be read by another 
mosule. 

## Project Status/TODO
Compiles
Not yet simulated
Not yet confirmed in FPGA

## Project Setup
This project has been developed with quartus II. 

## License
BSD
