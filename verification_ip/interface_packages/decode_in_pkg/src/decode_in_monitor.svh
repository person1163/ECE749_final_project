class decode_in_monitor  extends uvm_monitor;  
     `uvm_component_utils( decode_in_monitor )
   
     int transaction_viewing_stream_h;
     uvm_analysis_port #(decode_in_transaction) ap;
     decode_in_configuration configuration;
     decode_in_transaction transaction;
   virtual decode_in_monitor_bfm monitor_bfm;
     function new( string name = "", uvm_component parent = null );
       super.new( name, parent );
     endfunction

    function void set_configuration(decode_in_configuration cfg);
    configuration = cfg;
  endfunction
  
     virtual function void build_phase(uvm_phase phase);                                                   
       super.build_phase(phase);
       ap = new("ap", this);
     endfunction                                                                                    
   
     virtual function void start_of_simulation_phase(uvm_phase phase);
       super.start_of_simulation_phase(phase);
       transaction_viewing_stream_h = $create_transaction_stream({"..",get_full_name(),".","txn_stream"},"TVM");
     endfunction
   
     virtual task run_phase(uvm_phase phase);    
     #50;                                               
       forever begin 
         transaction = new("transaction");
         configuration.monitor_bfm.monitor(transaction.Imem_dout,transaction.npc_in, transaction.start_time, transaction.end_time);
         //`uvm_info("Monitor", {"Received:",transaction.convert2string()},UVM_MEDIUM)
         transaction.opcode=transaction.Imem_dout[15:12];
         transaction.wave_view(transaction_viewing_stream_h);
         ap.write(transaction);
       end
     endtask 
endclass