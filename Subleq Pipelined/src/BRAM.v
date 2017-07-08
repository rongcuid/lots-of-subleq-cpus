// ----------------------------------------------------------------------------------
// -- Company: The Most Awesome Mad Scientist Ever
// -- Engineer: Rongcui Dong
// --
// -- Create Date: 06/29/2017 07:16:10 PM
// -- Design Name:
// -- Module Name: BRAM
// -- Project Name:
// -- Target Devices:
// -- Tool Versions:
// -- Description:
// --
// -- Dependencies:
// --
// -- Revision:
// -- Revision 0.01 - File Created
// -- Additional Comments:
// -- This is a single port BRAM
// ----------------------------------------------------------------------------------

module BRAM_sp(
	       clk, we, en, addr, data_in, data_out
	       );
   parameter WIDTH = 8, DEPTH = 1024, DEPTH_LOG = 10;
   input wire clk;
   input wire we;
   input wire en;
   input wire [WIDTH-1:0] data_in;
   // Note that this is combinational
   output reg [WIDTH-1:0] data_out;

   // Internal storage
   reg [WIDTH-1:0] 	  data [0:DEPTH-1];
   always @ (posedge clk) begin
      if (en) begin
	 if (we) begin
	    data[addr] <= data_in;
	    data_out = di;
	 end
	 else begin
	    data_out = data[addr];
	 end
      end
   end
endmodule
