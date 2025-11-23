class decode_environment extends uvm_env;

	`uvm_component_utils(decode_environment)
	
	decode_in_agent agent_in;
	decode_out_agent agent_out;
	decode_scoreboard scoreboard;
	decode_predictor predictor;
 	decode_env_configuration configuration;

	
	function new (string name = "decode_environment", uvm_component parent=null);
		super.new(name,parent);
	endfunction
		
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	if (!uvm_config_db#(decode_env_configuration)::get(this, "", "configuration", configuration))
      `uvm_fatal("NO_CFG", "decode_env_configuration not found in config DB!")
	uvm_config_db#(decode_in_configuration)::set(this, "agent_in", "configuration", configuration.agent_in_configuration);
    uvm_config_db#(decode_out_configuration)::set(this, "agent_out", "configuration", configuration.agent_out_configuration);
		agent_in = decode_in_agent::type_id::create("agent_in", this);
		agent_out = decode_out_agent::type_id::create("agent_out", this);
		scoreboard = decode_scoreboard::type_id::create("scoreboard",this);
		predictor = decode_predictor::type_id::create("predictor",this);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		agent_in.ap.connect(predictor.analysis_export);
		predictor.predictor_ap.connect(scoreboard.expected_ae);
		agent_out.ap.connect(scoreboard.actual_ae);
	endfunction 

endclass