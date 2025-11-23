interface decode_out_if

    (
    input logic clock,
    input logic reset
    );
     logic [15:0] ir;
     logic [15:0] npc_out;
     logic enable_decode;
     logic [5:0] E_control;
     logic [1:0] W_control;
     logic mem_control;  


      modport monitor_port
  (
  input clock, 
  input reset,
  input  ir,
  input npc_out,
  input enable_decode,
  input  E_control,
  input  W_control,
  input  mem_control
  );

    
    
endinterface //decode_out_if