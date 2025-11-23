 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { fetch_fetch_in_agent }
wave add uvm_test_top.environment.fetch.fetch_in_agent.fetch_in_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_fetch_in_agent_bus
wave add -group fetch_fetch_in_agent_bus hdl_top.fetch_fetch_in_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_fetch_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_fetch_out_agent }
wave add uvm_test_top.environment.fetch.fetch_out_agent.fetch_out_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_fetch_out_agent_bus
wave add -group fetch_fetch_out_agent_bus hdl_top.fetch_fetch_out_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_fetch_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_memaccess_in_agent }
wave add uvm_test_top.environment.memaccess.memaccess_in_agent.memaccess_in_agent_monitor.txn_stream -radix string -tag F0
wave group memaccess_memaccess_in_agent_bus
wave add -group memaccess_memaccess_in_agent_bus hdl_top.memaccess_memaccess_in_agent_bus.* -radix hexadecimal -tag F0
wave group memaccess_memaccess_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_memaccess_out_agent }
wave add uvm_test_top.environment.memaccess.memaccess_out_agent.memaccess_out_agent_monitor.txn_stream -radix string -tag F0
wave group memaccess_memaccess_out_agent_bus
wave add -group memaccess_memaccess_out_agent_bus hdl_top.memaccess_memaccess_out_agent_bus.* -radix hexadecimal -tag F0
wave group memaccess_memaccess_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_control_in_agent }
wave add uvm_test_top.environment.control.control_in_agent.control_in_agent_monitor.txn_stream -radix string -tag F0
wave group control_control_in_agent_bus
wave add -group control_control_in_agent_bus hdl_top.control_control_in_agent_bus.* -radix hexadecimal -tag F0
wave group control_control_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_control_out_agent }
wave add uvm_test_top.environment.control.control_out_agent.control_out_agent_monitor.txn_stream -radix string -tag F0
wave group control_control_out_agent_bus
wave add -group control_control_out_agent_bus hdl_top.control_control_out_agent_bus.* -radix hexadecimal -tag F0
wave group control_control_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { imem_agent }
wave add uvm_test_top.environment.imem_agent.imem_agent_monitor.txn_stream -radix string -tag F0
wave group imem_agent_bus
wave add -group imem_agent_bus hdl_top.imem_agent_bus.* -radix hexadecimal -tag F0
wave group imem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { dmem_agent }
wave add uvm_test_top.environment.dmem_agent.dmem_agent_monitor.txn_stream -radix string -tag F0
wave group dmem_agent_bus
wave add -group dmem_agent_bus hdl_top.dmem_agent_bus.* -radix hexadecimal -tag F0
wave group dmem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

