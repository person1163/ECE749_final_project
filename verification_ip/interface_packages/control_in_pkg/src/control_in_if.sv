//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the control_in interface signals.
//      It is instantiated once per control_in bus.  Bus Functional Models, 
//      BFM's named control_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named control_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(control_in_bus.completed_data), // Agent input 
// .dut_signal_port(control_in_bus.completed_instr), // Agent input 
// .dut_signal_port(control_in_bus.IR), // Agent input 
// .dut_signal_port(control_in_bus.NZP), // Agent input 
// .dut_signal_port(control_in_bus.PSR), // Agent input 
// .dut_signal_port(control_in_bus.IR_EXEC), // Agent input 
// .dut_signal_port(control_in_bus.Imem_dout), // Agent input 

import uvmf_base_pkg_hdl::*;
import control_in_pkg_hdl::*;

interface  control_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  completed_data,
  inout tri  completed_instr,
  inout tri [15:0] IR,
  inout tri [2:0] NZP,
  inout tri [2:0] PSR,
  inout tri [15:0] IR_EXEC,
  inout tri [15:0] Imem_dout
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input completed_data,
  input completed_instr,
  input IR,
  input NZP,
  input PSR,
  input IR_EXEC,
  input Imem_dout
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input completed_data,
  input completed_instr,
  input IR,
  input NZP,
  input PSR,
  input IR_EXEC,
  input Imem_dout
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output completed_data,
  output completed_instr,
  output IR,
  output NZP,
  output PSR,
  output IR_EXEC,
  output Imem_dout
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

