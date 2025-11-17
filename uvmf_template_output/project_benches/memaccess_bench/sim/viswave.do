 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { memaccess_in_agt }
wave add uvm_test_top.environment.memaccess_in_agt.memaccess_in_agt_monitor.txn_stream -radix string -tag F0
wave group memaccess_in_agt_bus
wave add -group memaccess_in_agt_bus hdl_top.memaccess_in_agt_bus.* -radix hexadecimal -tag F0
wave group memaccess_in_agt_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_out_agt }
wave add uvm_test_top.environment.memaccess_out_agt.memaccess_out_agt_monitor.txn_stream -radix string -tag F0
wave group memaccess_out_agt_bus
wave add -group memaccess_out_agt_bus hdl_top.memaccess_out_agt_bus.* -radix hexadecimal -tag F0
wave group memaccess_out_agt_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

