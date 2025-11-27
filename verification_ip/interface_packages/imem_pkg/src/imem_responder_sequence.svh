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
class imem_responder_sequence 
  extends imem_sequence_base ;

  `uvm_object_utils( imem_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  bit flag;
  function new(string name = "imem_responder_sequence");
    super.new(name);
    flag =0;
  endfunction

task body();
    bit responder_count = 0;
    bit max_responder_transactions = 400;  // Configurable limit
    
    //initialize all registers
    for (int i = 0; i < 8; i++) 
    begin
      start_item(req);
      if (!req.randomize()) 
        `uvm_fatal("SEQ", "imem_random_sequence::body()-imem_transaction randomization failed");
      
      req.Instr_dout[15:12] = LEA;
      req.dr = i;
      req.Instr_dout = {req.Instr_dout[15:12], req.dr, req.pcoffset9};
      req.complete_instr = 1;
      finish_item(req);
    end
    
    // CHANGE: Use repeat instead of forever
    repeat(max_responder_transactions) begin
      start_item(req);
      if(flag == 1'b0) 
        begin
          if((!req.randomize() with {req.Instr_dout[15:12] inside {ADD, AND, NOT, BR, JMP, LD, LDI, LDR, LEA, ST, STI, STR};}))`uvm_fatal("SEQ", "imem_random_sequence::body()-imem_transaction randomization failed")
          req.complete_instr=1;
        end 
      else 
        begin
          req.complete_instr = 0;
          req.Instr_dout = 0;
        end
      finish_item(req);
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_MEDIUM)
      responder_count++;
    end
    
    `uvm_info("SEQ", $sformatf("Responder sequence completed after %0d transactions", responder_count), UVM_LOW)
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

