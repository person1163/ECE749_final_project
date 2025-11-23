class decode_in_agent extends uvm_agent;
  `uvm_component_utils(decode_in_agent)
  decode_in_configuration configuration;
  decode_in_coverage coverage;
  uvm_sequencer #(decode_in_transaction) sequencer;
  uvm_analysis_port #(decode_in_transaction) ap;
  decode_in_driver driver;
  decode_in_monitor monitor;

  function new(string name="decode_in_agent", uvm_component parent=null);
    super.new(name,parent);
    ap = new("ap", this);
  endfunction

 function void set_configuration(decode_in_configuration cfg);
    configuration = cfg;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(decode_in_configuration)::get(this, "", "configuration", configuration))
      `uvm_fatal("NO_CFG", "decode_in_configuration not found in config DB!")
    coverage = decode_in_coverage::type_id::create("coverage", this);
    coverage.set_configuration(configuration);
    driver   = decode_in_driver::type_id::create("driver", this);
    driver.set_configuration(configuration);
    monitor  = decode_in_monitor::type_id::create("monitor", this);
    monitor.set_configuration(configuration);
    sequencer = new("decode_in_sequencer", this);


  endfunction

  virtual function void connect_phase(uvm_phase phase);
     monitor.ap.connect(coverage.analysis_export);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    monitor.ap.connect(this.ap);
  endfunction
endclass
