import lc3_prediction_pkg::*;
class decode_predictor extends uvm_subscriber #(decode_in_transaction);
	
	`uvm_component_utils(decode_predictor)
    decode_out_transaction t_out;
	uvm_analysis_port #(decode_out_transaction) predictor_ap;
	bit out;
	function new (string name = "decode_predictor", uvm_component parent);
		super.new(name,parent);	
		predictor_ap = new("predictor_ap",this);
	endfunction
	
	virtual function void write (decode_in_transaction t);
		t_out = new();
		out= decode_model(t.Imem_dout, t.npc_in, t_out.ir, t_out.npc_out, t_out.E_control, t_out.W_control, t_out.mem_control);
		predictor_ap.write (t_out);
		out=controller_model(.complete_data(t.complete_data),.complete_instr(t.complete_instr),.IR(t.IR),.psr(t.psr),.IR_Exec(t.IR_EXEC),.Imem_dout(t.Imem_dout),.NZP(t.NZP),.enable_updatePC(scoreboard_ap_output_transaction.enable_updatePC),.enable_fetch(scoreboard_ap_output_transaction.enable_fetch),.enable_decode(scoreboard_ap_output_transaction.enable_decode),.enable_execute(scoreboard_ap_output_transaction.enable_execute),.enable_writeback(scoreboard_ap_output_transaction.enable_writeback),.bypass_alu_1(scoreboard_ap_output_transaction.bypass_alu_1),.bypass_alu_2(scoreboard_ap_output_transaction.bypass_alu_2),.bypass_mem_1(scoreboard_ap_output_transaction.bypass_mem_1),.bypass_mem_2(scoreboard_ap_output_transaction.bypass_mem_2),.br_taken(scoreboard_ap_output_transaction.br_taken),.mem_state(scoreboard_ap_output_transaction.mem_state))
	endfunction
	
endclass