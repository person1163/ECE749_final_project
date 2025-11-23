//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_responder_ctrl_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_responder_ctrl_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_responder_ctrl_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    //initialize all registers
    for (int i = 0; i < 8; i++) 
    begin
      start_item(req);
      if (!req.randomize()) 
        `uvm_fatal("SEQ", "imem_random_sequence::body()-imem_transaction randomization failed");
      
      req.Instr_dout[15:12] = LDR;
      req.dr = i;
      req.Instr_dout = {req.Instr_dout[15:12], req.dr, req.pcoffset9};
      req.complete_instr = 1;
      finish_item(req);
    end
    
    forever begin
      start_item(req);
          if(flag == 1'b0) 
            begin
              if((!req.randomize() with {req.Instr_dout[15:12] inside {BR,JMP};}))`uvm_fatal("SEQ", "imem_random_sequence::body()-imem_transaction randomization failed")
              req.complete_instr = 1;
            end 
          else 
            begin
              req.complete_instr= 0;
              req.Instr_dout = 0;
            end
	  
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
    end
  endtask

endclass
