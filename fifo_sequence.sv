

class fifo_sequence extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_sequence) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_sequence"); 
    super.new(name);
  endfunction
  
virtual task body();
   `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Write REQs ********"), UVM_LOW)
  repeat(5) begin

    req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_wren==1;req.i_rden==0;});
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Read REQs ********"), UVM_LOW)
  repeat(5) begin

     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_wren==0;req.i_rden==1;});
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Idle condition ********"), UVM_LOW)
  repeat(5) begin

     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==0 ; req.i_wren==0;});
    finish_item(req);
    end



  `uvm_info(get_type_name(), $sformatf("******** Simultaneous read and write ********"), UVM_LOW)
  
  repeat(5) begin

    req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==1 ; req.i_wren==1;}); 
    finish_item(req);
    end
  
  
  
     `uvm_info(get_type_name(), $sformatf("******** Generate Alternate read and write ********"), UVM_LOW)
  repeat(5) begin

     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==0 ; req.i_wren==1;}); //write
    finish_item(req);
      req = fifo_transaction::type_id::create("req");
     start_item(req);
    assert(req.randomize()with {req.i_rden==1 ; req.i_wren==0;}); //read
    finish_item(req);
    end
  

//    `uvm_info(get_type_name(), $sformatf("******** Generate Random req's ********"), UVM_LOW)
//     for(int j=0;j<10;j++) begin

//      req = fifo_transaction::type_id::create("req");  //creating sequence_item
//     start_item(req);
//     assert(req.randomize());
//     finish_item(req);
//    end 
endtask
endclass 




 

                                       


                                         
                                                                              
                                       
                                       


                                       
                                       
                                       
                                      
                                      
