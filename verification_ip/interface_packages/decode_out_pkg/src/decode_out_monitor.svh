class decode_out_monitor  extends uvm_monitor;  
     `uvm_component_utils( decode_out_monitor )
   
     int transaction_viewing_stream_h;
     uvm_analysis_port #(decode_out_transaction) ap;
     decode_out_configuration configuration;
     decode_out_transaction transaction;
   virtual decode_out_monitor_bfm monitor_bfm;
     function new( string name = "", uvm_component parent = null );
       super.new( name, parent );
     endfunction

    function void set_configuration(decode_out_configuration cfg);
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
      @(posedge configuration.monitor_bfm.bus.clock);
       forever begin 
         transaction = new("transaction");
         configuration.monitor_bfm.monitor(transaction.ir,transaction.npc_out,transaction.E_control,transaction.W_control,transaction.mem_control, transaction.start_time, transaction.end_time);
         transaction.wave_view(transaction_viewing_stream_h);
         ap.write(transaction);
       end
     endtask 
endclass