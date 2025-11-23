interface decode_in_if

    (
    input logic clock,
    input logic reset
    );
     logic [15:0] npc_in;
     logic enable_decode;
     logic [15:0] Imem_dout;  


      modport monitor_port
  (
  input clock, 
  input reset,
  input enable_decode,
  input Imem_dout,
  input npc_in
  );
         modport driver_port
  (
  input clock, 
  input reset,
  output enable_decode,
  output Imem_dout,
  output npc_in
  );

    
    
endinterface //decode_in_if
