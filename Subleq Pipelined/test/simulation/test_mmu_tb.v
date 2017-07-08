module test_mmu_tb();
   reg clk, resetb;
   reg we, en, be7n, be6n, be5n, be4n,be3n, be2n, be1n, be0n;
   reg [63:0] data_in;
   wire [63:0] data_out;
      
   initial begin
      clk = 0;
      resetb = 1;
      en = 0;
      we = 0;
      be0n = 1;      
      be1n = 1;      
      be2n = 1;      
      be3n = 1;      
      be4n = 1;      
      be5n = 1;      
      be6n = 1;      
      be7n = 1;      
   end

   // Clock Generation
   always #5 clk = !clk;

   task reset;
      begin
      @(posedge clk);
      resetb = 0;
	 en = 0;
	 we = 0;
	 
	 be0n = 1;      
	 be1n = 1;      
	 be2n = 1;      
	 be3n = 1;      
	 be4n = 1;      
	 be5n = 1;      
	 be6n = 1;      
	 be7n = 1;      
	 @(posedge clk);
	 resetb = 1;
	 @(posedge clk);
      end
   endtask
   // Test Tasks
   task test1;
      begin
	 reset();
	 be0n = 0;      
	 be1n = 0;      
	 be2n = 0;      
	 be3n = 0;      
	 be4n = 0;      
	 be5n = 0;      
	 be6n = 0;      
	 be7n = 0;
	 for (i=0; i<16; i=i+1) begin
	    $display("Test 1 Iter %d:\n", i);
	    $display("  Prev Addr = %H\n", addr);
	    $display("  Prev Data = %H\n", data_in);
	    addr = i * 8;
	    $display("  Addr in = %H\n", addr);
	    data_in = 64'hDEADBEEFBAADC0DE;
	    en = 1; we = 1;
	    @(posedge clk);
	 end
      end
   endtask //

   initial begin : stimulus
      test1();
   end
   
endmodule // test_mmu_tb
