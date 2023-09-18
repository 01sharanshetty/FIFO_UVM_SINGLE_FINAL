 parameter DATA_W   = 128;    // Data width
 parameter DEPTH    = 5;    // Depth of FIFO
  parameter UPP_TH   = 4;       // Upper threshold to generate Almost-full
  parameter LOW_TH   = 2 ;       // Lower threshold to generate Almost-empty
class fifo_transaction extends uvm_sequence_item;
rand bit i_wren;
rand bit i_rden;
rand bit [DATA_W - 1 : 0] i_wrdata;
bit  [DATA_W - 1 : 0] o_rddata;
bit o_full;
bit o_empty;
bit o_alm_full;
bit o_alm_empty;
  `uvm_object_utils_begin(fifo_transaction)
  `uvm_field_int(i_wrdata,UVM_ALL_ON)   
  `uvm_field_int(i_wren,UVM_ALL_ON)   
  `uvm_field_int(i_rden,UVM_ALL_ON)
  `uvm_field_int(o_rddata,UVM_ALL_ON) 
  `uvm_field_int(o_full,UVM_ALL_ON)   
  `uvm_field_int(o_empty,UVM_ALL_ON)   
  `uvm_field_int(o_alm_full,UVM_ALL_ON)   
  `uvm_field_int(o_alm_empty,UVM_ALL_ON)   
  `uvm_object_utils_end    
  function new(input string name="fifo_transaction");   
       super.new(name);   
     endfunction   
endclass : fifo_transaction   
  
  
