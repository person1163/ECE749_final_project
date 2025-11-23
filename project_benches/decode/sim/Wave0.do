onerror resume
wave tags  sim
wave update off
wave zoom range 396 658
wave group Transaction -backgroundcolor #004466
wave add -group Transaction uvm_test_top.environment.agent_in.monitor.txn_stream -tag sim -radix string -expand -subitemconfig { opcode {-radix string} npc_in {-radix hexadecimal} {npc_in[15]} {-radix hexadecimal} {npc_in[14]} {-radix hexadecimal} {npc_in[13]} {-radix hexadecimal} {npc_in[12]} {-radix hexadecimal} {npc_in[11]} {-radix hexadecimal} {npc_in[10]} {-radix hexadecimal} {npc_in[9]} {-radix hexadecimal} {npc_in[8]} {-radix hexadecimal} {npc_in[7]} {-radix hexadecimal} {npc_in[6]} {-radix hexadecimal} {npc_in[5]} {-radix hexadecimal} {npc_in[4]} {-radix hexadecimal} {npc_in[3]} {-radix hexadecimal} {npc_in[2]} {-radix hexadecimal} {npc_in[1]} {-radix hexadecimal} {npc_in[0]} {-radix hexadecimal} Imem_dout {-radix hexadecimal} }
wave add -group Transaction uvm_test_top.environment.agent_out.monitor.txn_stream -tag sim -radix string -expand -subitemconfig { IR {-radix hexadecimal -select} npc_out {-radix hexadecimal -select} E_control {-radix hexadecimal -select} W_control {-radix hexadecimal -select} mem_control {-radix hexadecimal -select} } -select
wave insertion [expr [wave index insertpoint] + 1]
wave group hdl_top.dut -backgroundcolor #006666
wave add -group hdl_top.dut hdl_top.dut.clock -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.reset -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.enable_decode -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.dout -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.npc_in -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.Mem_Control -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.E_Control -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.W_Control -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.M_Control -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.inst_type -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.pc_store -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.mem_access_mode -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.load -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.pcselect1 -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.alu_control -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.pcselect2 -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.op2select -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.IR -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.npc_out -tag sim -radix hexadecimal
wave add -group hdl_top.dut hdl_top.dut.opcode -tag sim -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave update on
wave top 0
