p2_debug:
	qrun -64 -gui -visualizer -onfinish stop -classdebug -uvmcontrol=all -msgmode both -l run.log -f filelist.f -do "set IterationLimit 140000; set NoQuitOnFinish 1;run 0; do wavesim.do ; run -all ; coverage report -details " +UVM_TESTNAME=test_top -debug,livesim -qwavedb=+signal+report+memory=1024+transaction+class+uvm_schematic+msg+assertion+uvm_schematic+msg+classmemory=1024+statictaskfunc -top hdl_top -top hvl_top


clean:
	rm certe_dump.xml
	rm design.bin
	rm -rf qrun.out
	rm -rf .visualizer
	rm qwave.db
	rm run.log
