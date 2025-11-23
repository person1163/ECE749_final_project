import uvm_pkg::*;
import decode_env_pkg::*;
import decode_in_pkg::*;
import decode_out_pkg::*;
import lc3_prediction_pkg::*;

`include "uvm_macros.svh"
  class test_top extends uvm_test;

    `uvm_component_utils( test_top )

    decode_env_configuration configuration;
    decode_environment environment;
    uvm_sequencer #(decode_in_transaction) sequencer;
    decode_in_sequence                     sequenc;
    string d_in= "driver_in_bfm";
    string m_in="monitor_in_bfm";
    string m_out="monitor_out_bfm";
    function new(string name="", uvm_component parent = null); 
      super.new(name,parent);
    endfunction
    
      function void set_configuration(decode_env_configuration cfg);
    configuration = cfg;
  endfunction

    virtual function void build_phase(uvm_phase phase);
      environment=decode_environment::type_id::create("environment",this);
      configuration=new("decode_env_configuration");
      configuration.initialize(d_in,m_in,m_out);
      uvm_config_db#(decode_env_configuration)::set(this, "environment", "configuration", configuration);
      sequencer = new("sequencer",this);
      sequenc = new("sequenc");
    endfunction 
 

    virtual task  run_phase(uvm_phase phase);
    
      phase.raise_objection(this, "Objection raised by test_base");
      #50;
      sequenc.start(environment.agent_in.sequencer);
      phase.drop_objection(this, "Objection dropped by test_base");
    endtask

  endclass 