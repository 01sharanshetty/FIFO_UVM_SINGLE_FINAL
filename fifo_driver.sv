
class fifo_driver extends uvm_driver #(fifo_transaction);
 virtual fifo_intf vif; //interface handle
  fifo_transaction req; //sequence_item handle
 
 `uvm_component_utils(fifo_driver)
 
 function new(string name = "fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

 // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", vif))
      `uvm_fatal("Driver: ", "No vif is found!")
  endfunction

// Run phase  
   virtual task run_phase(uvm_phase phase);
    if(vif.d_mp.rstn==0)
      begin//check for reset
        $display("RESET CONDITION");
    vif.d_mp.dcb.i_wren <= 0;
    vif.d_mp.dcb.i_rden <= 0;
    vif.d_mp.dcb.i_wrdata <= 0;
   
      end
    forever begin
      seq_item_port.get_next_item(req);
      
      
//       if(req.i_wren == 1) begin
//          @(posedge vif.d_mp.clk)
//     vif.d_mp.dcb.i_wren <= req.i_wren;
//     vif.d_mp.dcb.i_wrdata <= req.i_wrdata;
//         @(negedge vif.d_mp.clk)
//     vif.d_mp.dcb.i_wren <= 0;
//       end
//       else if(req.i_rden == 1) begin
//          @(posedge vif.d_mp.clk)
//     vif.d_mp.dcb.i_rden <= req.i_rden;
//         @(negedge vif.d_mp.clk)
//      vif.d_mp.dcb.i_rden <=0;
//       end
       
      
      if(req.i_wren == 1 && req.i_rden == 0) begin
          @(posedge vif.d_mp.clk)
    		vif.d_mp.dcb.i_wren <= req.i_wren;
            vif.d_mp.dcb.i_rden <= req.i_rden;
   			vif.d_mp.dcb.i_wrdata <= req.i_wrdata;
    	 @(negedge vif.d_mp.clk)
            vif.d_mp.dcb.i_wren <= 0;
            vif.d_mp.dcb.i_rden <=0; end
      
      else if(req.i_wren == 0 && req.i_rden == 1) begin
        @(posedge vif.d_mp.clk)
    		vif.d_mp.dcb.i_wren <= req.i_wren;
            vif.d_mp.dcb.i_rden <= req.i_rden;
        @(negedge vif.d_mp.clk)
            vif.d_mp.dcb.i_wren <= 0;
            vif.d_mp.dcb.i_rden <=0; end
      
     else if(req.i_rden == 1 && req.i_wren == 1) begin
       @(posedge vif.d_mp.clk)
    		vif.d_mp.dcb.i_wren <= req.i_wren;
            vif.d_mp.dcb.i_rden <= req.i_rden;
    		vif.d_mp.dcb.i_wrdata <= req.i_wrdata;
       @(negedge vif.d_mp.clk)
            vif.d_mp.dcb.i_wren <= 0;
            vif.d_mp.dcb.i_rden <=0; 
     end
      
     else if(req.i_rden == 0 && req.i_wren == 0) begin
           @(posedge vif.d_mp.clk)
    		vif.d_mp.dcb.i_wren <= req.i_wren;
            vif.d_mp.dcb.i_rden <= req.i_rden; end
      seq_item_port.item_done();
    end
    endtask

   
endclass : fifo_driver
