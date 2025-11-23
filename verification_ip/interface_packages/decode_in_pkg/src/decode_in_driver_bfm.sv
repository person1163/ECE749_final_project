interface decode_in_driver_bfm 
  ( decode_in_if  bus );


  task drive(input bit [15:0] data,input bit [15:0]npc);
    @(posedge bus.clock);
    bus.enable_decode=1'b1;
    bus.Imem_dout=data;
    bus.npc_in=npc;
    @(posedge bus.clock);
     bus.enable_decode=1'b0;
  endtask         

endinterface