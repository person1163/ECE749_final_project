  class decode_in_sequence extends uvm_sequence#(.REQ(decode_in_transaction), .RSP(decode_in_transaction));
     `uvm_object_utils(decode_in_sequence)
      decode_in_transaction req;
      decode_in_transaction rsp;
      decode_in_configuration configuration;

      function new(string name=""); 
        super.new(name);
      endfunction



      virtual task body();
      repeat(50)
       begin
      req = new("req");
     // `uvm_info("SEQUENCE", "Requesting to send transaction to driver",UVM_MEDIUM)
      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "my_sequence::body()- randomization failed")
      //`uvm_info("SEQUENCE", {"Sending:",req.convert2string()},UVM_MEDIUM)
      finish_item(req);
      get_response(rsp);
      //`uvm_info("SEQUENCE", {"Received:",rsp.convert2string()},UVM_MEDIUM)
       end
   
      endtask

     

     

  endclass  