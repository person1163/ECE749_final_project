interface decode_out_monitor_bfm 
  ( decode_out_if  bus );


  task monitor(output bit [15:0] ir,output bit[15:0]npc_out,output bit[5:0]E_control,output bit[1:0]W_control,output bit mem_control, output time start_time, output time end_time);
    @(posedge bus.clock)
    #1ns;
    start_time = $time;
    ir = bus.ir;
    npc_out=bus.npc_out;
    E_control=bus.E_control;
    W_control=bus.W_control;
    mem_control=bus.mem_control;
    @(posedge bus.clock)
    end_time = $time;
    
  endtask         
  
endinterface