/**
 * The max module scans the input every for a for a value and outputs
 * a new value every n clock cycles. The max value is latched to the max 
 * output when the cycle is up. 
 */
module max (din, dclk, rst, maxout);

parameter BUS_WIDTH = 6;

output [BUS_WIDTH-1:0]  maxout;
input  [BUS_WIDTH-1:0]  din;
input                   dclk;
input                   rst;

reg [BUS_WIDTH-1:0]     max_current;
reg [BUS_WIDTH-1:0]     maxout;
reg [8:0]               sample_count; // We take the max of 512 samples
                            // 44100 hz / 512 -> 85 max samples per second

wire                    sample_done;
wire [BUS_WIDTH-1:0]    max_next;

assign sample_done = (sample_count == 9'b0);
/* Next max is either current input or current max */
/* if we are done sampling then we throw out current max */
assign max_next = ((din > max_current) || sample_done)  ? din : max_current;

/* Handle sample counting */
always @ (posedge dclk or posedge rst)
  if (rst) 
    sample_count <= 9'b0;
  else
    sample_count <= sample_count + 1'b1;

/* Handle max capturing */
always @ (posedge dclk or posedge rst)
  if (rst) 
    max_current <= {BUS_WIDTH{1'b0}};
  else
    max_current <= max_next;
    
/* Handle max output when sampling is done */
always @ (posedge sample_done) begin
  if (rst) 
   maxout <= {BUS_WIDTH{1'b0}};
  else
   maxout <= max_current;
end

endmodule
