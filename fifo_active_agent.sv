`include "fifo_transaction.sv"
`include "fifo_driver.sv"
`include "fifo_sequencer.sv"
`include "fifo_input_monitor.sv"
`include "fifo_sequence.sv"

class fifo_active_agent extends uvm_agent;
  fifo_sequencer seqr;
  fifo_driver driv;
  fifo_input_monitor in_mon;
  `uvm_component_utils(fifo_active_agent)
  
  function new(string name = "fifo_active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      seqr = fifo_sequencer::type_id::create("seqr", this);
      driv = fifo_driver::type_id::create("driv", this);
    end
      in_mon = fifo_input_monitor::type_id::create("in_mon", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      driv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
    
endclass : fifo_active_agent
