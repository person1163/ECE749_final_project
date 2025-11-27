//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1; 
    #50ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  fetch_in_if  fetch_fetch_in_agent_bus(
     // pragma uvmf custom fetch_fetch_in_agent_bus_connections begin
     .clk(clk), .reset(rst),
       .br_taken(dut_verilog.br_taken),
      .enable_fetch (dut_verilog.enable_fetch),
      .enable_updatePC(dut_verilog.enable_updatePC),
       .taddr(dut_verilog.taddr)
     // pragma uvmf custom fetch_fetch_in_agent_bus_connections end
     );
  fetch_out_if  fetch_fetch_out_agent_bus(
     // pragma uvmf custom fetch_fetch_out_agent_bus_connections begin
     .clk(clk), .rst(rst),
       .instrmem_rd (dut_verilog.instrmem_rd),
       .pc(dut_verilog.pc),
      .npc ( dut_verilog.npc_out_fetch)
     // pragma uvmf custom fetch_fetch_out_agent_bus_connections end
     );
  memaccess_in_if  memaccess_memaccess_in_agent_bus(
     // pragma uvmf custom memaccess_memaccess_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
    .MControl ( dut_verilog.M_Control),
    .MAddr(dut_verilog.pcout),
    .MData(dut_verilog.M_Data),
    .DMem_out (dut_verilog.Data_dout),
    .mem_state ( dut_verilog.mem_state)
     // pragma uvmf custom memaccess_memaccess_in_agent_bus_connections end
     );
  memaccess_out_if  memaccess_memaccess_out_agent_bus(
     // pragma uvmf custom memaccess_memaccess_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     
   .DMem_addr(dut_verilog.Data_addr),
  .DMem_din ( dut_verilog.Data_din),
  .memout(dut_verilog.memout),
  .DMem_rd(dut_verilog.Data_rd)
     // pragma uvmf custom memaccess_memaccess_out_agent_bus_connections end
     );
  control_in_if  control_control_in_agent_bus(
     // pragma uvmf custom control_control_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .completed_data (dut_verilog.complete_data),
     .completed_instr  (dut_verilog.complete_instr),
    .IR  (dut_verilog.IR),
    .IR_EXEC  (dut_verilog.IR_Exec),
    .PSR (dut_verilog.psr),
    .NZP (dut_verilog.NZP),
    .Imem_dout (dut_verilog.Instr_dout)
     // pragma uvmf custom control_control_in_agent_bus_connections end
     );
  control_out_if  control_control_out_agent_bus(
     // pragma uvmf custom control_control_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     
  .enable_updatePC (dut_verilog.enable_updatePC),
  .bypass_alu_1 (dut_verilog.bypass_alu_1),
  .bypass_alu_2 (dut_verilog.bypass_alu_2),
  .bypass_mem_1 (dut_verilog.bypass_mem_1),
  .bypass_mem_2 (dut_verilog.bypass_mem_2),
  .enable_fetch (dut_verilog.enable_fetch),
  .enable_decode (dut_verilog.enable_decode),
  .enable_execute (dut_verilog.enable_execute),
  .enable_writeback (dut_verilog.enable_writeback),
  .mem_state (dut_verilog.mem_state),
  .br_taken  (dut_verilog.br_taken)
     // pragma uvmf custom control_control_out_agent_bus_connections end
     );
  imem_if  imem_agent_bus(
     // pragma uvmf custom imem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom imem_agent_bus_connections end
     );
  dmem_if  dmem_agent_bus(
     // pragma uvmf custom dmem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom dmem_agent_bus_connections end
     );
  fetch_in_monitor_bfm  fetch_fetch_in_agent_mon_bfm(fetch_fetch_in_agent_bus);
  fetch_out_monitor_bfm  fetch_fetch_out_agent_mon_bfm(fetch_fetch_out_agent_bus);
  memaccess_in_monitor_bfm  memaccess_memaccess_in_agent_mon_bfm(memaccess_memaccess_in_agent_bus);
  memaccess_out_monitor_bfm  memaccess_memaccess_out_agent_mon_bfm(memaccess_memaccess_out_agent_bus);
  control_in_monitor_bfm  control_control_in_agent_mon_bfm(control_control_in_agent_bus);
  control_out_monitor_bfm  control_control_out_agent_mon_bfm(control_control_out_agent_bus);
  imem_monitor_bfm  imem_agent_mon_bfm(imem_agent_bus);
  dmem_monitor_bfm  dmem_agent_mon_bfm(dmem_agent_bus);
  imem_driver_bfm  imem_agent_drv_bfm(imem_agent_bus);
  dmem_driver_bfm  dmem_agent_drv_bfm(dmem_agent_bus);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
 // pragma uvmf custom dut_instantiation begin
LC3 dut_verilog (
    .clock            (clk),
    .reset            (rst),

    //IMEM

    .pc              (imem_agent_bus.PC),
    .instrmem_rd     (imem_agent_bus.instrmem_rd),
    .Instr_dout      (imem_agent_bus.Instr_dout),
    .complete_instr  (imem_agent_bus.complete_instr),

    // DMEM
    .Data_dout       (dmem_agent_bus.Data_dout),
    .Data_addr       (dmem_agent_bus.Data_addr),
    .Data_din        (dmem_agent_bus.Data_din),
    .Data_rd         (dmem_agent_bus.Data_rd),
    .complete_data   (dmem_agent_bus.complete_data)
);
// pragma uvmf custom dut_instantiation end



  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_fetch_in_agent_BFM , fetch_fetch_in_agent_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_fetch_out_agent_BFM , fetch_fetch_out_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_memaccess_in_agent_BFM , memaccess_memaccess_in_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_memaccess_out_agent_BFM , memaccess_memaccess_out_agent_mon_bfm ); 
    uvm_config_db #( virtual control_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_control_in_agent_BFM , control_control_in_agent_mon_bfm ); 
    uvm_config_db #( virtual control_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_control_out_agent_BFM , control_control_out_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_mon_bfm ); 
    uvm_config_db #( virtual dmem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_drv_bfm  );
    uvm_config_db #( virtual dmem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end
