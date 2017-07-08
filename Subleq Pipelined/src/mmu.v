// ----------------------------------------------------------------------------------
// -- Company: The Most Awesome Mad Scientist Ever
// -- Engineer: Rongcui Dong
// --
// -- Create Date:
// -- Design Name:
// -- Module Name: MMU
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
// --
// ----------------------------------------------------------------------------------

module mmu (clk, resetb, we, en, addr, 
	    be7n, be6n, be5n, be4n, 
	    be3n, be2n, be1n, be0n,
	    data_in, data_out
	    );
   parameter DEPTH_BANK = 1024, DEPTH_LOG = 10;
   input wire clk, resetb, we, en;
   input wire [28:0] addr;
   input wire 	     be7n, be6n, be5n, be4n, be3n, be2n, be1n, be0n;
   input wire [63:0] data_in;
   output reg [63:0] data_out;

   // Control lines for memory bank
   reg 		     we_ram0, en_ram0;
   reg 		     we_ram1, en_ram1;
   reg 		     we_ram2, en_ram2;
   reg 		     we_ram3, en_ram3;
   reg 		     we_ram4, en_ram4;
   reg 		     we_ram5, en_ram5;
   reg 		     we_ram6, en_ram6;
   reg 		     we_ram7, en_ram7;
   // Data lines for memory bank
   wire [7:0] 	     di_ram0, di_ram1, di_ram2, di_ram3, di_ram4, di_ram5, di_ram6, di_ram7;
   reg [7:0] 	     do_ram0, do_ram1, do_ram2, do_ram3, do_ram4, do_ram5, do_ram6, do_ram7;
   wire [63:0] 	     do_ram;

   BRAM_sp #(.WIDTH(8)) ram0(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram0), .data_out(do_ram0));
   BRAM_sp #(.WIDTH(8)) ram1(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram1), .data_out(do_ram1));
   BRAM_sp #(.WIDTH(8)) ram2(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram2), .data_out(do_ram2));
   BRAM_sp #(.WIDTH(8)) ram3(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram3), .data_out(do_ram3));
   BRAM_sp #(.WIDTH(8)) ram4(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram4), .data_out(do_ram4));
   BRAM_sp #(.WIDTH(8)) ram5(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram5), .data_out(do_ram5));
   BRAM_sp #(.WIDTH(8)) ram6(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram6), .data_out(do_ram6));
   BRAM_sp #(.WIDTH(8)) ram7(
			     .clk(clk), .we(we), .en(en), .addr(addr),
			     .data_in(di_ram7), .data_out(do_ram7));

   // Memory bank input is interleaved
   assign di_ram0 = data_in[0+:8];
   assign di_ram1 = data_in[8+:8];
   assign di_ram2 = data_in[16+:8];
   assign di_ram3 = data_in[24+:8];
   assign di_ram4 = data_in[32+:8];
   assign di_ram5 = data_in[40+:8];
   assign di_ram6 = data_in[48+:8];
   assign di_ram7 = data_in[56+:8];
   // So is output
   assign do_ram = {do_ram7,do_ram6,do_ram5,do_ram4,do_ram3,do_ram2,do_ram1,do_ram0};

   always @ (*) begin
      // Write and Enable are all inactive by default
      we_ram0 = 0; en_ram0 = 0;
      we_ram1 = 0; en_ram1 = 0;
      we_ram2 = 0; en_ram2 = 0;
      we_ram3 = 0; en_ram3 = 0;
      we_ram4 = 0; en_ram4 = 0;
      we_ram5 = 0; en_ram5 = 0;
      we_ram6 = 0; en_ram6 = 0;
      we_ram7 = 0; en_ram7 = 0;
      data_out = 64'bX;
      // If address is 0x0XXXXXXX, then selet Main Memory
      if (!addr[28]) begin
	 data_out = do_ram;
	 // The following section turns on memory bank as needed
	 // The memory is in low-level interleaving mode so that
	 // we can access 8 bytes in parallel
	 if (be0n = 0) begin
            we_ram0 <= we;
            en_ram0 <= en;
	 end
	 if (be1n = 0) begin
            we_ram1 <= we;
            en_ram1 <= en;
	 end
	 if (be2n = 0) begin
            we_ram2 <= we;
            en_ram2 <= en;
	 end
	 if (be3n = 0) begin
            we_ram3 <= we;
            en_ram3 <= en;
	 end
	 if (be4n = 0) begin
            we_ram4 <= we;
            en_ram4 <= en;
	 end
	 if (be5n = 0) begin
            we_ram5 <= we;
            en_ram5 <= en;
	 end
	 if (be6n = 0) begin
            we_ram6 <= we;
            en_ram6 <= en;
	 end
	 if (be7n = 0) begin
            we_ram7 <= we;
            en_ram7 <= en;
	 end
	 
      end // if (!addr[28])
      else begin
	 // If not main memory. Not implemented in this project
      end // else: !if(!addr[28])
   end // always @ (*)
endmodule
