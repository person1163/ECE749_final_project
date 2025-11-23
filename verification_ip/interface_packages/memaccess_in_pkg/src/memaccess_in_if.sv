//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the memaccess_in interface signals.
//      It is instantiated once per memaccess_in bus.  Bus Functional Models, 
//      BFM's named memaccess_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named memaccess_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(memaccess_in_bus.MControl), // Agent output 
// .dut_signal_port(memaccess_in_bus.MAddr), // Agent output 
// .dut_signal_port(memaccess_in_bus.MData), // Agent output 
// .dut_signal_port(memaccess_in_bus.DMem_out), // Agent input 
// .dut_signal_port(memaccess_in_bus.completedata), // Agent output 

import uvmf_base_pkg_hdl::*;
import memaccess_in_pkg_hdl::*;

interface  memaccess_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  MControl,
  inout tri [15:0] MAddr,
  inout tri [15:0] MData,
  inout tri [15:0] DMem_out,
  inout tri  completedata
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input MControl,
  input MAddr,
  input MData,
  input DMem_out,
  input completedata
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output MControl,
  output MAddr,
  output MData,
  input DMem_out,
  output completedata
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input MControl,
  input MAddr,
  input MData,
  output DMem_out,
  input completedata
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

