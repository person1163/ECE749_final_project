
module hdl_top();
import uvm_pkg::*;
import decode_in_pkg::*;
import decode_out_pkg::*;
import decode_test_pkg::*;
  logic clock;
  logic reset;
  logic enable_decode;
  logic enable_decode_pipe;
  logic[15:0] npc_in;
  logic [15:0] Imem_dout;
  logic transaction_viewing = 1'b1;
  logic [5:0] E_control;
  logic  mem_control;
  logic [1:0] W_control;
  logic [15:0]npc_out;
  logic [15:0] ir;


  decode_in_if decode_in_bus(.clock(clock), .reset(reset));
  decode_in_monitor_bfm monitor_in_bfm(decode_in_bus.monitor_port);
  decode_in_driver_bfm driver_in_bfm(decode_in_bus.driver_port);
  decode_out_if decode_out_bus(.clock(clock), .reset(reset));
  decode_out_monitor_bfm monitor_out_bfm(decode_out_bus.monitor_port);

  assign decode_out_bus.enable_decode=decode_in_bus.enable_decode;
  
 Decode dut(.clock(decode_in_bus.clock),.reset(decode_in_bus.reset),.enable_decode(decode_in_bus.enable_decode),.dout(decode_in_bus.Imem_dout),.E_Control(decode_out_bus.E_control),.npc_in(decode_in_bus.npc_in),
             .Mem_Control(decode_out_bus.mem_control),.W_Control(decode_out_bus.W_control),.IR(decode_out_bus.ir),.npc_out(decode_out_bus.npc_out));
  initial 
  begin
  clock=1'b0;
 forever begin:clk_gen
   #5 clock=~clock;
 end
  end

  initial begin: gen_rst
    reset = 1'b1;
    #50;
    reset = 1'b0;
  end


  initial begin : initialize_bench
    uvm_config_db#(virtual decode_in_monitor_bfm)::set(null, "*", "monitor_in_bfm", monitor_in_bfm);
    uvm_config_db#(virtual decode_in_driver_bfm)::set(null, "*", "driver_in_bfm", driver_in_bfm);
    uvm_config_db#(virtual decode_out_monitor_bfm)::set(null, "*", "monitor_out_bfm", monitor_out_bfm);
  end



endmodule