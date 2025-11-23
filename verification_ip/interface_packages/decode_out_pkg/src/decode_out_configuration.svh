class decode_out_configuration extends uvm_object;
    `uvm_object_utils(decode_out_configuration)

    virtual decode_out_monitor_bfm monitor_bfm;

     function new( string name = "decode_out_configuration" );
       super.new( name );


     endfunction

    virtual function void  initialize(string mon_bfm);
    if (!uvm_config_db#(virtual decode_out_monitor_bfm)::get(null, "*", mon_bfm, monitor_bfm))
      `uvm_fatal("DECODE_OUT_CFG", "Failed to get monitor_bfm from config DB");
     endfunction 
endclass