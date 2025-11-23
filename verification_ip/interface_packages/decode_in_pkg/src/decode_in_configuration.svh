class decode_in_configuration extends uvm_object;
    `uvm_object_utils(decode_in_configuration)

    virtual decode_in_driver_bfm driver_bfm;
    virtual decode_in_monitor_bfm monitor_bfm;

     function new( string name = "" );
       super.new( name );

     endfunction


     virtual function void  initialize(string drv_bfm, string mon_bfm);


    if (!uvm_config_db#(virtual decode_in_driver_bfm)::get(null, "*", drv_bfm, driver_bfm))
      `uvm_fatal("DECODE_IN_CFG", "Failed to get driver_bfm from config DB");

    if (!uvm_config_db#(virtual decode_in_monitor_bfm)::get(null, "*", mon_bfm, monitor_bfm))
      `uvm_fatal("DECODE_IN_CFG", "Failed to get monitor_bfm from config DB");

     endfunction 
endclass