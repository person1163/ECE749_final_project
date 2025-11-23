class decode_out_agent extends uvm_agent;
  `uvm_component_utils(decode_out_agent)
  decode_out_configuration configuration;
  uvm_analysis_port #(decode_out_transaction) ap;
  decode_out_monitor monitor;

  function new(string name="decode_out_agent", uvm_component parent=null);
    super.new(name,parent);
    ap = new("ap", this);
  endfunction

 function void set_configuration(decode_out_configuration cfg);
    configuration = cfg;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  if (!uvm_config_db#(decode_out_configuration)::get(this, "", "configuration", configuration))
      `uvm_fatal("NO_CFG", "decode_in_configuration not found in config DB!")
    monitor  = decode_out_monitor::type_id::create("monitor", this);
    monitor.set_configuration(configuration);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
     monitor.ap.connect(this.ap);
  endfunction
endclass