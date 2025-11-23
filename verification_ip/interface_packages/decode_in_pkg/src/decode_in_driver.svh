  class decode_in_driver extends uvm_driver #(.REQ(decode_in_transaction), .RSP(decode_in_transaction));
    `uvm_component_utils(decode_in_driver)
      decode_in_transaction req;
      decode_in_transaction rsp;
      decode_in_configuration configuration;

      function new(string name="decode_in_driver", uvm_component parent = null); 
        super.new(name,parent);
      endfunction

 function void set_configuration(decode_in_configuration cfg);
    configuration = cfg;
  endfunction

     virtual task run_phase(uvm_phase phase);
     forever
        begin : forever_loop
        //  `uvm_info("DRIVER", "Requesting a transaction from the sequencer",UVM_MEDIUM);
          req = decode_in_transaction::type_id::create("req",this);
          seq_item_port.get_next_item(req);
         // `uvm_info("DRIVER", {"Received:",req.convert2string()},UVM_MEDIUM)
          rsp = decode_in_transaction::type_id::create("rsp", this);
          rsp.set_id_info(req);
          configuration.driver_bfm.drive(req.Imem_dout,req.npc_in);
	        //#1ns; // Consume some time to model protocol signaling
          //`uvm_info("DRIVER", "Sending transaction back to sequence through sequencer",UVM_MEDIUM)
          seq_item_port.item_done(rsp);
        end 
    endtask
  endclass