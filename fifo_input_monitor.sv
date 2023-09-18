class fifo_input_monitor extends uvm_monitor; 
  virtual fifo_intf vif;
  fifo_transaction req1;
  uvm_analysis_port#(fifo_transaction) ap1;
  `uvm_component_utils(fifo_input_monitor)
  
  function new(string name = "fifo_input_monitor", uvm_component parent);
    super.new(name, parent);
     ap1 = new("analysis_port", this);
  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     req1 = fifo_transaction::type_id::create("req1");
      if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

   virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.in_m_mp.clk)
      if(vif.in_m_mp.input_mcb.i_wren == 1 && vif.in_m_mp.input_mcb.i_rden == 0)begin
        $display("\nInput Monitor:Write enable is high and Read enable is low");
        req1.i_wrdata = vif.in_m_mp.input_mcb.i_wrdata;
        req1.i_wren = vif.in_m_mp.input_mcb.i_wren;
        req1.i_rden = vif.in_m_mp.input_mcb.i_rden;
        req1.o_rddata = vif.in_m_mp.input_mcb.o_rddata; 
        req1.o_full = vif.in_m_mp.input_mcb.o_full;
        req1.o_alm_full = vif.in_m_mp.input_mcb.o_alm_full;
        req1.o_empty = vif.in_m_mp.input_mcb.o_empty;
        req1.o_alm_empty = vif.in_m_mp.input_mcb.o_alm_empty;
        
        ap1.write(req1);
      end   
     else if(vif.in_m_mp.input_mcb.i_wren == 0 && vif.in_m_mp.input_mcb.i_rden == 1)begin
    
        $display("\n Input Monitor: Write enable is low and Read enable is high");
        req1.i_wrdata = vif.in_m_mp.input_mcb.i_wrdata;
        req1.i_wren = vif.in_m_mp.input_mcb.i_wren;
        req1.i_rden = vif.in_m_mp.input_mcb.i_rden;
         req1.o_rddata = vif.in_m_mp.input_mcb.o_rddata; 
        req1.o_full = vif.in_m_mp.input_mcb.o_full;
        req1.o_alm_full = vif.in_m_mp.input_mcb.o_alm_full;
        req1.o_empty = vif.in_m_mp.input_mcb.o_empty;
        req1.o_alm_empty = vif.in_m_mp.input_mcb.o_alm_empty;
        ap1.write(req1);
      end 
     else if(vif.in_m_mp.input_mcb.i_wren == 1 && vif.in_m_mp.input_mcb.i_rden == 1)begin
       
        $display("\n Input Monitor :Write and Read enable is high");
        req1.i_wrdata = vif.in_m_mp.input_mcb.i_wrdata;
        req1.i_wren = vif.in_m_mp.input_mcb.i_wren;
        req1.i_rden = vif.in_m_mp.input_mcb.i_rden;
         req1.o_rddata = vif.in_m_mp.input_mcb.o_rddata; 

        req1.o_full = vif.in_m_mp.input_mcb.o_full;
        req1.o_alm_full = vif.in_m_mp.input_mcb.o_alm_full;
        req1.o_empty = vif.in_m_mp.input_mcb.o_empty;
        req1.o_alm_empty = vif.in_m_mp.input_mcb.o_alm_empty;
        ap1.write(req1);
       end 
    else  if(vif.in_m_mp.input_mcb.i_wren == 0 && vif.in_m_mp.input_mcb.i_rden == 0)begin
      
        $display("\n Input Monitor: No write and read operation");
        req1.i_wrdata = vif.in_m_mp.input_mcb.i_wrdata;
        req1.i_wren = vif.in_m_mp.input_mcb.i_wren;
        req1.i_rden = vif.in_m_mp.input_mcb.i_rden;
         req1.o_rddata = vif.in_m_mp.input_mcb.o_rddata; 
        req1.o_full = vif.in_m_mp.input_mcb.o_full;
        req1.o_alm_full = vif.in_m_mp.input_mcb.o_alm_full;
        req1.o_empty = vif.in_m_mp.input_mcb.o_empty;
        req1.o_alm_empty = vif.in_m_mp.input_mcb.o_alm_empty;
       ap1.write(req1);
     end    
    end
     endtask : run_phase
     endclass : fifo_input_monitor
