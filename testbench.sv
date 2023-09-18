import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo_interface.sv"
`include "fifo_test.sv"



module tb;
  bit clk;
  bit rstn;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 1;
    rstn = 0;
    #5;
    rstn = 1;
  end
  
  fifo_intf intf(clk, rstn);
  
  SYN_FIFO dut(.clk(intf.clk),
               .rst(intf.rstn),
               .data_in(intf.i_wrdata),
               .write_en(intf.i_wren),
               .read_en(intf.i_rden),
               .full(intf.o_full),
               .empty(intf.o_empty),
               .data_out(intf.o_rddata),
               .almost_full(intf.o_alm_full), .almost_empty(intf.o_alm_empty));
  
  initial begin
    uvm_config_db#(virtual fifo_intf)::set(null, "", "vif",intf);
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("fifo_test");
  end
  
endmodule
