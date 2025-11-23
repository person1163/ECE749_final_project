  import uvm_pkg::*;
  import decode_in_pkg::*;

  class decode_env_configuration extends uvm_object;
    `uvm_object_utils(decode_env_configuration)
    decode_in_configuration agent_in_configuration;
    decode_out_configuration agent_out_configuration;

  function new(string name="decode_env_configuration");
    super.new(name);
		agent_in_configuration = decode_in_configuration::type_id::create("decode_in_configuration"); 
		agent_out_configuration = decode_out_configuration::type_id::create("decode_out_configuration"); 
  endfunction
  
  virtual function void initialize(string agnt_in_drv,string agnt_in_mon, string agnt_out_mon );
     agent_in_configuration.initialize(agnt_in_drv,agnt_in_mon);
    agent_out_configuration.initialize(agnt_out_mon);

endfunction

  endclass