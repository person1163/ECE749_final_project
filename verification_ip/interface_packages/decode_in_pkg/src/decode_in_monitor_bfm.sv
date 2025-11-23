interface decode_in_monitor_bfm 
  ( decode_in_if  bus );


  task monitor(output bit [15:0] data,output bit[15:0]npc, output time start_time, output time end_time);
    @(posedge bus.clock);
    start_time = $time;
    data = bus.Imem_dout;
    npc=bus.npc_in;
    @(posedge bus.clock)
    end_time = $time;

  endtask         
  
endinterface